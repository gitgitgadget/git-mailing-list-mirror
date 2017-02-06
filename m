Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B578D1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 16:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbdBFQ7A (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 11:59:00 -0500
Received: from mout.gmx.net ([212.227.17.21]:58313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdBFQ67 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 11:58:59 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1iGk-1cHSHw0Sks-00tgsz; Mon, 06
 Feb 2017 17:58:50 +0100
Date:   Mon, 6 Feb 2017 17:58:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Aguilar <davvid@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] difftool: fix bug when printing usage
In-Reply-To: <20170205212338.17667-1-davvid@gmail.com>
Message-ID: <alpine.DEB.2.20.1702061716120.3496@virtualbox>
References: <20170205201751.z4rfmy5xxaqg472l@gmail.com> <20170205212338.17667-1-davvid@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rvWrMvdzvgeRaZlWlhFtI0rCGfo2jt4nYZz5vCqXDrVKdxdxCGE
 okxvsMndnOvAFFLCVN5z8glLmaPJomP145mg5p6sWsbOD/g+3AWl1wlaQ64TC1ZI04ygkj5
 VZPnEI3kvrWMa6dIzS5NxKoGBcup9laqnXH36PHnQXJ8WgwUS1QFhCwN7Mqz9eBm7e0OaL3
 ep15wQa1Lxn0UE8900qqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f/5QptIbnnY=:9gA/N8EDyXpqUz1qsDlzp0
 KPfqgwtlHho1m21cpnoRqb+JJj5eDvZb0/IXN2Ae+BZOQEykTW3DGyyuYQyypVufNGxxDZXcE
 GzLafh5E1UwKMfsL1H8O1GCAI3D+Dh+bLjWTvR0/fSNyIpCV3pCmin5vnfQSGP7fsQsOXFDzS
 Zy3SSbqsEWM8KYTZdYpOUwgri7j1hVzvwdGIOIEWrArkem8pXxtYBa2RncB3XYQE72WXPYKnz
 X58yeG1/uwWKbPh+i8J2vXnJppTzNznnxpChBut8eYrKUMGM+dwLPGjD/P9FJcT4nf1LU4ctP
 ynAP2kGZBjv6htykZM/mS92eBZ1Tj3q1kra2XaDh3DJpqzlCb8cBekbJvN/uXjJXhZZ2uPzKk
 VRa6uqC5W5b6V5ixW4LJKnMofT8FFs65ZQtEL86qZwGlSWqYtW9R+M9YqeB5edeqYxbqauvt6
 sNxvLythq5OmMSaqkMjkJCBmjCC3u2yCK2vJBdrk3P6JWeISlIm6bIrD/pG60qMyGuWBwbKvC
 RPLfO7+llS2dLoqswd4lPpCQlp+X/jzv3hxmHSCiGufdDn+7KCzo2pgVAf0cYrm1C32t0sAim
 raEzx6bqq3dviPCmoKypu9kE7oq5+hLm3RBdUhYIh/MH2aQ5PB2oBYX9W8dBDZcPoHz2grOt+
 bOGwUvdBBXGpOZlyYRs98dgv8+K2CP2fwijTLE3V6JqvW/aQk67Yza7NdUhSmsIboXYckZLvl
 XTve512sEUhJWxjOqrIWUe/7HYhl05to9InSqK0yoyiIYpLFp9j1Tuwdq89TPikjy55YhMxDv
 d9rdm5BbwKIVj72TUCSifkblMczFMi/VnBGE/IEZePpojnOUmuyBuEFAr8iyrm2bX1H3L53i4
 7XjVE4CUtmfKK3/KRuN1eSeLHHpMpMUB9hp/CHj6C35pk2WrbQBHNF4iR8HugmJZKkmteftpe
 qJKkfzv9vBJnjkWJxM/IlpnIs/qEPe57ebcvobCuQrNcx+DNCvbNIn59hROFTKFHoCb82nVRf
 l3RAAHSHwti5VMwrg+4/MoWcltFET9QKQP9aT/n49X+iVPlfqs1F+/Yj+el9AUk7SA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Sun, 5 Feb 2017, David Aguilar wrote:

> "git difftool -h" reports an error:
> 
> 	fatal: BUG: setup_git_env called without repository
> 
> Defer repository setup so that the help option processing happens before
> the repository is initialized.
> 
> Add tests to ensure that the basic usage works inside and outside of a
> repository.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This bug exists in both "master" and "next".
> This patch has been tested on both branches.

Thanks for noticing and for patching!

> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index b5e85ab079..d13350ce83 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -647,10 +647,6 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> -	/* NEEDSWORK: once we no longer spawn anything, remove this */
> -	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
> -	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
> -
>  	git_config(difftool_config, NULL);
>  	symlinks = has_symlinks;
>  
> @@ -661,6 +657,10 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
>  	if (tool_help)
>  		return print_tool_help();
>  
> +	/* NEEDSWORK: once we no longer spawn anything, remove this */
> +	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
> +	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
> +
>  	if (use_gui_tool && diff_gui_tool && *diff_gui_tool)
>  		setenv("GIT_DIFF_TOOL", diff_gui_tool, 1);
>  	else if (difftool_cmd) {

Aaargh. You know, when you are used to code review systems where you can
easily increase the context of the diff hunks, static patches are...
tedious to review.

For the record: the context between those two hunks is:

       argc = parse_options(argc, argv, prefix, builtin_difftool_options,
                             builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN |
                             PARSE_OPT_KEEP_DASHDASH);

> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index aa0ef02597..21e2ac4ad6 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -23,6 +23,19 @@ prompt_given ()
>  	test "$prompt" = "Launch 'test-tool' [Y/n]? branch"
>  }
>  
> +test_expect_success 'basic usage requires no repo' '
> +	lines=$(git difftool -h | grep ^usage: | wc -l) &&
> +	test "$lines" -eq 1 &&

It may be easier to debug future breakages if you wrote

	git difftool -h | grep ^usage: >output &&
	test_line_count = 1 output &&

or even better (changing the semantics now):

	test_expect_code 129 git difftool -h >output &&
	grep ^usage: output &&

> +	# create a ceiling directory to prevent Git from finding a repo
> +	mkdir -p not/repo &&
> +	ceiling="$PWD/not" &&
> +	lines=$(cd not/repo &&
> +		GIT_CEILING_DIRECTORIES="$ceiling" git difftool -h |
> +		grep ^usage: | wc -l) &&
> +	test "$lines" -eq 1 &&

Likewise, this would become

	GIT_CEILING_DIRECTORIES="$PWD/not" \
	test_expect_code 129 git -C not/repo difftool -h >output &&
	grep ^usage: output

> +	rmdir -p not/repo

I am not sure how portable `rmdir -p` is. Why not use

	test_when_finished rm -r not

instead?

But those are all really minor bike-sheddings, and I promised myself that
I would avoid those (as I find them rather pointless) unless there is at
least one real benefit. In this case, I think the result becomes more
readable:

-- snip --
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 21e2ac4ad6d..7d7cb63d61e 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -24,16 +24,14 @@ prompt_given ()
 }
 
 test_expect_success 'basic usage requires no repo' '
