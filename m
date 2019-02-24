Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9BB20248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfBXKLS (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:18 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43718 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfBXKLS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:18 -0500
Received: by mail-ed1-f47.google.com with SMTP id m35so5189555ede.10
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EP2zFJDRrh26AiNYAdrunEAJ9OgOZx+G79UiFcQGbOc=;
        b=KkoPJ13T/a1aIpYimyB+nrgHhN40lz1Mzm/CX8lK/i3+cVMlTlzh1vtEY3YDliO2mA
         wy5xAmmuO6N79DJWGQte9lS+m0NGmwQ64sLiXbjJn7IFHmX3FCJuebxeSp2X734jb3KK
         db5Ff6FY3aPcO8mv+NHjr6Czcq/3g5qiuO2Ie2vavvtxqqYnsy70iUQ8FlaWvS3NY6mi
         qc6c2Prokao+DG2fb1Y+Jn9yBmt6zXlKaUIW3JdDGlATKGfu1zzbTvb9lpcogv9RUc7d
         w1MNGd9jRQzZ6nF45VsBWu/4+MzukEXYlhX0Is9PzQrI+f2HUudtFEE3JPDMjo1gT8CR
         oZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EP2zFJDRrh26AiNYAdrunEAJ9OgOZx+G79UiFcQGbOc=;
        b=ZoJetAp6yeA9LRirNHeaGwuoy5jlqakkGLTNnuSek7/UzL79OW7WZxbUjkObEt8MND
         +oAKqcnnDBbPKJU2vyKSjnXquIgNeKbggO80bXHh8T9zv0LMOoB8b3d/CZ1ejWHzUbTM
         9Ur8OgGj/v9pLYZ2mv+S8vm6DxVVMHEpHnG8X5iEdMKOaOgl5Vy1Su9bckA/YTnwqSrL
         +zXKflVrwNnsy2vhmJr/58uAYBY/OzCxCyv/bj2DlnGZOtm55WA/DYgMmf6ouHicP4WP
         X05Xw1JcEUsbkW1Ik95IguFB63TQOlse20qMbPWKaWFj7cRBbn0ClzRuNILEb8cym4I8
         cyig==
X-Gm-Message-State: AHQUAuYYKwZqAWOwO6nv4JObfE73meFIM6oNKPe14lt6iXZVwj+yxLV9
        liDJGHmuRZy6vgoufJ1uDNbcsjtx
X-Google-Smtp-Source: AHgI3IajKcZQ5CeSvVX2rkvV8KR6XY4tvrpppWHCEFJmIyqlTpEBR68ib+o83GI4eCC+Vo8ga7lqwQ==
X-Received: by 2002:a50:d2d7:: with SMTP id q23mr10420911edg.120.1551003075611;
        Sun, 24 Feb 2019 02:11:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b22sm1796234edb.5.2019.02.24.02.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:15 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:15 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:48 GMT
Message-Id: <pull.117.git.gitgitgadget@gmail.com>
From:   "Tanushree Tumane via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/26] Git bisect part3
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

Changes since pranit’s v15 patch series
=======================================

bisect--helper: refer branch.buf before strbuf_release(...)
===========================================================

bisect--helper: change retval to res
====================================

bisect--helper: decide_next() helper function.
==============================================

bisect--helper: bisect_next and bisect_auto_next shell function in C
====================================================================

Divided this commit into nine commits
=====================================

 1.  bisect.c: libify exit_if_skipped_commits to error_if_skipped...
 2.  bisect.c: libify bisect_checkout and its dependants
 3.  bisect.c: libify check_merge_bases and its dependents.
 4.  bisect.c: libify check_good_are_ancestors_of_bad and its dependents
 5.  bisect.c: libify handle_bad_merge_base and its dependants
 6.  bisect.c: libify bisect_next_all and its dependants
 7.  bisect--helper: bisect_next and bisect_auto_next shell function in C
 8.  bisect--helper: Finish bisect_start() conversion
 9.  bisect--helper: dequote arguments in bisect-start
     
     
 10. changed error to return error 
     
     
 11. Removed goto done; as it was present just before done: call
 12. Use xstrdup(argv[i]) instead of argv[i] to prevent memory leak
 13. Adjusted the indentation Style: removed a space left of the comma.
 14. Changed the find the next bisection state statement to ‘checkout the
     next bisection commit’
 15. Changed ‘sha1_to_hex’ to ‘oid_to_hex’ as modern code does not use this
     unsigned function
 16. Changed the return type from ‘void’ to ‘int’ as the function was
     returning a value
 17. Changed ‘const unsigned sha1’ to ‘struct object_id oid’
 18. Changed (res == 10) branch and the (res == 2) branch into separate
     functions bisect_successful(struct bisect_terms *terms) and 
     bisect_skipped_commits(struct bisect_terms *terms)respectively and just
     call them.
 19. Removed unnecessary comments
 20. Changed exit code to return type like exit(2) to return 2; and 
     exit(res) to return res;
 21. Changed handle_bad_merge_base(); to declare res =
     handle_skipped_merge_base(mb);
 22. Changed bisect_start to git bisect--helper --bisect-start 

bisect--helper: retire --bisect-clean-state subcommand
======================================================

bisect--helper: retire --next-all subcommand
============================================

bisect--helper: retire --check-expected-revs subcommand
=======================================================

bisect--helper: retire --write-terms subcommand
===============================================

bisect--helper: retire --bisect-write subcommand
================================================

bisect--helper: retire --bisect-autostart subcommand
====================================================

bisect--helper: retire --bisect-auto-next subcommand
====================================================

bisect--helper: retire --check-and-set-terms subcommand
=======================================================

bisect--helper: bisect_autostart shell function in C
====================================================

 * Use STDIN_FINENO instead of 0.
 * Fix typo THe to The
 * Use return 1 instead of exit(0). Sayingno` is same outcome as not having
   a tty to ask for yes or no.
 * Add missing is in N_("start the bisection if BISECT_START empty or
   missing"), BISECT_AUTOSTART),
 * use set_terms()
 * die(“...”) to return error(“...”)

bisect--helper: bisect_state & bisect_head shell function in C
==============================================================

 * move get_terms() to cmd_bisect__helper()
 * die(“...”) to return error(“...”)
 * use oid instead of sha1. convert dependant functions also.
 * check_expected_revs() returns void, remove if around it.
 * use set_terms()

bisect--helper: bisect_log shell function in C
==============================================

 * use STDOUT_FILENO instead of 1.
 * die(“...”) to return error(“...”)

bisect--helper: bisect_replay shell function in C
=================================================

 * use “cannot read file '%s' for replaying” error message instead of “no
   such file with name '%s' exists”, as it would be misleading if the file
   exists but is empty. 
 * starts_with(word.buf, "#") would be more accurate and can also handle
   cases where user edited the file and accidently removed <space> between #
   bad….
 * bisect_terms() now accepts terms and option. 
 * use more informative error message : “Replay file contains rubbish
   ("%s")”
 * remove unnecessary goto finish
 * die(“...”) to return error(“...”)
 * use set_terms()

bisect--helper: remove the dequote in bisect_start()
====================================================

bisect--helper: bisect_skip shell function in C
===============================================

Pranit Bauva (23):
  bisect.c: libify `exit_if_skipped_commits` to `error_if_skipped...`
  bisect.c: libify `bisect_checkout` and its dependants
  bisect.c: libify `check_merge_bases` and its dependents.
  bisect.c: libify `check_good_are_ancestors_of_bad` and its dependents
  bisect.c: libify `handle_bad_merge_base` and its dependants
  bisect.c: libify `bisect_next_all` and its dependants
  bisect--helper: `bisect_next` and `bisect_auto_next` shell function in
    C
  bisect--helper: Finish `bisect_start()` conversion
  bisect--helper: dequote arguments in `bisect-start`
  bisect--helper: retire `--bisect-clean-state` subcommand
  bisect--helper: retire `--next-all` subcommand
  bisect--helper: `bisect_autostart` shell function in C
  bisect--helper: `bisect_state` & `bisect_head` shell function in C
  bisect--helper: retire `--check-expected-revs` subcommand
  bisect--helper: retire `--write-terms` subcommand
  bisect--helper: `bisect_log` shell function in C
  bisect--helper: `bisect_replay` shell function in C
  bisect--helper: retire `--bisect-write` subcommand
  bisect--helper: retire `--bisect-autostart` subcommand
  bisect--helper: retire `--bisect-auto-next` subcommand
  bisect--helper: remove the dequote in bisect_start()
  bisect--helper: `bisect_skip` shell function in C
  bisect--helper: retire `--check-and-set-terms` subcommand

Tanushree Tumane (3):
  bisect--helper: refer branch.buf before strbuf_release(...)
  bisect--helper: change `retval` to `res`
  bisect--helper: `decide_next()` helper function.

 bisect.c                 | 140 ++++++---
 builtin/bisect--helper.c | 654 ++++++++++++++++++++++++++++++++-------
 git-bisect.sh            | 196 +-----------
 3 files changed, 649 insertions(+), 341 deletions(-)


base-commit: 06f5608c14e6972748b84649d5b8ffd335bbd209
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-117%2Ftanushree27%2Fgit-bisect-part3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-117/tanushree27/git-bisect-part3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/117
-- 
gitgitgadget
