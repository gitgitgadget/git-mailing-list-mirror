Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79CE20954
	for <e@80x24.org>; Wed, 22 Nov 2017 13:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbdKVNL2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 08:11:28 -0500
Received: from mailer.zib.de ([130.73.108.11]:40400 "EHLO mailer.zib.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbdKVNL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 08:11:28 -0500
X-Greylist: delayed 15176 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Nov 2017 08:11:27 EST
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
        by mailer.zib.de (8.14.5/8.14.5) with ESMTP id vAM8wSSj005171;
        Wed, 22 Nov 2017 09:58:28 +0100 (CET)
Received: from vsl4.zib.de (vsl4.zib.de [130.73.69.14])
        by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id vAM8wRIl005143;
        Wed, 22 Nov 2017 09:58:27 +0100 (CET)
From:   Steffen Prohaska <prohaska@zib.de>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/1] doc: Mention info/attributes in gitrepository-layout
Date:   Wed, 22 Nov 2017 09:58:14 +0100
Message-Id: <20171122085814.8563-1-prohaska@zib.de>
X-Mailer: git-send-email 2.13.0.5.g81ff6f4130
X-Miltered: at mailer.zib.de with ID 5A153C34.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5A153C34.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 5A153C34.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/gitrepository-layout.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index adf9554ad2..c60bcad44a 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -208,6 +208,10 @@ info/exclude::
 	'git clean' look at it but the core Git commands do not look
 	at it.  See also: linkgit:gitignore[5].
 
+info/attributes::
+	Defines which attributes to assign to a path, similar to per-directory
+	`.gitattributes` files.   See also: linkgit:gitattributes[5].
+
 info/sparse-checkout::
 	This file stores sparse checkout patterns.
 	See also: linkgit:git-read-tree[1].
-- 
2.15.0.5.g43a9009988

