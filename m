Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C671F437
	for <e@80x24.org>; Fri, 27 Jan 2017 20:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdA0U0S (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 15:26:18 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:28955 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdA0U0J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 15:26:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id BFE411E2E2F;
        Fri, 27 Jan 2017 21:02:41 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0nKIIgLvdSat; Fri, 27 Jan 2017 21:02:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id F22C51E2FBA;
        Fri, 27 Jan 2017 21:02:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1y1HUYxKInFg; Fri, 27 Jan 2017 21:02:40 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-252.dynamic.mnet-online.de [185.17.206.252])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 88B641E2E2F;
        Fri, 27 Jan 2017 21:02:40 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     gitster@pobox.com, philipoakley@iee.org, sbeller@google.com
Cc:     git@vger.kernel.org, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH] doc: clarify distinction between sign-off and pgp-signing
Date:   Fri, 27 Jan 2017 21:01:36 +0100
Message-Id: <20170127200136.29949-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

The documentation for submission discourages pgp-signing, but demands
a proper sign-off by contributors. However, when skimming the headings,
the wording of the section for sign-off could mistakenly be understood
as concerning pgp-signing. Thus, new contributors could oversee the
necessary sign-off.

This commit improves the wording such that the section about sign-off
cannot be misunderstood as pgp-signing. In addition, the paragraph about
pgp-signing is changed such that it avoids the impression that
pgp-signing could be relevant at later stages of the submission.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    This patch summarizes the suggested changes.
    
    As I don't know what is appropriate, I took the liberty to add everybody's
    sign-off who was involved in the discussion in alphabetic order.

 Documentation/SubmittingPatches | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 08352de..3faf7eb 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -216,12 +216,11 @@ that it will be postponed.
 Exception:  If your mailer is mangling patches then someone may ask
 you to re-send them using MIME, that is OK.
 
-Do not PGP sign your patch, at least for now.  Most likely, your
-maintainer or other people on the list would not have your PGP
-key and would not bother obtaining it anyway.  Your patch is not
-judged by who you are; a good patch from an unknown origin has a
-far better chance of being accepted than a patch from a known,
-respected origin that is done poorly or does incorrect things.
+Do not PGP sign your patch. Most likely, your maintainer or other people on the
+list would not have your PGP key and would not bother obtaining it anyway.
+Your patch is not judged by who you are; a good patch from an unknown origin
+has a far better chance of being accepted than a patch from a known, respected
+origin that is done poorly or does incorrect things.
 
 If you really really really really want to do a PGP signed
 patch, format it as "multipart/signed", not a text/plain message
@@ -246,7 +245,7 @@ patch.
      *2* The mailing list: git@vger.kernel.org
 
 
-(5) Sign your work
+(5) Certify your work by adding your "Signed-off-by: " line
 
 To improve tracking of who did what, we've borrowed the
 "sign-off" procedure from the Linux kernel project on patches
-- 
2.10.2