-	lines=$(git difftool -h | grep ^usage: | wc -l) &&
-	test "$lines" -eq 1 &&
-	# create a ceiling directory to prevent Git from finding a repo
-	mkdir -p not/repo &&
-	ceiling="$PWD/not" &&
-	lines=$(cd not/repo &&
-		GIT_CEILING_DIRECTORIES="$ceiling" git difftool -h |
-		grep ^usage: | wc -l) &&
-	test "$lines" -eq 1 &&
-	rmdir -p not/repo
+	test_expect_code 129 git difftool -h >output &&
+	grep ^usage: output &&
+	# create a ceiling directory to prevent Git from finding a repo
+	mkdir -p not/repo &&
+	test_when_finished rm -r not &&
+	GIT_CEILING_DIRECTORIES="$PWD/not" \
+	test_expect_code 129 git -C not/repo difftool -h >output &&
+	grep ^usage: output
 '
 
 # Create a file on master and change it on branch
-- snap --

More importantly: When I read $PWD all kinds of alarm bells go off in my
head, as I immediately think of all the issues we have on Windows due to
Git's regression test using POSIX paths all over the place.

In this particular instance, it *does* work, magically, because the POSIX
path $PWD is automatically converted (by the MSYS2 runtime) into a Windows
path when git.exe is called.

Read: I actually tested this, in line with my resolution to avoid to
review merely patches (which would likely miss serious bugs) and instead
try to do full code reviews, including testing. That means that I will
review less, but better.

Insofar as I am the author of the builtin difftool:

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks,
Dscho
