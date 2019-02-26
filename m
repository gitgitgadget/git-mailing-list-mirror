Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12336205D7
	for <e@80x24.org>; Tue, 26 Feb 2019 16:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfBZQBu (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 11:01:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:55037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbfBZQBt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 11:01:49 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZCUG-1gi6lH19PY-00KxQx; Tue, 26
 Feb 2019 17:01:43 +0100
Date:   Tue, 26 Feb 2019 17:01:27 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 1/1] tests: replace `test -(d|f)` with
 test_path_is_(dir|file)
In-Reply-To: <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902261657000.41@tvgsbejvaqbjf.bet>
References: <pull.152.git.gitgitgadget@gmail.com> <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oTrbIyzi/T4BeRYkHdieTNEG1sRxmVjrz3QZEf+Dh8tmRJ5hvGS
 gqlCaf3IZdcgei4S0Ny8fYPt8kZZ+WSeJn+D5R/ofEstUKkwCzVs+IJwy5QJHK9vWfWqbJN
 eSLDW1rl7RJOzF5lvj2xp1NbxROWkXUST6c/1VG907E+YXvG7T6rmCYLGBdHkBa+uv+igQ8
 t1rh6vxrwAZy7GjYVsQ4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OcgMGkxY13w=:ZugmCfWpdD54LDl0UXv8PF
 r7ciyh2+YkMwVDHpL0amlMyL6NdxmXqidM1qTYckcybzMBu1l7Wn39jr95loq56cZPoe8rth5
 4An2bdZ9RkypNNhUq67rzOL2K8k44rM+3cGDzPP6aInFQGjm8mQus8QpgtmLwggz0f276rg5D
 5MOqF2a8l8YfQL18x2DudfgeMlTKTJfhaMcJiIi/HC0dy9yXlNNaGoeduWXROaJhbGwQ3Fpkb
 HRTGzXne1JwV+Dba5ZVz4Zrd01yjmKtbw02xUo+pWcGgpjNm3LRT6i3n09szGEG4QZUDpXjNT
 dQMsBHtNBuMciQPfqx+bfM4gin4X/4wFHPZ67sypCnmf/jlelhc7d4WBNcvFM8Wp1ST4k8otI
 rG2AcBC1dgGOYuMZpbIj3dnW2Y7V5U0nPC4gH/J3ZU6I00lAGGrtwTIMaCxRlYUzCkkGMSf/L
 xKMoLDfkt7vIGYwrEHnU516D4MWfVadOh1rpV8usX+itF2z9OBmR0P54h90leqt4KjtlVezVS
 Q5UKkEcv6CuKvLLlwvXJ+q5P0rRNMPZ6gQ2vVOsOWCuy6tNV0xxmD8NgBPs7tmvh2xMa6Txtz
 Uzhqmlcya7UsNykblYo4Fmc/WJ0Z49VNXvLPtGJ6UsvJ5uLPHKmwHRT0Ewf5r5N5+Fl0Cj6wV
 A0+3i+HDrE/hj5lmw0Ph69Azxj/Bl9LNVd41yNJwOUOPRwhTe3CNli3xScnl/JzF0/oHlT3+v
 vHLpSSiuI1fd1Mq7CTiJTPB1nqFh29Qz/TbvUyDRPTC7lBbuo1j3fOhLx+loLgh+4ecZhLK4S
 VKgpGuYWFOtveSb7iUpt9DO/9fb03sQTHpvMVAjQx5pIkFKzzS4PKyUodV/riA0rHPd6hBa93
 yMHw0JTWmrE9yn6vdrB9y9MGxSaMfhthvBU4UGNdPyE7t9FluDGIs4hgwGR4kMJw1qN3Y90pR
 LNACsfyx4BQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit,

the oneline suggests that this fixes all the tests, but it only fixes
t3600. So maybe use "t3600:" instead of "tests:"?

On Tue, 26 Feb 2019, Rohit Ashiwal via GitGitGadget wrote:

> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> 
> t3600-rm.sh: Previously we were using `test -(d|f)`
> to verify the presencee of a directory/file, but we
> already have helper functions, viz, test_path_is_dir
> and test_path_is_file with same functionality. This
> patch will replace `test -(d|f)` calls in t3600-rm.sh.

This answers a bit of the "what?", but little in the way of "how?".

Another thing to mention in the commit message is the "why?"... So far, a
casual reader will not exactly understand what the benefit might be, and
might even disagree that it is an improvement because

    1. the new code will be slower (as it adds one level of indirection: a
shell function)

    2. the new code is more verbose (`test -d` is shorter than
`test_path_is_dir`)


Obviously, the active Git developers do agree, though, that it is a good
change (otherwise they would not have suggested it as a GSoC
microproject), and I think it is because:

    1. the new code is a lot more obvious to developers who are not fluent
in Unix shell scripting, and

    2. the new code is a lot more informative in case of a breakage.

The patch looks fine,
Johannes

> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>  t/t3600-rm.sh | 96 +++++++++++++++++++++++++--------------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)
> 
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 04e5d42bd3..dcaa2ab4d6 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -137,8 +137,8 @@ test_expect_success 'Re-add foo and baz' '
>  test_expect_success 'Modify foo -- rm should refuse' '
>  	echo >>foo &&
>  	test_must_fail git rm foo baz &&
> -	test -f foo &&
> -	test -f baz &&
> +	test_path_is_file foo &&
> +	test_path_is_file baz &&
>  	git ls-files --error-unmatch foo baz
>  '
>  
> @@ -159,8 +159,8 @@ test_expect_success 'Re-add foo and baz for HEAD tests' '
>  
>  test_expect_success 'foo is different in index from HEAD -- rm should refuse' '
>  	test_must_fail git rm foo baz &&
> -	test -f foo &&
> -	test -f baz &&
> +	test_path_is_file foo &&
> +	test_path_is_file baz &&
>  	git ls-files --error-unmatch foo baz
>  '
>  
> @@ -194,21 +194,21 @@ test_expect_success 'Recursive test setup' '
>  
>  test_expect_success 'Recursive without -r fails' '
>  	test_must_fail git rm frotz &&
> -	test -d frotz &&
> -	test -f frotz/nitfol
> +	test_path_is_dir frotz &&
> +	test_path_is_file frotz/nitfol
>  '
>  
>  test_expect_success 'Recursive with -r but dirty' '
>  	echo qfwfq >>frotz/nitfol &&
>  	test_must_fail git rm -r frotz &&
> -	test -d frotz &&
> -	test -f frotz/nitfol
> +	test_path_is_dir frotz &&
> +	test_path_is_file frotz/nitfol
>  '
>  
>  test_expect_success 'Recursive with -r -f' '
>  	git rm -f -r frotz &&
> -	! test -f frotz/nitfol &&
> -	! test -d frotz
> +	! test_path_is_file frotz/nitfol &&
> +	! test_path_is_dir frotz
>  '
>  
>  test_expect_success 'Remove nonexistent file returns nonzero exit status' '
> @@ -254,7 +254,7 @@ test_expect_success 'rm removes subdirectories recursively' '
>  	echo content >dir/subdir/subsubdir/file &&
>  	git add dir/subdir/subsubdir/file &&
>  	git rm -f dir/subdir/subsubdir/file &&
> -	! test -d dir
> +	! test_path_is_dir dir
>  '
>  
>  cat >expect <<EOF
> @@ -343,8 +343,8 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
>  	git submodule update &&
>  	git -C submod checkout HEAD^ &&
>  	test_must_fail git rm submod &&
> -	test -d submod &&
> -	test -f submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_file submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test_cmp expect.modified actual &&
>  	git rm -f submod &&
> @@ -359,8 +359,8 @@ test_expect_success 'rm --cached leaves work tree of populated submodules and .g
>  	git reset --hard &&
>  	git submodule update &&
>  	git rm --cached submod &&
> -	test -d submod &&
> -	test -f submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_file submod/.git &&
>  	git status -s -uno >actual &&
>  	test_cmp expect.cached actual &&
>  	git config -f .gitmodules submodule.sub.url &&
> @@ -371,7 +371,7 @@ test_expect_success 'rm --dry-run does not touch the submodule or .gitmodules' '
>  	git reset --hard &&
>  	git submodule update &&
>  	git rm -n submod &&
> -	test -f submod/.git &&
> +	test_path_is_file submod/.git &&
>  	git diff-index --exit-code HEAD
>  '
>  
> @@ -381,8 +381,8 @@ test_expect_success 'rm does not complain when no .gitmodules file is found' '
>  	git rm .gitmodules &&
>  	git rm submod >actual 2>actual.err &&
>  	test_must_be_empty actual.err &&
> -	! test -d submod &&
> -	! test -f submod/.git &&
> +	! test_path_is_dir submod &&
> +	! test_path_is_file submod/.git &&
>  	git status -s -uno >actual &&
>  	test_cmp expect.both_deleted actual
>  '
> @@ -393,14 +393,14 @@ test_expect_success 'rm will error out on a modified .gitmodules file unless sta
>  	git config -f .gitmodules foo.bar true &&
>  	test_must_fail git rm submod >actual 2>actual.err &&
>  	test -s actual.err &&
> -	test -d submod &&
> -	test -f submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_file submod/.git &&
>  	git diff-files --quiet -- submod &&
>  	git add .gitmodules &&
>  	git rm submod >actual 2>actual.err &&
>  	test_must_be_empty actual.err &&
> -	! test -d submod &&
> -	! test -f submod/.git &&
> +	! test_path_is_dir submod &&
> +	! test_path_is_file submod/.git &&
>  	git status -s -uno >actual &&
>  	test_cmp expect actual
>  '
> @@ -413,8 +413,8 @@ test_expect_success 'rm issues a warning when section is not found in .gitmodule
>  	echo "warning: Could not find section in .gitmodules where path=submod" >expect.err &&
>  	git rm submod >actual 2>actual.err &&
>  	test_i18ncmp expect.err actual.err &&
> -	! test -d submod &&
> -	! test -f submod/.git &&
> +	! test_path_is_dir submod &&
> +	! test_path_is_file submod/.git &&
>  	git status -s -uno >actual &&
>  	test_cmp expect actual
>  '
> @@ -424,8 +424,8 @@ test_expect_success 'rm of a populated submodule with modifications fails unless
>  	git submodule update &&
>  	echo X >submod/empty &&
>  	test_must_fail git rm submod &&
> -	test -d submod &&
> -	test -f submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_file submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test_cmp expect.modified_inside actual &&
>  	git rm -f submod &&
> @@ -439,8 +439,8 @@ test_expect_success 'rm of a populated submodule with untracked files fails unle
>  	git submodule update &&
>  	echo X >submod/untracked &&
>  	test_must_fail git rm submod &&
> -	test -d submod &&
> -	test -f submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_file submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test_cmp expect.modified_untracked actual &&
>  	git rm -f submod &&
> @@ -493,8 +493,8 @@ test_expect_success 'rm of a conflicted populated submodule with different HEAD
>  	git -C submod checkout HEAD^ &&
>  	test_must_fail git merge conflict2 &&
>  	test_must_fail git rm submod &&
> -	test -d submod &&
> -	test -f submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_file submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test_cmp expect.conflict actual &&
>  	git rm -f submod &&
> @@ -512,8 +512,8 @@ test_expect_success 'rm of a conflicted populated submodule with modifications f
>  	echo X >submod/empty &&
>  	test_must_fail git merge conflict2 &&
>  	test_must_fail git rm submod &&
> -	test -d submod &&
> -	test -f submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_file submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test_cmp expect.conflict actual &&
>  	git rm -f submod &&
> @@ -531,8 +531,8 @@ test_expect_success 'rm of a conflicted populated submodule with untracked files
>  	echo X >submod/untracked &&
>  	test_must_fail git merge conflict2 &&
>  	test_must_fail git rm submod &&
> -	test -d submod &&
> -	test -f submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_file submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test_cmp expect.conflict actual &&
>  	git rm -f submod &&
> @@ -552,13 +552,13 @@ test_expect_success 'rm of a conflicted populated submodule with a .git director
>  	) &&
>  	test_must_fail git merge conflict2 &&
>  	test_must_fail git rm submod &&
> -	test -d submod &&
> -	test -d submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_dir submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test_cmp expect.conflict actual &&
>  	test_must_fail git rm -f submod &&
> -	test -d submod &&
> -	test -d submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_dir submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test_cmp expect.conflict actual &&
>  	git merge --abort &&
> @@ -586,8 +586,8 @@ test_expect_success 'rm of a populated submodule with a .git directory migrates
>  		rm -r ../.git/modules/sub
>  	) &&
>  	git rm submod 2>output.err &&
> -	! test -d submod &&
> -	! test -d submod/.git &&
> +	! test_path_is_dir submod &&
> +	! test_path_is_dir submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test -s actual &&
>  	test_i18ngrep Migrating output.err
> @@ -624,8 +624,8 @@ test_expect_success 'rm of a populated nested submodule with different nested HE
>  	git submodule update --recursive &&
>  	git -C submod/subsubmod checkout HEAD^ &&
>  	test_must_fail git rm submod &&
> -	test -d submod &&
> -	test -f submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_file submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test_cmp expect.modified_inside actual &&
>  	git rm -f submod &&
> @@ -639,8 +639,8 @@ test_expect_success 'rm of a populated nested submodule with nested modification
>  	git submodule update --recursive &&
>  	echo X >submod/subsubmod/empty &&
>  	test_must_fail git rm submod &&
> -	test -d submod &&
> -	test -f submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_file submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test_cmp expect.modified_inside actual &&
>  	git rm -f submod &&
> @@ -654,8 +654,8 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
>  	git submodule update --recursive &&
>  	echo X >submod/subsubmod/untracked &&
>  	test_must_fail git rm submod &&
> -	test -d submod &&
> -	test -f submod/.git &&
> +	test_path_is_dir submod &&
> +	test_path_is_file submod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test_cmp expect.modified_untracked actual &&
>  	git rm -f submod &&
> @@ -673,8 +673,8 @@ test_expect_success "rm absorbs submodule's nested .git directory" '
>  		GIT_WORK_TREE=. git config --unset core.worktree
>  	) &&
>  	git rm submod 2>output.err &&
> -	! test -d submod &&
> -	! test -d submod/subsubmod/.git &&
> +	! test_path_is_dir submod &&
> +	! test_path_is_dir submod/subsubmod/.git &&
>  	git status -s -uno --ignore-submodules=none >actual &&
>  	test -s actual &&
>  	test_i18ngrep Migrating output.err
> -- 
> gitgitgadget
> 
