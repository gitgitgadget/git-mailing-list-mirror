Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6035B1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 18:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeJQCFK (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 22:05:10 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:43958 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCFK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 22:05:10 -0400
Received: by mail-io1-f73.google.com with SMTP id y6-v6so22388417ioc.10
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FQ/Vu/5lapoXlYTYa5eLz65bN7+V7hDv8z2TMW07zrY=;
        b=OiwEf4ULIAG3z+/zdGkC9uWOVLaKtv5Ge9krN4qwtVOKO8+DGqEPKt4BBD7/MzclOw
         /UVQKB7HFqO7gJh6ty5clH8wsrbUMy/mwJq1ztjgwWC3fWJIBOpzYAcQDIPbrGXtGIzu
         z1IHcxn2FXgdVBZR3Qh2fZEDAwHWqUtlqgnOIPK2RXKEHyHYKnmqMndRcQ1nyYm5ABdg
         WkRAyZfPVCHdXaGz1Ysl79ruS93p+3PsnB//JmCxBI12R8wqoDtznEmBdPsm1UqaT2bX
         2pkuLYtXEFTLP4ibVChCuxgXApf/e968sang0Hq3qpqrKKZYGnOjjG8mK+Q/9YBj3Dpf
         MUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FQ/Vu/5lapoXlYTYa5eLz65bN7+V7hDv8z2TMW07zrY=;
        b=MMd90caqfLMR/gaXGxiYKK6g+xH1BHVwAFkvO1ClBHMz3r0YiBw70H03Zy1DG35tMj
         XGshdGYbL/KrXyae/2mtZSMJK8SZIqjd0F6BQCeQ2nmRehh2EMiy38D7tNty14DlcHfM
         9AFVe2wWruSYsH9rylLrrmAjwpmWfrVgxbXS502XtpV03QfHiLp5DFzW2MRuGoLtqpOx
         KAsmTRW/pyrmS8MIie/7G3SkmsWL1ePfmMNBzHFR6JoDW+t3QQ3PX7t/3p/JSk3iGRl8
         vXD12Mbf+habhH/dNjY4YT+AFANthfMwUokgPXIz/hX1NvQZZ5zbXsD9XMLThKMlV5Lw
         wFiw==
X-Gm-Message-State: ABuFfohW3fyl/PHQ+hC4sW5ZZQfXv32p9PuJwKuvr9hH6lrtx0/KKhzH
        awszw0ViK0HUD46Qbc0YGVKi95zYYjSM
X-Google-Smtp-Source: ACcGV62WXtC3x2XOXtIhdBiW8XkxpnmmDn+F8Q3Lx5axIT9eyxdqdIwwIcq8ANdtFRI+BxVDkKy3SqiM++RW
X-Received: by 2002:a24:992:: with SMTP id 140-v6mr8147529itm.3.1539713610361;
 Tue, 16 Oct 2018 11:13:30 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:13:18 -0700
Message-Id: <20181016181327.107186-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 0/9] Resending sb/submodule-recursive-fetch-gets-the-tip
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ao/submodule-wo-gitmodules-checked-out.

This resends origin/sb/submodule-recursive-fetch-gets-the-tip, resolving
the issues pointed out via origin/xxx/sb-submodule-recursive-fetch-gets-the-tip-in-pu
by basing this series on origin/ao/submodule-wo-gitmodules-checked-out

A range-diff below shows how picking a different base changed the patches,
apart from that no further adjustments have been made.

Thanks,
Stefan

Stefan Beller (9):
  sha1-array: provide oid_array_filter
  submodule.c: fix indentation
  submodule.c: sort changed_submodule_names before searching it
  submodule.c: move global changed_submodule_names into fetch submodule
    struct
  submodule.c: do not copy around submodule list
  repository: repo_submodule_init to take a submodule struct
  submodule: fetch in submodules git directory instead of in worktree
  fetch: retry fetching submodules if needed objects were not fetched
  builtin/fetch: check for submodule updates for non branch fetches

 Documentation/technical/api-oid-array.txt    |   5 +
 builtin/fetch.c                              |  14 +-
 builtin/grep.c                               |  17 +-
 builtin/ls-files.c                           |  12 +-
 repository.c                                 |  27 +-
 repository.h                                 |  11 +-
 sha1-array.c                                 |  17 ++
 sha1-array.h                                 |   3 +
 submodule.c                                  | 275 +++++++++++++++----
 t/helper/test-submodule-nested-repo-config.c |   8 +-
 t/t5526-fetch-submodules.sh                  |  23 +-
 11 files changed, 315 insertions(+), 97 deletions(-)

