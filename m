Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677AB20248
	for <e@80x24.org>; Tue, 26 Feb 2019 22:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfBZWs7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 17:48:59 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36842 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfBZWs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 17:48:59 -0500
Received: by mail-ed1-f65.google.com with SMTP id g9so12263679eds.3
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 14:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P5+X1l9bm0SfcQrL6XbOTg1dPpWueoNwuKMPmEMOEbY=;
        b=OMT32YB2LEfHqlf8RbaiN6G2NbuJXkQtDzO6hkBT0Tb3/77S46jbxiJQahHqs3im/D
         TKzjp0UYFITiOFK2YxZvqPQTp28I8mx8vOYCqEuXzAunXaYd4prks50eqlqjxD3tmrgI
         xqu2Vptgs7BuR1hd0aXAwaojBaP53n2tmjnw7xdbGE1XMLf/HoltptzZxhtJu+fzbzEs
         WhKjGHgPTcTpUDmwfjCfp+6oRHbJ1gNn74ogO+z/p6SPjZAYBQGZAzJWAuXMtlVD86jv
         +tnqjskBS8NngETfmLxwvPFUWNmgkpvanb3nZdbLB15N7Vbr595Ar7UasoxVg9tzGpF0
         fPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P5+X1l9bm0SfcQrL6XbOTg1dPpWueoNwuKMPmEMOEbY=;
        b=C5h2ZyWUaBf74Jl/Iyhw+uSjY0AOZoj/RTcHDEoQTGQmk2d9BVSRxwTW8aHq2eFPpa
         GLZNTrMBaUuYapbVtcFHyyg3wATYGW0eEEZh+3mPKW9SG8mE2WMaze6WH8og7UbPMEDZ
         EC1sgQvhRzOIfp1szol5vcvqI16vlGDzdzPL0B7044xVv2uYTxnsnP9ee7AbE87X1it2
         pInUzvjDIxhZVsNUWoX3nxek0kW93btsUsyv67YIaho7q4LpLPpObPIEQaHXnpgRXJrq
         CxsSnZxOKCqICk4r3X3TgDMu2bQZQCR8PM6jKNhOH98Wv3pRyfJuv9hbStgEZ6WhGoFX
         2DjQ==
X-Gm-Message-State: AHQUAuYYjlaFhXWtVU6ouaKgHmFiZ/GBYSgYs515xzC1HR9+M8dwaW7u
        oCYPk9xqlKjlsrxBkEtRbUWKxykf
X-Google-Smtp-Source: AHgI3IYwJMUzhS57xPV6/czMKVSKEsiIkVtvSdycZFdRyKMsqhoQfFKnyQEa1J+akjL/AuodGkNOwg==
X-Received: by 2002:a17:906:49c7:: with SMTP id w7mr18584243ejv.226.1551221335603;
        Tue, 26 Feb 2019 14:48:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z23sm3777519edz.50.2019.02.26.14.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 14:48:55 -0800 (PST)
Date:   Tue, 26 Feb 2019 14:48:55 -0800 (PST)
X-Google-Original-Date: Tue, 26 Feb 2019 22:48:53 GMT
Message-Id: <pull.152.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.152.v2.git.gitgitgadget@gmail.com>
References: <pull.152.v2.git.gitgitgadget@gmail.com>
From:   "Rohit Ashiwal via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/1] [GSoC][PATCH] t3600: use test_path_is_* helper functions
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

Replace test -(d|f|e) calls in t3600-rm.sh. Previously we were using test
-(d|f|e) to verify the presence of a directory/file, but we already have
helper functions, viz, test_path_is_dir, test_path_is_file and
test_path_is_missing with better functionality.

Rohit Ashiwal (1):
  t3600: use test_path_is_* functions

 t/t3600-rm.sh | 138 +++++++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 69 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-152%2Fr1walz%2Frefactor-tests-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-152/r1walz/refactor-tests-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/152

