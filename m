Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFCAC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04F92070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfK0Mxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:53:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:33846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726282AbfK0Mxp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 07:53:45 -0500
Received: (qmail 11058 invoked by uid 109); 27 Nov 2019 12:53:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 12:53:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9829 invoked by uid 111); 27 Nov 2019 12:57:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 07:57:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 07:53:43 -0500
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: [PATCH 1/2] doc: recommend lore.kernel.org over public-inbox.org
Message-ID: <20191127125343.GA27983@sigill.intra.peff.net>
References: <20191127125231.GH22221@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191127125231.GH22221@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since lore.kernel.org now has the same archive as public-inbox.org and
may have more longevity going forward[1], let's recommend people use it
for finding or referencing messages.

[1] https://public-inbox.org/git/20191120195556.GA25189@dcvr/
      or if you like:
    https://lore.kernel.org/git/20191120195556.GA25189@dcvr/

Signed-off-by: Jeff King <peff@peff.net>
---
And it's one character shorter. Think of all of the bytes saved!

 Documentation/MyFirstContribution.txt | 2 +-
 Documentation/git.txt                 | 2 +-
 README.md                             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 5e9b808f5f..5922803d87 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -970,7 +970,7 @@ reviewers the changes you've made that may not be as visible.
 You will also need to go and find the Message-Id of your previous cover letter.
 You can either note it when you send the first series, from the output of `git
 send-email`, or you can look it up on the
-https://public-inbox.org/git[mailing list]. Find your cover letter in the
+https://lore.kernel.org/git[mailing list]. Find your cover letter in the
 archives, click on it, then click "permalink" or "raw" to reveal the Message-Id
 header. It should match:
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9b82564d1a..5f5b85ba27 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -928,7 +928,7 @@ Reporting Bugs
 Report bugs to the Git mailing list <git@vger.kernel.org> where the
 development and maintenance is primarily done.  You do not have to be
 subscribed to the list to send a message there.  See the list archive
-at https://public-inbox.org/git for previous bug reports and other
+at https://lore.kernel.org/git for previous bug reports and other
 discussions.
 
 Issues which are security relevant should be disclosed privately to
diff --git a/README.md b/README.md
index e1d2b82209..9d4564c8aa 100644
--- a/README.md
+++ b/README.md
@@ -35,7 +35,7 @@ requests, comments and patches to git@vger.kernel.org (read
 [Documentation/SubmittingPatches][] for instructions on patch submission).
 To subscribe to the list, send an email with just "subscribe git" in
 the body to majordomo@vger.kernel.org. The mailing list archives are
-available at <https://public-inbox.org/git/>,
+available at <https://lore.kernel.org/git/>,
 <http://marc.info/?l=git> and other archival sites.
 
 Issues which are security relevant should be disclosed privately to
-- 
2.24.0.778.ge5f6c7a838

