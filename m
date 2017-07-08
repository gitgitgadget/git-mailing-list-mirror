Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D1C202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 20:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbdGHUkZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 16:40:25 -0400
Received: from mail.eclipso.de ([217.69.254.104]:48984 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751833AbdGHUkY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 16:40:24 -0400
Received: from localhost.localdomain (136.ip-92-222-84.eu [92.222.84.136])
        by mail.eclipso.de with ESMTPS id 4CE36625
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 22:35:21 +0200 (CEST)
X-ESMTP-Authenticated-User: 00022B69
From:   astian <astian@eclipso.at>
To:     git@vger.kernel.org
Cc:     astian <astian@eclipso.at>
Subject: [PATCH 4/4] Doc/config.txt: fix documentation for smtpEncryption
Date:   Sat,  8 Jul 2017 20:34:13 +0000
Message-Id: <20170708203413.16442-5-astian@eclipso.at>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170708203413.16442-1-astian@eclipso.at>
References: <20170708203413.16442-1-astian@eclipso.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop saying that smtpEncryption (a configuration variable used by
git-send-email) is not usable in "sendemail.<identity>" subsections,
because that's false.

Signed-off-by: astian <astian@eclipso.at>
---
 Documentation/config.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5c9c4cab..f40758c31 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2899,10 +2899,6 @@ sendemail.identity::
 	values in the 'sendemail' section. The default identity is
 	the value of `sendemail.identity`.
 
-sendemail.smtpEncryption::
-	See linkgit:git-send-email[1] for description.  Note that this
-	setting is not subject to the 'identity' mechanism.
-
 sendemail.smtpssl (deprecated)::
 	Deprecated alias for 'sendemail.smtpEncryption = ssl'.
 
@@ -2933,6 +2929,7 @@ sendemail.suppresscc::
 sendemail.suppressFrom::
 sendemail.to::
 sendemail.smtpDomain::
+sendemail.smtpEncryption::
 sendemail.smtpServer::
 sendemail.smtpServerPort::
 sendemail.smtpServerOption::
-- 
2.13.2