Range-diff vs v2:

 1:  fcafc87b38 ! 1:  bfeba25c88 t3600: use test_path_is_dir and test_path_is_file
     @@ -1,12 +1,14 @@
      Author: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
      
     -    t3600: use test_path_is_dir and test_path_is_file
     +    t3600: use test_path_is_* functions
      
     -    Previously we were using `test -(d|f)` to verify
     +    Replace `test -(d|f|e)` calls in t3600-rm.sh
     +
     +    Previously we were using `test -(d|f|e)` to verify
          the presence of a directory/file, but we already
     -    have helper functions, viz, `test_path_is_dir`
     -    and `test_path_is_file` with better functionality.
     -    This patch will replace `test -(d|f)` calls in t3660.sh
     +    have helper functions, viz, `test_path_is_dir`,
     +    `test_path_is_file` and `test_path_is_missing`
     +    with better functionality.
      
          These helper functions make code more readable
          and informative to someone new to code, also
     @@ -18,6 +20,15 @@
       --- a/t/t3600-rm.sh
       +++ b/t/t3600-rm.sh
      @@
     + 
     + test_expect_success \
     +     'Post-check that bar does not exist and is not in index after "git rm -f bar"' \
     +-    '! [ -f bar ] && test_must_fail git ls-files --error-unmatch bar'
     ++    'test_path_is_missing bar && test_must_fail git ls-files --error-unmatch bar'
     + 
     + test_expect_success \
     +     'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' \
     +@@
       test_expect_success 'Modify foo -- rm should refuse' '
       	echo >>foo &&
       	test_must_fail git rm foo baz &&
     @@ -28,6 +39,15 @@
       	git ls-files --error-unmatch foo baz
       '
       
     + test_expect_success 'Modified foo -- rm -f should work' '
     + 	git rm -f foo baz &&
     +-	test ! -f foo &&
     +-	test ! -f baz &&
     ++	test_path_is_missing foo &&
     ++	test_path_is_missing baz &&
     + 	test_must_fail git ls-files --error-unmatch foo &&
     + 	test_must_fail git ls-files --error-unmatch bar
     + '
      @@
       
       test_expect_success 'foo is different in index from HEAD -- rm should refuse' '
     @@ -39,6 +59,15 @@
       	git ls-files --error-unmatch foo baz
       '
       
     + test_expect_success 'but with -f it should work.' '
     + 	git rm -f foo baz &&
     +-	test ! -f foo &&
     +-	test ! -f baz &&
     ++	test_path_is_missing foo &&
     ++	test_path_is_missing baz &&
     + 	test_must_fail git ls-files --error-unmatch foo &&
     + 	test_must_fail git ls-files --error-unmatch baz
     + '
      @@
       
       test_expect_success 'Recursive without -r fails' '
     @@ -62,20 +91,56 @@
       	git rm -f -r frotz &&
      -	! test -f frotz/nitfol &&
      -	! test -d frotz
     -+	! test_path_is_file frotz/nitfol &&
     -+	! test_path_is_dir frotz
     ++	test_path_is_missing frotz/nitfol &&
     ++	test_path_is_missing frotz
       '
       
       test_expect_success 'Remove nonexistent file returns nonzero exit status' '
     +@@
     + 	git reset --hard &&
     + 	test-tool chmtime -86400 frotz/nitfol &&
     + 	git rm frotz/nitfol &&
     +-	test ! -f frotz/nitfol
     ++	test_path_is_missing frotz/nitfol
     + 
     + '
     + 
      @@
       	echo content >dir/subdir/subsubdir/file &&
       	git add dir/subdir/subsubdir/file &&
       	git rm -f dir/subdir/subsubdir/file &&
      -	! test -d dir
     -+	! test_path_is_dir dir
     ++	test_path_is_missing dir
       '
       
       cat >expect <<EOF
     +@@
     + 	git add .gitmodules &&
     + 	git commit -m "add submodule" &&
     + 	git rm submod &&
     +-	test ! -e submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual &&
     + 	test_must_fail git config -f .gitmodules submodule.sub.url &&
     +@@
     + 	git reset --hard &&
     + 	git submodule update &&
     + 	git rm submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual &&
     + 	test_must_fail git config -f .gitmodules submodule.sub.url &&
     +@@
     + 	git reset --hard &&
     + 	git submodule update &&
     + 	git rm submod/ &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual
     + '
      @@
       	git submodule update &&
       	git -C submod checkout HEAD^ &&
     @@ -87,6 +152,11 @@
       	git status -s -uno --ignore-submodules=none >actual &&
       	test_cmp expect.modified actual &&
       	git rm -f submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual &&
     + 	test_must_fail git config -f .gitmodules submodule.sub.url &&
      @@
       	git reset --hard &&
       	git submodule update &&
     @@ -113,8 +183,8 @@
       	test_must_be_empty actual.err &&
      -	! test -d submod &&
      -	! test -f submod/.git &&
     -+	! test_path_is_dir submod &&
     -+	! test_path_is_file submod/.git &&
     ++	test_path_is_missing submod &&
     ++	test_path_is_missing submod/.git &&
       	git status -s -uno >actual &&
       	test_cmp expect.both_deleted actual
       '
     @@ -132,8 +202,8 @@
       	test_must_be_empty actual.err &&
      -	! test -d submod &&
      -	! test -f submod/.git &&
     -+	! test_path_is_dir submod &&
     -+	! test_path_is_file submod/.git &&
     ++	test_path_is_missing submod &&
     ++	test_path_is_missing submod/.git &&
       	git status -s -uno >actual &&
       	test_cmp expect actual
       '
     @@ -143,8 +213,8 @@
       	test_i18ncmp expect.err actual.err &&
      -	! test -d submod &&
      -	! test -f submod/.git &&
     -+	! test_path_is_dir submod &&
     -+	! test_path_is_file submod/.git &&
     ++	test_path_is_missing submod &&
     ++	test_path_is_missing submod/.git &&
       	git status -s -uno >actual &&
       	test_cmp expect actual
       '
     @@ -159,6 +229,11 @@
       	git status -s -uno --ignore-submodules=none >actual &&
       	test_cmp expect.modified_inside actual &&
       	git rm -f submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual
     + '
      @@
       	git submodule update &&
       	echo X >submod/untracked &&
     @@ -170,6 +245,20 @@
       	git status -s -uno --ignore-submodules=none >actual &&
       	test_cmp expect.modified_untracked actual &&
       	git rm -f submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual
     + '
     +@@
     + 	git submodule update &&
     + 	test_must_fail git merge conflict2 &&
     + 	git rm submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual
     + '
      @@
       	git -C submod checkout HEAD^ &&
       	test_must_fail git merge conflict2 &&
     @@ -181,6 +270,11 @@
       	git status -s -uno --ignore-submodules=none >actual &&
       	test_cmp expect.conflict actual &&
       	git rm -f submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual &&
     + 	test_must_fail git config -f .gitmodules submodule.sub.url &&
      @@
       	echo X >submod/empty &&
       	test_must_fail git merge conflict2 &&
     @@ -192,6 +286,11 @@
       	git status -s -uno --ignore-submodules=none >actual &&
       	test_cmp expect.conflict actual &&
       	git rm -f submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual &&
     + 	test_must_fail git config -f .gitmodules submodule.sub.url &&
      @@
       	echo X >submod/untracked &&
       	test_must_fail git merge conflict2 &&
     @@ -203,6 +302,11 @@
       	git status -s -uno --ignore-submodules=none >actual &&
       	test_cmp expect.conflict actual &&
       	git rm -f submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual
     + '
      @@
       	) &&
       	test_must_fail git merge conflict2 &&
     @@ -221,18 +325,36 @@
       	git status -s -uno --ignore-submodules=none >actual &&
       	test_cmp expect.conflict actual &&
       	git merge --abort &&
     +@@
     + 	git reset --hard &&
     + 	test_must_fail git merge conflict2 &&
     + 	git rm submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual
     + '
      @@
       		rm -r ../.git/modules/sub
       	) &&
       	git rm submod 2>output.err &&
      -	! test -d submod &&
      -	! test -d submod/.git &&
     -+	! test_path_is_dir submod &&
     -+	! test_path_is_dir submod/.git &&
     ++	test_path_is_missing submod &&
     ++	test_path_is_missing submod/.git &&
       	git status -s -uno --ignore-submodules=none >actual &&
       	test -s actual &&
       	test_i18ngrep Migrating output.err
      @@
     + 
     + test_expect_success 'rm recursively removes work tree of unmodified submodules' '
     + 	git rm submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual
     + '
     +@@
       	git submodule update --recursive &&
       	git -C submod/subsubmod checkout HEAD^ &&
       	test_must_fail git rm submod &&
     @@ -243,6 +365,11 @@
       	git status -s -uno --ignore-submodules=none >actual &&
       	test_cmp expect.modified_inside actual &&
       	git rm -f submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual
     + '
      @@
       	git submodule update --recursive &&
       	echo X >submod/subsubmod/empty &&
     @@ -254,6 +381,11 @@
       	git status -s -uno --ignore-submodules=none >actual &&
       	test_cmp expect.modified_inside actual &&
       	git rm -f submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual
     + '
      @@
       	git submodule update --recursive &&
       	echo X >submod/subsubmod/untracked &&
     @@ -265,14 +397,19 @@
       	git status -s -uno --ignore-submodules=none >actual &&
       	test_cmp expect.modified_untracked actual &&
       	git rm -f submod &&
     +-	test ! -d submod &&
     ++	test_path_is_missing submod &&
     + 	git status -s -uno --ignore-submodules=none >actual &&
     + 	test_cmp expect actual
     + '
      @@
       		GIT_WORK_TREE=. git config --unset core.worktree
       	) &&
       	git rm submod 2>output.err &&
      -	! test -d submod &&
      -	! test -d submod/subsubmod/.git &&
     -+	! test_path_is_dir submod &&
     -+	! test_path_is_dir submod/subsubmod/.git &&
     ++	test_path_is_missing submod &&
     ++	test_path_is_missing submod/subsubmod/.git &&
       	git status -s -uno --ignore-submodules=none >actual &&
       	test -s actual &&
       	test_i18ngrep Migrating output.err

-- 
gitgitgadget
