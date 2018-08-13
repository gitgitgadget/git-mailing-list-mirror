Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCD81F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbeHMOPZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42651 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbeHMOPY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so7520040pff.9
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3RZO33EJuEkhpQ303LFxkBggJ1Yo2lr0gVhOTFQ1G5Q=;
        b=IOIRS2SFBHAYxnbj7ht7Rk9TGdhMtNG4XA1qoAKh89PFMFuC6SFOsx6l3wGukYY90W
         2oKeCMAzNLYoZKmHgW9ljiQlXUYQmEdoD4PE2Q5GcU/ykT/tkrlnX/hlE3nYdluun0bi
         OjKdsb/JVIZ54YFBkLPM9ERAO+hGR5cEScvt/IwZ6z64DZ3B0yB71Rxl/b1juV9o+7e1
         COw5oXs9Gon6zb7t/YzRq/fJHTWLU4FhxTeDk8XduQ4p6gzu7qJNE4oyg4gH5F8f5hKA
         zirvRfsYjsjUJ/3C9dSOo+Z/Z407qXzA5gMXAvri3Xc4JjixegpW0lUprj4ZE7YxGYzt
         QUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3RZO33EJuEkhpQ303LFxkBggJ1Yo2lr0gVhOTFQ1G5Q=;
        b=qVGviWs3bPNLwnHsD41MmLfpYDFenkWAM/ST/AA/79HeObcjxdeAwX2Nt/WkKzmw2M
         I71jMrF6sT7hodZ7AbX/WPPzW3CG+7DX2R/g9eQbGiGngKhv2awlRO/rDemqPp4cWEdH
         KyfOXHiwDkZXS5MZcfAqhDRd3IAtKEBzsfJVVb1Sdew9K3XtCwlJ96YfamcRYgz9rDp8
         2a/KBoI9iMqIpfiFLX3oc+1bAzRemuB5jlq7UJeCnIn41ZBUus+v1r4l/V12CXBByhYM
         4VRordBeTguxGRkqW9e8FVKO3DcURM3KpgnVXtMg8llLfZHxQdAqM0I7DwIxJba1iHfE
         FEgg==
X-Gm-Message-State: AOUpUlEuuDWGZt5wLGBZ5IqsSl6L3NiTSi3cGSFlY+FwEEvYq/I0/YxP
        0ccaNHdb9M9VyxMjWso7u/t8nO5j
X-Google-Smtp-Source: AA+uWPzZN8pN3fff0pwVmmh3gWIDe2hdJYvL03FTtQujMP9dx/Er/pnHKa1rTHKJJTZ+l49U1Rcp1g==
X-Received: by 2002:a65:560a:: with SMTP id l10-v6mr16952970pgs.130.1534160011386;
        Mon, 13 Aug 2018 04:33:31 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id a15-v6sm29158978pfe.32.2018.08.13.04.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:30 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:30 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:55 GMT
Message-Id: <f6fd3955eba9cf0f647c53bead92a810b4dd70fa.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 20/21] range-diff: make --dual-color the default mode
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
index bebb47d42..82c71c682 100644
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
index 5a9ad82fb..f52d45d9d 100644
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
@@ -63,8 +63,10 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
 			     builtin_range_diff_usage, 0);
 
-	if (dual_color) {
-		diffopt.use_color = 1;
+	if (simple_color < 1) {
+		if (!simple_color)
+			/* force color when --dual-color was used */
+			diffopt.use_color = 1;
 		diffopt.flags.dual_color_diffed_diffs = 1;
 	}
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3d4ec3432..d63d2dffd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1981,7 +1981,7 @@ _git_range_diff ()
 	case "$cur" in
 	--*)
 		__gitcomp "
-			--creation-factor= --dual-color
+			--creation-factor= --no-dual-color
 			$__git_diff_common_options
 		"
 		return
-- 
gitgitgadget

