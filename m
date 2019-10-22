Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4501F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 21:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbfJVVW4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 17:22:56 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40103 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbfJVVW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 17:22:56 -0400
Received: by mail-wm1-f47.google.com with SMTP id b24so17499774wmj.5
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Ke5e2417Rew8yFWtza+r3UEGuzTbWwCVT3dWfznpL8=;
        b=NHaCuB0IfD4CDeQ3Hb/zZTgYR4b6NFVaAbh/UCiqOfhag5ffRC1tjt/N7JBIsDKUvl
         p5uGO9UAzBu4Ma2A7g+KpUuCaOe2TU72piN2qorpVEWnPXaMpASgYd1PnEeX2N/H327V
         A9KeczneMp+YoRRQSmdldbJMZ8HDBBIQEOmtA/duPfPQ6idoRPKJcwcwnRCicaZV0T99
         Gxj36iaD9INTNqcGpYiTQvA7MO7VjWKIh6M6szPj4+3q+LhJjAnU+Af9WUR3HCYaTEKV
         X1n6oIDVweuEf+/zeFP1ZLd2dnfBJ+YeIRP+dGvVaJOOrEJ6KVpTVsxq5fl5Kq3fegHo
         QC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Ke5e2417Rew8yFWtza+r3UEGuzTbWwCVT3dWfznpL8=;
        b=cDcgiJMtCDvaH8DxYT0PhrV6/m8TOZz46CMmBXiWTYnO16IDD2rGEfx+r82yCAHvxE
         Bt+O+PB/yB0dXuxaFZmFLNON28kE6Bq9yhDlacDBeTOGuJ7Dvo/UPmjDHySjjxSSjfGL
         OLBpjNkIwkOGRHeFNJ8YC77hCQVyMGj5GkJiF9Iy/P7kz0wsg5iK0U172p381xawqfd5
         m/5fHuR84YTw72ZztxXS6ZgXrSsYMiiz4PveDTed0ECPjgX1EZvx/CMvmS5u/5d50SYB
         fMFHysGbzbj900e3MhbhOwdCldxL/BDzXrsghl40K69z5LubOuMlNc/vNvbobVXyHXJ0
         ReEQ==
X-Gm-Message-State: APjAAAUVCC2UxOOZ1m0hU8PM9EFttKpfAcqOWBktDQBPApsc7pbMdvDE
        XD9Z8cOom/9sMa0kNxBCrxk08fGl
X-Google-Smtp-Source: APXvYqyXpE+lQ5IbBEUndhyRbPMrXkWS4M0HSubDhxq5U4nbDHOWEckj1AsoQfYhroGXehIxUCHyIg==
X-Received: by 2002:a05:600c:21d7:: with SMTP id x23mr4677996wmj.6.1571779372784;
        Tue, 22 Oct 2019 14:22:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm15745694wmd.22.2019.10.22.14.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 14:22:52 -0700 (PDT)
Message-Id: <pull.390.v2.git.1571779371.gitgitgadget@gmail.com>
In-Reply-To: <pull.390.git.gitgitgadget@gmail.com>
References: <pull.390.git.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 21:22:48 +0000
Subject: [PATCH v2 0/3] Dir rename fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin Johannes.Schindelin@gmx.de,
        Junio C Hamano <gitster@pobox.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     Johannes Schindelin Johannes.Schindelin@gmx.de
                        ^                           ^-missing end of address
                 \-extraneous tokens in address
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series improves a couple things found after looking into things Dscho
flagged:

 * clarify and slightly restructure code in the get_renamed_dir_portion()
   function
 * extend support of detecting renaming/merging of one directory into
   another to support the root directory as a target directory

First patch best viewed with a --histogram diff (sorry, gitgitgadget does
not yet know how to generate those).

Changes since v1:

 * Incorporated code cleanups suggested by Dscho
 * Fixed to work with an alternate rename-to-root-directory case (end_of_new
   == NULL), with new testcase
 * Added a new patch to the end of the series to stop making setup tests be
   part of a separate test_expect_success block.

Elijah Newren (3):
  merge-recursive: clean up get_renamed_dir_portion()
  merge-recursive: fix merging a subdirectory into the root directory
  t604[236]: do not run setup in separate tests

 merge-recursive.c                      | 104 ++++-
 t/t6042-merge-rename-corner-cases.sh   | 111 +++--
 t/t6043-merge-rename-directories.sh    | 568 ++++++++++++++++---------
 t/t6046-merge-skip-unneeded-updates.sh | 135 +++---
 4 files changed, 582 insertions(+), 336 deletions(-)


