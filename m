Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87151FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 21:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbdALVc7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 16:32:59 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:64686 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbdALVc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 16:32:57 -0500
Received: from localhost.localdomain ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id RmzJcW0LO0KuvRmzKcL1f4; Thu, 12 Jan 2017 21:32:51 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=xtxXYLxNAAAA:8 a=voM4FWlXAAAA:8
 a=Q6rNvsX9vjT9MdlOpYkA:9 a=xts0dhWdiJbonKbuqhAr:22 a=IC2XNlieTeVoXbcui8wp:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 2/3] doc: gitk: add the upstream repo location
Date:   Thu, 12 Jan 2017 21:32:39 +0000
Message-Id: <20170112213240.7972-3-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
In-Reply-To: <20170112213240.7972-1-philipoakley@iee.org>
References: <20170112213240.7972-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfJq661CK5rzFtxf/HNxdnR+uJHxznZCS8i9amgf0TX0QVowY3zC3OgbkJToJedW1gAseHBXSTkv2VIf94NFswGgcOzKAIPvQSk3fb4S5XaUcocB2AA7u
 eacLwmq34InnDKmkamGc2lwYV6SY9rb8itItRxdmXCl1hkg4KXwBgN54GRIx5W8fSDsTfC7rm4Pa2I/A22wNPt/93NzJcZI8uE2O6h9W5qJnJrmZ50mG8Vvg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Match the 'git gui' information regarding the graphical browser
and its upstream location.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
cc: Paul Mackerras <paulus@ozlabs.org>
---
 Documentation/gitk.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 73c02b9..9244379 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -178,9 +178,15 @@ used by default. If '$XDG_CONFIG_HOME' is not set it defaults to
 History
 -------
 Gitk was the first graphical repository browser. It's written in
-tcl/tk and started off in a separate repository but was later merged
-into the main Git repository.
+tcl/tk.
 
+'gitk' is actually maintained as an independent project, but stable
+versions are distributed as part of the Git suite for the convenience
+of end users.
+
+gitk-git/ comes from Paul Mackerras's gitk project:
+
+        git://ozlabs.org/~paulus/gitk
 
 SEE ALSO
 --------
-- 
2.9.0.windows.1.323.g0305acf