git range-diff origin/xxx/sb-submodule-recursive-fetch-gets-the-tip-in-pu...
[...]
585:  ac1f98a0df <   -:  ---------- doc: move git-rev-parse from porcelain to plumbing
586:  7cf1a0fbef =   1:  a035323c49 sha1-array: provide oid_array_filter
587:  01077381d0 =   2:  30ed20b4f0 submodule.c: fix indentation
588:  4b0cdf5899 =   3:  cd590ea88d submodule.c: sort changed_submodule_names before searching it
589:  78e5099ecc !   4:  ce959811ba submodule.c: move global changed_submodule_names into fetch submodule struct
    @@ -12,7 +12,7 @@
     --- a/submodule.c
     +++ b/submodule.c
     @@
    - #include "commit-reach.h"
    + #include "object-store.h"
      
      static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
     -static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
590:  d813f18bb3 =   5:  151f9a8ad4 submodule.c: do not copy around submodule list
591:  a077d63af7 !   6:  3a97743fa2 repository: repo_submodule_init to take a submodule struct
    @@ -15,7 +15,6 @@
         Also move its documentation into the header file.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/builtin/grep.c b/builtin/grep.c
     --- a/builtin/grep.c
    @@ -31,12 +30,16 @@
     +
      	int hit;
      
    - 	if (!is_submodule_active(superproject, path))
    + 	/*
    +@@
      		return 0;
    + 	}
      
    --	if (repo_submodule_init(&submodule, superproject, path))
    -+	if (repo_submodule_init(&subrepo, superproject, sub))
    +-	if (repo_submodule_init(&submodule, superproject, path)) {
    ++	if (repo_submodule_init(&subrepo, superproject, sub)) {
    + 		grep_read_unlock();
      		return 0;
    + 	}
      
     -	repo_read_gitmodules(&submodule);
     +	repo_read_gitmodules(&subrepo);
    @@ -44,9 +47,9 @@
      	/*
      	 * NEEDSWORK: This adds the submodule's object directory to the list of
     @@
    + 	 * store is no longer global and instead is a member of the repository
      	 * object.
      	 */
    - 	grep_read_lock();
     -	add_to_alternates_memory(submodule.objects->objectdir);
     +	add_to_alternates_memory(subrepo.objects->objectdir);
      	grep_read_unlock();
    @@ -100,19 +103,6 @@
      
      static void show_ce(struct repository *repo, struct dir_struct *dir,
     
    -diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
    ---- a/builtin/submodule--helper.c
    -+++ b/builtin/submodule--helper.c
    -@@
    - 	if (!sub)
    - 		BUG("We could get the submodule handle before?");
    - 
    --	if (repo_submodule_init(&subrepo, the_repository, path))
    -+	if (repo_submodule_init(&subrepo, the_repository, sub))
    - 		die(_("could not get a repository handle for submodule '%s'"), path);
    - 
    - 	if (!repo_config_get_string(&subrepo, "core.worktree", &cw)) {
    -
     diff --git a/repository.c b/repository.c
     --- a/repository.c
     +++ b/repository.c
    @@ -197,3 +187,32 @@
      void repo_clear(struct repository *repo);
      
      /*
    +
    +diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
    +--- a/t/helper/test-submodule-nested-repo-config.c
    ++++ b/t/helper/test-submodule-nested-repo-config.c
    +@@
    + 
    + int cmd__submodule_nested_repo_config(int argc, const char **argv)
    + {
    +-	struct repository submodule;
    ++	struct repository subrepo;
    ++	const struct submodule *sub;
    + 
    + 	if (argc < 3)
    + 		die_usage(argc, argv, "Wrong number of arguments.");
    + 
    + 	setup_git_directory();
    + 
    +-	if (repo_submodule_init(&submodule, the_repository, argv[1])) {
    ++	sub = submodule_from_path(the_repository, &null_oid, argv[1]);
    ++	if (repo_submodule_init(&subrepo, the_repository, sub)) {
    + 		die_usage(argc, argv, "Submodule not found.");
    + 	}
    + 
    + 	/* Read the config of _child_ submodules. */
    +-	print_config_from_gitmodules(&submodule, argv[2]);
    ++	print_config_from_gitmodules(&subrepo, argv[2]);
    + 
    + 	submodule_free(the_repository);
    + 
592:  780f6c1a92 =   7:  4e8ad61f8d submodule: fetch in submodules git directory instead of in worktree
593:  a530535912 =   8:  24bac00db7 fetch: retry fetching submodules if needed objects were not fetched
594:  a72bde3a8a =   9:  e031182e44 builtin/fetch: check for submodule updates for non branch fetches
[...]
