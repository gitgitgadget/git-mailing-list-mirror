Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 473181F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeGUW7a (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40048 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbeGUW7a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so9541023pgp.7
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gCGiyNvemL1Uh5YD+9x380Agf8UHmC6pLILJBvkoBS4=;
        b=MKXk3s0+pnK/rpD2doX0+fX6mU6MWD9WlWKaWFIBdGjQ36IvxrrsCgKjBXm2QSeb8o
         g3fDqe0+kmgELzRRTdfse8Nb+2dHVsh2mPtuw9ocucXWQzhRFaXnEEe0Uzj8vczdMY6t
         u978W70WpjDEBcvdJ41G7HdT3HAkHafoONOtnm4fvbekW6HuUqsNzw2E4SZI+jArbl0Q
         DsQL8o2BRIaEKhThJNu52R27omg0p2TDAS6w9E1IOUCClbiMAjGo9x21VyNzSX4fCsT7
         6VVcG9BKRaWmTNdHNBd3uspLbvXIg7/iyxjlbTp3L4+3cfJpoMsLUDnRMzu8uaNC4OBH
         MkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gCGiyNvemL1Uh5YD+9x380Agf8UHmC6pLILJBvkoBS4=;
        b=KXo+wiuZvaByY9jzsvYE1/R1X31rO22yIOsJS1rc0WvIlDAxnadop9Ut6n4JB4s7Nz
         8GG2sk193Jmui3cAeCPWBxzwerSliA/66J5LLoAVWQHsUPSxHjrHWW8BVOa94D4KFLZ2
         y/z1G2+omyfhE/Ya1NqT7oVodtuhfHacCVa4XTBEZ3KP4saVs4EvHupzywVkUFxpQNMX
         5pqdxSW1/G/7ZoFX6WEjt15s2K/5K/qZ4Zzexo3HGyUTJhQh6V7+MIcWSrO1rBbKnNbo
         ic/WRXWaWtgYv3ep4weBYMlhLZ7drA2Ea7H/nuCZvNVixlRiwYXbTAjpC6CEz81K0yKM
         cpfQ==
X-Gm-Message-State: AOUpUlElkiGqh7H/XNusj47TqVfxHtr/3WDhPuYUb5drL0lzMhqBtdrn
        3YtkaPHGE3JTw/wATg6pTAW1zYV5
X-Google-Smtp-Source: AAOMgpcxFTgsLbDoM66+tQ1ZfOeFmz595tbEHh+FmpM2HDDMSnDGgC6N0kSItBzRJ65gIlFKFanBPg==
X-Received: by 2002:a62:cd3:: with SMTP id 80-v6mr7412237pfm.184.1532210713452;
        Sat, 21 Jul 2018 15:05:13 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id v6-v6sm9422388pfa.28.2018.07.21.15.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:05:12 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:05:12 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:41 GMT
Message-Id: <b370468e71af2b8c7ffa0e31f3a3910d15897ab4.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 20/21] range-diff: make --dual-color the default mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

After using this command extensively for the last two months, this
developer came to the conclusion that even if the dual color mode still
leaves a lot of room for confusion about what was actually changed, the
non-dual color mode is substantially worse in that regard.

Therefore, we really want to make the dual color mode the default.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt       | 32 +++++++++++++++-----------
 builtin/range-diff.c                   | 10 ++++----
 contrib/completion/git-completion.bash |  2 +-
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index f1a6737f8..e3c0be559 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
-	[--dual-color] [--creation-factor=<factor>]
+	[--no-dual-color] [--creation-factor=<factor>]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
 
 DESCRIPTION
@@ -31,11 +31,14 @@ all of their ancestors have been shown.
 
 OPTIONS
 -------
---dual-color::
-	When the commit diffs differ, recreate the original diffs'
-	coloring, and add outer -/+ diff markers with the *background*
-	being red/green to make it easier to see e.g. when there was a
-	change in what exact lines were added.
+--no-dual-color::
+	When the commit diffs differ, `git range-diff` recreates the
+	original diffs' coloring, and adds outer -/+ diff markers with
+	the *background* being red/green to make it easier to see e.g.
+	when there was a change in what exact lines were added. This is
+	known to `range-diff` as "dual coloring". Use `--no-dual-color`
+	to revert to color all lines according to the outer diff markers
+	(and completely ignore the inner diff when it comes to color).
 
 --creation-factor=<percent>::
 	Set the creation/deletion cost fudge factor to `<percent>`.
@@ -118,15 +121,16 @@ line (with a perfect match) is yellow like the commit header of `git
 show`'s output, and the third line colors the old commit red, the new
 one green and the rest like `git show`'s commit header.
 
-The color-coded diff is actually a bit hard to read, though, as it
-colors the entire lines red or green. The line that added "What is
-unexpected" in the old commit, for example, is completely red, even if
-the intent of the old commit was to add something.
+A naive color-coded diff of diffs is actually a bit hard to read,
+though, as it colors the entire lines red or green. The line that added
+"What is unexpected" in the old commit, for example, is completely red,
+even if the intent of the old commit was to add something.
 
-To help with that, use the `--dual-color` mode. In this mode, the diff
-of diffs will retain the original diff colors, and prefix the lines with
--/+ markers that have their *background* red or green, to make it more
-obvious that they describe how the diff itself changed.
+To help with that, `range` uses the `--dual-color` mode by default. In
+this mode, the diff of diffs will retain the original diff colors, and
+prefix the lines with -/+ markers that have their *background* red or
+green, to make it more obvious that they describe how the diff itself
+changed.
 
 
 Algorithm
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index c25d88317..77ac3bff7 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -20,11 +20,11 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = 60;
 	struct diff_options diffopt = { NULL };
-	int dual_color = 0;
+	int simple_color = -1;
 	struct option options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
-		OPT_BOOL(0, "dual-color", &dual_color,
+		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("color both diff and diff-between-diffs")),
 		OPT_END()
 	};
@@ -55,8 +55,10 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	argc = j;
 	diff_setup_done(&diffopt);
 
-	if (dual_color) {
-		diffopt.use_color = 1;
+	if (simple_color < 1) {
+		if (!simple_color)
+			/* force color when --dual-color was used */
+			diffopt.use_color = 1;
 		diffopt.flags.dual_color_diffed_diffs = 1;
 	}
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 402490673..e35fc28fc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1981,7 +1981,7 @@ _git_range_diff ()
   case "$cur" in
   --*)
           __gitcomp "
-	  	--creation-factor= --dual-color
+	  	--creation-factor= --no-dual-color
                   $__git_diff_common_options
                   "
           return
-- 
gitgitgadget