base-commit: 08da6496b61341ec45eac36afcc8f94242763468
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-390%2Fnewren%2Fdir-rename-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-390/newren/dir-rename-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/390

Range-diff vs v1:

 1:  8ae78679c9 = 1:  8ae78679c9 merge-recursive: clean up get_renamed_dir_portion()
 2:  37aee862e1 ! 2:  a1e80e8fbb merge-recursive: fix merging a subdirectory into the root directory
     @@ -34,9 +34,41 @@
       	strbuf_grow(&new_path, newlen);
       	strbuf_addbuf(&new_path, &entry->new_dir);
      @@
     - 	    *end_of_old == *end_of_new)
     - 		return; /* We haven't modified *old_dir or *new_dir yet. */
     + 	 */
     + 	end_of_old = strrchr(old_path, '/');
     + 	end_of_new = strrchr(new_path, '/');
     +-	if (end_of_old == NULL || end_of_new == NULL)
     +-		return; /* We haven't modified *old_dir or *new_dir yet. */
     ++
     ++	/*
     ++	 * If end_of_old is NULL, old_path wasn't in a directory, so there
     ++	 * could not be a directory rename (our rule elsewhere that a
     ++	 * directory which still exists is not considered to have been
     ++	 * renamed means the root directory can never be renamed -- because
     ++	 * the root directory always exists).
     ++	 */
     ++	if (end_of_old == NULL)
     ++		return; /* Note: *old_dir and *new_dir are still NULL */
     ++
     ++	/*
     ++	 * If new_path contains no directory (end_of_new is NULL), then we
     ++	 * have a rename of old_path's directory to the root directory.
     ++	 */
     ++	if (end_of_new == NULL) {
     ++		*old_dir = xstrndup(old_path, end_of_old - old_path);
     ++		*new_dir = xstrdup("");
     ++		return;
     ++	}
       
     + 	/* Find the first non-matching character traversing backwards */
     + 	while (*--end_of_new == *--end_of_old &&
     +@@
     + 	 */
     + 	if (end_of_old == old_path && end_of_new == new_path &&
     + 	    *end_of_old == *end_of_new)
     +-		return; /* We haven't modified *old_dir or *new_dir yet. */
     ++		return; /* Note: *old_dir and *new_dir are still NULL */
     ++
      +	/*
      +	 * If end_of_new got back to the beginning of its string, and
      +	 * end_of_old got back to the beginning of some subdirectory, then
     @@ -44,21 +76,19 @@
      +	 * needs slightly special handling.
      +	 *
      +	 * Note: There is no need to consider the opposite case, with a
     -+	 * rename/merge of the root directory into some subdirectory.
     -+	 * Our rule elsewhere that a directory which still exists is not
     -+	 * considered to have been renamed means the root directory can
     -+	 * never be renamed (because the root directory always exists).
     ++	 * rename/merge of the root directory into some subdirectory
     ++	 * because as noted above the root directory always exists so it
     ++	 * cannot be considered to be renamed.
      +	 */
      +	if (end_of_new == new_path &&
      +	    end_of_old != old_path && end_of_old[-1] == '/') {
     -+		*old_dir = xstrndup(old_path, end_of_old-1 - old_path);
     -+		*new_dir = xstrndup(new_path, end_of_new - new_path);
     ++		*old_dir = xstrndup(old_path, --end_of_old - old_path);
     ++		*new_dir = xstrdup("");
      +		return;
      +	}
     -+
     + 
       	/*
       	 * We've found the first non-matching character in the directory
     - 	 * paths.  That means the current characters we were looking at
      
       diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
       --- a/t/t6043-merge-rename-directories.sh
     @@ -68,18 +98,18 @@
       '
       
      +# Testcase 12d, Rename/merge of subdirectory into the root
     -+#   Commit O: a/b/{foo.c}
     -+#   Commit A: foo.c
     -+#   Commit B: a/b/{foo.c,bar.c}
     -+#   Expected: a/b/{foo.c,bar.c}
     ++#   Commit O: a/b/subdir/foo
     ++#   Commit A: subdir/foo
     ++#   Commit B: a/b/subdir/foo, a/b/bar
     ++#   Expected: subdir/foo, bar
      +
     -+test_expect_success '12d-setup: Rename (merge) of subdirectory into the root' '
     ++test_expect_success '12d-setup: Rename/merge subdir into the root, variant 1' '
      +	test_create_repo 12d &&
      +	(
      +		cd 12d &&
      +
      +		mkdir -p a/b/subdir &&
     -+		test_commit a/b/subdir/foo.c &&
     ++		test_commit a/b/subdir/foo &&
      +
      +		git branch O &&
      +		git branch A &&
     @@ -87,16 +117,16 @@
      +
      +		git checkout A &&
      +		mkdir subdir &&
     -+		git mv a/b/subdir/foo.c.t subdir/foo.c.t &&
     ++		git mv a/b/subdir/foo.t subdir/foo.t &&
      +		test_tick &&
      +		git commit -m "A" &&
      +
      +		git checkout B &&
     -+		test_commit a/b/bar.c
     ++		test_commit a/b/bar
      +	)
      +'
      +
     -+test_expect_success '12d-check: Rename (merge) of subdirectory into the root' '
     ++test_expect_success '12d-check: Rename/merge subdir into the root, variant 1' '
      +	(
      +		cd 12d &&
      +
     @@ -108,18 +138,76 @@
      +		test_line_count = 2 out &&
      +
      +		git rev-parse >actual \
     -+			HEAD:subdir/foo.c.t   HEAD:bar.c.t &&
     ++			HEAD:subdir/foo.t   HEAD:bar.t &&
     ++		git rev-parse >expect \
     ++			O:a/b/subdir/foo.t  B:a/b/bar.t &&
     ++		test_cmp expect actual &&
     ++
     ++		git hash-object bar.t >actual &&
     ++		git rev-parse B:a/b/bar.t >expect &&
     ++		test_cmp expect actual &&
     ++
     ++		test_must_fail git rev-parse HEAD:a/b/subdir/foo.t &&
     ++		test_must_fail git rev-parse HEAD:a/b/bar.t &&
     ++		test_path_is_missing a/ &&
     ++		test_path_is_file bar.t
     ++	)
     ++'
     ++
     ++# Testcase 12e, Rename/merge of subdirectory into the root
     ++#   Commit O: a/b/foo
     ++#   Commit A: foo
     ++#   Commit B: a/b/foo, a/b/bar
     ++#   Expected: foo, bar
     ++
     ++test_expect_success '12e-setup: Rename/merge subdir into the root, variant 2' '
     ++	test_create_repo 12e &&
     ++	(
     ++		cd 12e &&
     ++
     ++		mkdir -p a/b &&
     ++		test_commit a/b/foo &&
     ++
     ++		git branch O &&
     ++		git branch A &&
     ++		git branch B &&
     ++
     ++		git checkout A &&
     ++		mkdir subdir &&
     ++		git mv a/b/foo.t foo.t &&
     ++		test_tick &&
     ++		git commit -m "A" &&
     ++
     ++		git checkout B &&
     ++		test_commit a/b/bar
     ++	)
     ++'
     ++
     ++test_expect_success '12e-check: Rename/merge subdir into the root, variant 2' '
     ++	(
     ++		cd 12e &&
     ++
     ++		git checkout A^0 &&
     ++
     ++		git -c merge.directoryRenames=true merge -s recursive B^0 &&
     ++
     ++		git ls-files -s >out &&
     ++		test_line_count = 2 out &&
     ++
     ++		git rev-parse >actual \
     ++			HEAD:foo.t   HEAD:bar.t &&
      +		git rev-parse >expect \
     -+			O:a/b/subdir/foo.c.t  B:a/b/bar.c.t &&
     ++			O:a/b/foo.t  B:a/b/bar.t &&
      +		test_cmp expect actual &&
      +
     -+		git hash-object bar.c.t >actual &&
     -+		git rev-parse B:a/b/bar.c.t >expect &&
     ++		git hash-object bar.t >actual &&
     ++		git rev-parse B:a/b/bar.t >expect &&
      +		test_cmp expect actual &&
      +
     -+		test_must_fail git rev-parse HEAD:a/b/subdir/foo.c.t &&
     -+		test_must_fail git rev-parse HEAD:a/b/bar.c.t &&
     -+		test_path_is_missing a/
     ++		test_must_fail git rev-parse HEAD:a/b/foo.t &&
     ++		test_must_fail git rev-parse HEAD:a/b/bar.t &&
     ++		test_path_is_missing a/ &&
     ++		test_path_is_file bar.t
      +	)
      +'
      +
 -:  ---------- > 3:  0dd61a3580 t604[236]: do not run setup in separate tests

-- 
gitgitgadget
