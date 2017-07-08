Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EDF6202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 20:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbdGHUkK (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 16:40:10 -0400
Received: from mail.eclipso.de ([217.69.254.104]:48984 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbdGHUkK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 16:40:10 -0400
Received: from localhost.localdomain (136.ip-92-222-84.eu [92.222.84.136])
        by mail.eclipso.de with ESMTPS id 34B655A2
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 22:35:08 +0200 (CEST)
X-ESMTP-Authenticated-User: 00022B69
From:   astian <astian@eclipso.at>
To:     git@vger.kernel.org
Cc:     astian <astian@eclipso.at>
Subject: [PATCH 2/4] Doc/config.txt: fix typos
Date:   Sat,  8 Jul 2017 20:34:11 +0000
Message-Id: <20170708203413.16442-3-astian@eclipso.at>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170708203413.16442-1-astian@eclipso.at>
References: <20170708203413.16442-1-astian@eclipso.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: astian <astian@eclipso.at>
---
 Documentation/config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5c9c4cab..72e85b002 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -60,7 +60,7 @@ The variable names are case-insensitive, allow only alphanumeric characters
 and `-`, and must start with an alphabetic character.
 
 A line that defines a value can be continued to the next line by
-ending it with a `\`; the backquote and the end-of-line are
+ending it with a `\`; the backslash and the end-of-line are
 stripped.  Leading whitespaces after 'name =', the remainder of the
 line after the first comment character '#' or ';', and trailing
 whitespaces of the line are discarded unless they are enclosed in
@@ -2912,7 +2912,7 @@ sendemail.smtpsslcertpath::
 
 sendemail.<identity>.*::
 	Identity-specific versions of the 'sendemail.*' parameters
-	found below, taking precedence over those when the this
+	found below, taking precedence over those when this
 	identity is selected, through command-line or
 	`sendemail.identity`.
 
-- 
2.13.2



