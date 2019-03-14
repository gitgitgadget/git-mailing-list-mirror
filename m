Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B3320248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfCNMRM (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:17:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:43309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfCNMRL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:17:11 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmrUq-1gYfVC0pWG-00h31h; Thu, 14
 Mar 2019 13:17:02 +0100
Date:   Thu, 14 Mar 2019 13:16:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] difftool: allow running outside Git worktrees with
 --no-index
In-Reply-To: <20190313204644.GA5397@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903141305550.41@tvgsbejvaqbjf.bet>
References: <pull.163.git.gitgitgadget@gmail.com> <9f6eb60eeeccf920af83652899c5bc2d40e2092f.1552504812.git.gitgitgadget@gmail.com> <20190313204644.GA5397@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3iWaTdroDPgMZJXBqyohqqRuQ4BjEkvuoho4R/HHd5ZCNyMQGzD
 Xpb2D0IsgS+vkPVu0I311Oplxii1XZr06sm8N0+OEBFGiW03iCIOCfS9Qm8MFpg/ilBkblh
 KkN+X7qL2+65Fg3VhfMGPcX2Z1ucpfsmESR3YaZgvU2qP5cGjDJynmUObZBhmEOe8cehyEO
 XDyRf8ibIvHkAr62HpIpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mVKmLd5xnyM=:OulvCbnM3kdpn1blPyPuEn
 0dKdqm+bgSPohXqIfSmfeTpxBsmt90ihXJx3F+Nzv88YIiGsYrWGnBq6A4Oe3+qepQDal/EV/
 Ba93cT30vMH6yUQDIRdWc9IqEWiIzW85CW+pvDUjIkHp3QaHWjivE0xyGXx3kEn3IyWYAPr+/
 iRp0T3H2mZD9TMu9wMWjomdZD7zrvOrAqBJnRifcmQ/Zwnz5l8KHfcPcuRfR63KM41z/6mIKY
 2VeF8BGNCCO9MxZBHX3jKohsB9QvjNZXPp7nYn2f4xsZa156cCXt5OVXJkjKIZtGUlad/2wOh
 zBhOi685ZWIIGJucnDsUDSQcjZnhHWRlrrd4I2qdIeRiLMGu5msAIN3u/7ca1L6lupFJKCag0
 egP/MsDWvH4TWr92/4wyX4klHPFY8XmpaB5Oz8z0Jp/DQIoiq0FxZ0l2IZe2mwIKNmVH5IMlJ
 +pIBkl+0eNyA8Lz/D8PHxzFDQ52oUTvmtX577+sDRPGvSLFb3BsddD7NylRp1g1JEIgXtIznj
 J4jN2Dj4ehxusIZnQegYP8YRuAWyk9nQh/AulIVpCi8VSnb783ljqW5s2mrwPTNQJ1L1tN6AA
 NBUP04bOlqHO7yadw1ZjFepxX1bnQOiog+rxBwNrR9LKR4HuFYg9XR/AskMx5WfmKSy/8LSNx
 cjuFeGw0hAtZCAJU9JdyNyRd0zLQw5rH7Bh1QwGfqGgtFMoHZHRk2yZVaAfAd6x/MBobookpW
 Ua6I8dupsXpNAHVdA8/Sf0h1h2VwxZ1LkcuypsMqo5MjFNvxcwSPmcImsk2g3IpE5U+Z6V/2F
 dRMSfDl8wrQENgbkfQdnFlm48Y+Kj+VlL3WiuyjKZwo70CJE07HHaO5SHllUoSjqSwglS4U5h
 2umObKfleJIRFWD6wD9HuUi2pPS2ySFLTKupVl/9TxmsYxeRdEC5f+aQdeRpdNRluvixeTipU
 kdrM5K8jcBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 13 Mar 2019, Jeff King wrote:

> On Wed, Mar 13, 2019 at 12:20:14PM -0700, Johannes Schindelin via
> GitGitGadget wrote:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > As far as this developer can tell, the conversion from a Perl script to
> > a built-in caused the regression in the difftool that it no longer runs
> > outside of a Git worktree (with `--no-index`, of course).
> > 
> > It is a bit embarrassing that it took over two years after retiring the
> > Perl version to discover this regression, but at least we now know, and
> > can do something, about it.
> 
> If a bug falls in the forest, does it make a sound?

I am glad you asked! Last time I checked, yes, it made a sound. It was a
really curious rattling sound. But I did not want to bother the bug again,
so I left it alone.

> I get the impression that `--no-index` is not used all that much, given
> how long bugs seem to hang around in it (and doubly so when intersected
> with the difftool).

