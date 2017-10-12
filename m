Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9EF20467
	for <e@80x24.org>; Thu, 12 Oct 2017 09:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbdJLJAV (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 05:00:21 -0400
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:45668 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751434AbdJLJAU (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 05:00:20 -0400
Received: from resomta-po-06v.sys.comcast.net ([96.114.154.230])
        by resqmta-po-06v.sys.comcast.net with ESMTP
        id 2ZLoeBc4xfyfN2ZLoe1EXu; Thu, 12 Oct 2017 09:00:20 +0000
Received: from mail.tremily.us ([IPv6:2001:558:600a:ce:480b:3bd8:dc5a:403a])
        by resomta-po-06v.sys.comcast.net with SMTP
        id 2ZLneKPBu14XP2ZLnebk5y; Thu, 12 Oct 2017 09:00:20 +0000
Received: from ullr.tremily.us (ullr.tremily.us [192.168.10.7])
        by mail.tremily.us (Postfix) with SMTP id 95E25FED5DC;
        Thu, 12 Oct 2017 02:00:47 -0700 (PDT)
Received: (nullmailer pid 14623 invoked by uid 1000);
        Thu, 12 Oct 2017 09:02:19 -0000
From:   "W. Trevor King" <wking@tremily.us>
To:     Git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] Documentation/merge-options.txt: Add -S/--gpg-sign
Date:   Thu, 12 Oct 2017 02:02:17 -0700
Message-Id: <406769a31421cb26a0e1bcf6e15bcf7ab48617c8.1507798709.git.wking@tremily.us>
X-Mailer: git-send-email 2.13.6
X-CMAE-Envelope: MS4wfLAk9LkKS+o20UzqOq1hbJWvMGg8eDhJmG0wmNqvoBD71w1UmFSArwxGX98F5z5qHVRCykPXRicALF1HB+QO4VUfQq7S/gT+5pufVRTm7NR85vZT5zNz
 CPFNApubABDQXGbCSkEmiUK5doL0Vdp33ECS8v7x/90Qrc5jMQsHGnT0kPp8TzWYxun1jZvEnRTrWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pull has supported these since ea230d8 (pull: add the --gpg-sign
option, 2014-02-10).  Insert in long-option alphabetical order
following 7c85d274 (Documentation/merge-options.txt: order options in
alphabetical groups, 2009-10-22).

Signed-off-by: W. Trevor King <wking@tremily.us>
---
This patch is based on maint.  It will have trivial conflicts with the
--signoff docs which landed in 14d01b4f07 (merge: add a --signoff
flag, 2017-07-04, v2.15.0-rc0~138^2).

 Documentation/git-merge.txt     | 6 ------
 Documentation/merge-options.txt | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index f90faf7aaa..1d97a17904 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -64,12 +64,6 @@ OPTIONS
 -------
 include::merge-options.txt[]
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
-	GPG-sign the resulting merge commit. The `keyid` argument is
-	optional and defaults to the committer identity; if specified,
-	it must be stuck to the option without a space.
-
 -m <msg>::
 	Set the commit message to be used for the merge commit (in
 	case one is created).
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 5b4a62e936..6d85a76872 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -42,6 +42,12 @@ set to `no` at the beginning of them.
 	current `HEAD` is already up-to-date or the merge can be
 	resolved as a fast-forward.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+	GPG-sign the resulting merge commit. The `keyid` argument is
+	optional and defaults to the committer identity; if specified,
+	it must be stuck to the option without a space.
+
 --log[=<n>]::
 --no-log::
 	In addition to branch names, populate the log message with
-- 
2.13.6

