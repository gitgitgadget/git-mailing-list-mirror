Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5620B1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 15:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeJEWx4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 18:53:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37881 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeJEWx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 18:53:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so4927448pgq.4
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u2O1x5RTgZU6DzyIardyZnGeRy1Elnou4XQ6H2xNgVc=;
        b=VaIJy6Ne5v+m8dWuH4FCFBgCmwKA/SqjHoR5CiQfoFJKkC0OEFLvNkxLX7o7vzsPPp
         RZGn/v6KlGNcw1sY8cysXjd/4vyUHlo0Bi9YZ4+bHvhYMrhg7dbCudTOxQhyLjG2ciO6
         f9ZkwpZtLE1eyJxqjbdpBfxEfd7kDxy2VdVJ1NX+MVLaZ9R+vL/B4Y9BuHOSSwVlC6lR
         p0K8Mw7US2NvQzXdYOe6+dmQQ+3tkHqkEoTujjjLx8DfgrDE1Umj7KIePdJY29np/d8S
         Kdw9mlt+ZMKGlIq5v4T0u63F0CsdHweJqzC/BgvWd3LfTm2gH3ddQWMGWBPeicDKiYCI
         o7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u2O1x5RTgZU6DzyIardyZnGeRy1Elnou4XQ6H2xNgVc=;
        b=lb3lVOzpN43rlmGLeD6Y321M4ESIhjqrQy8yzL+CScQ3Twr9hIlG6vv8WccI2i4csp
         g9oA7M759muRMAxIeab4AxhCLPe677a3ZCgqI6gOpEpFYphSOxu8boDDaaOA7tuTWz+e
         /H3bqzSAgHyPY2bkUClKM3vOKTfsaCb5Ts2fEo+8RiaQwBPz30IXuXAbg2Ju0Em3hRDG
         gTLpkx2xgfxENvMUq8AECLo/3RelPkLT621kfry7EL60gZ5it7GlpJiMQL+YfurCyA56
         +Z6cSGsvqnOXsR+3yzg76tOVJzy6sPh9ScIdft4bUL5npaUu4S9dgQPN5s9OuqBQSwre
         Uz0w==
X-Gm-Message-State: ABuFfoiwvreM1McKpU8DP4gpcRITRl3s5aD5mcmoWznntHVO/RbAkahS
        euaScDKTZ8Jw/cjbhnoFe7ORrjum
X-Google-Smtp-Source: ACcGV63hYEIkPTx0FN323hAbxFS1t3HWyXbNMa7U2gGiD+iG/RND8EWrHXsDmEcgpvAPUpN19PUKjA==
X-Received: by 2002:a63:2356:: with SMTP id u22-v6mr2251630pgm.122.1538754877324;
        Fri, 05 Oct 2018 08:54:37 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id r18-v6sm10614439pgj.51.2018.10.05.08.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:54:36 -0700 (PDT)
Date:   Fri, 05 Oct 2018 08:54:36 -0700 (PDT)
X-Google-Original-Date: Fri, 05 Oct 2018 15:54:33 GMT
Message-Id: <pull.23.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.23.v2.git.gitgitgadget@gmail.com>
References: <pull.23.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/1] Teach the builtin rebase about the builtin interactive rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The builtin rebase and the builtin interactive rebase have been developed
independently, on purpose: Google Summer of Code rules specifically state
that students have to work on independent projects, they cannot collaborate
on the same project.

The reason is probably the very fine tradition in academia to prohibit
teamwork, which makes grading easier (at the expense of not exactly
preparing the students for the real world, unless they want to stay in
academia).

One fallout is that the rebase-in-c and rebase-i-in-c patches cause no merge
conflicts but a royal number of tests in the test suite to fail.

It is easy to explain why: rebase-in-c was developed under the assumption
that all rebase backends are implemented in Unix shell script and can be
sourced via . git-rebase--<backend>, which is no longer true with 
rebase-i-in-c, where git-rebase--interactive is a hard-linked builtin.

This patch fixes that.

Note: while this patch targets pk/rebase-in-c-6-final, it will not work
correctly without ag/rebase-i-in-c. So my suggestion is to rewrite the 
pk/rebas-in-c-6-final branch by first merging ag/rebase-i-in-c, then
applying this here patch, and only then cherry-pick "rebase: default to
using the builtin rebase".

Changes since v2:

 * Prepare for the break command, by skipping the call to finish_rebase() 
   for interactive rebases altogether (the built-in interactive rebase
   already takes care of that).
 * Remove a no-longer-used case arm (skipped by the newly-introduced code).

Changes since v1:

 * replaced the too-terse commit message by a copy-edited version of this
   cover letter (leaving out only the rant about disallowing teamwork).

Johannes Schindelin (1):
  builtin rebase: prepare for builtin rebase -i

 builtin/rebase.c | 87 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 4 deletions(-)


base-commit: 67e0df2f391ec4177942a4d8b70e530aa5653c0d
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-23%2Fdscho%2Frebase-in-c-6-final-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-23/dscho/rebase-in-c-6-final-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/23

Range-diff vs v2:

 1:  5403014be7 ! 1:  db1652ef3e builtin rebase: prepare for builtin rebase -i
     @@ -18,6 +18,15 @@
      
          This patch fixes that.
      
     +    Please note that we also skip the finish_rebase() call for interactive
     +    rebases because the built-in interactive rebase already takes care of
     +    that. This is needed to support the upcoming `break` command that wants
     +    to interrupt the rebase with exit code 0 (and naturally wants to keep
     +    the state directory intact when doing so).
     +
     +    While at it, remove the `case` arm for the interactive rebase that is
     +    now skipped in favor of the short-cut to the built-in rebase.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
     @@ -117,6 +126,17 @@
       	add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
       	add_var(&script_snippet, "state_dir", opts->state_dir);
       
     +@@
     + 		backend = "git-rebase--am";
     + 		backend_func = "git_rebase__am";
     + 		break;
     +-	case REBASE_INTERACTIVE:
     +-		backend = "git-rebase--interactive";
     +-		backend_func = "git_rebase__interactive";
     +-		break;
     + 	case REBASE_MERGE:
     + 		backend = "git-rebase--merge";
     + 		backend_func = "git_rebase__merge";
      @@
       	argv[0] = script_snippet.buf;
       
     @@ -124,4 +144,8 @@
      +finished_rebase:
       	if (opts->dont_finish_rebase)
       		; /* do nothing */
     ++	else if (opts->type == REBASE_INTERACTIVE)
     ++		; /* interactive rebase cleans up after itself */
       	else if (status == 0) {
     + 		if (!file_exists(state_dir_path("stopped-sha", opts)))
     + 			finish_rebase(opts);

-- 
gitgitgadget