Or maybe `--no-index` is used in pretty canonical ways. I, for one, used
to be a really heavy user of `--no-index` before `range-diff`, and it was
almost always with two files, sometimes with `--color-words`, sometimes
with `--patience`, sometimes both, but never anything crazy like using
Bash's `<(<command>)` syntax.

In other words, my take is that the ways in which `--no-index` is used are
probably not very different from one another, and the bugs lurk in
really rarely exercised code paths.

> > -	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
> > -	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
> > +	for (i = 0; i < argc; i++)
> > +		if (!strcmp(argv[i], "--"))
> > +			break;
> > +		else if (!strcmp(argv[i], "--no-index")) {
> > +			no_index = 1;
> > +			break;
> > +		}
> 
> Instead of this ad-hoc parsing, can we just add an OPT_BOOL("no-index")
> to the parse-options array? We'll have already run parse_options() at
> this point.
> 
> We'd just have to remember to add it back to the argv of diff
> sub-commands we run.

It was that "add it back" that I was not keen to implement.

But you gave me an idea: why not teach parse_options() to optionally keep
individual parsed arguments in `argv`?

And I was half-way finished with implementing that idea when I discovered
`OPT_ARGUMENT()`. This seemed to be *almost* what I needed: it puts the
argument immediately back into `argv`. However, it did not record that
fact, so I would not know whether it was part of the command-line or not.

So I was already done with implementing `OPT_ARGUMENT_SEEN()`, based on
`OPT_ARGUMENT()`, and testing it with my difftool patch, when it occurred
to me to look what existing users of `OPT_ARGUMENT()` do. Guess what:
there are none, apart from that test helper used in t0040 to verify that
`parse_options()` works as intended. And there were none other. In the
entire commit history.

In the end, I changed `OPT_ARGUMENT()`, and I find the end result rather
pleasing.

> > +	if (!no_index && !startup_info->have_repository)
> > +		die(_("difftool requires worktree or --no-index"));
> > +
> > +	if (!no_index){
> > +		setup_work_tree();
> > +		setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
> > +		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
> > +	}
> 
> This part makes sense.
> 
> There may be other subtle dependencies on having a repo from
> sub-functions we run, but I didn't see any from a quick scan. And
> anyway, if there is such a code path, it is no worse off than before
> your patch (and in fact much better, because it would hopefully yield a
> BUG() that would tell us what we need to fix).

Indeed.

> > +test_expect_success 'outside worktree' '
> > +	mkdir outside &&
> > +	echo 1 >outside/1 &&
> > +	echo 2 >outside/2 &&
> > +	test_expect_code 1 env GIT_CEILING_DIRECTORIES="$(pwd)" git \
> > +		-c diff.tool=echo -c difftool.echo.cmd="echo \$LOCAL \$REMOTE" \
> > +		-C outside difftool --no-prompt --no-index 1 2 >out &&
> 
> We have a helper for running outside a repo. Because you have to set up
> the "outside" space, it unfortunately doesn't shorten things as much as
> it does in some other spots:
> 
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 4907627656..255a787614 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -706,12 +706,12 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
>  '
>  
>  test_expect_success 'outside worktree' '
> -	mkdir outside &&
> -	echo 1 >outside/1 &&
> -	echo 2 >outside/2 &&
> -	test_expect_code 1 env GIT_CEILING_DIRECTORIES="$(pwd)" git \
> +	mkdir non-repo &&
> +	echo 1 >non-repo/1 &&
> +	echo 2 >non-repo/2 &&
> +	test_expect_code 1 nongit git \
>  		-c diff.tool=echo -c difftool.echo.cmd="echo \$LOCAL \$REMOTE" \
> -		-C outside difftool --no-prompt --no-index 1 2 >out &&
> +		difftool --no-prompt --no-index 1 2 >out &&
>  	test "1 2" = "$(cat out)"
>  '
>  
> 
> but it might be worth using anyway, just for consistency.

I totally agree. Thanks for pointing me to `nongit`; I was unaware of it.

And I was able to shorten it a bit, because the files `1` and `2` do not
need to live in that `non-repo` directory.

Again, a rather pleasing change.

> > +	test "1 2" = "$(cat out)"
> 
> A minor nit, but I think:
> 
>   echo "1 2" >expect &&
>   test_cmp expect actual
> 
> produces nicer output on failure, and costs the same number of
> processes (it is an extra file write, but I think the main driver of
> performance in the test suite is just processes).

You are totally right! After all, a regression test does not need to make
anything easy when it passes. It needs to make it easy to act when it
fails.

Thank you so much for your helpful suggestions!
Dscho
