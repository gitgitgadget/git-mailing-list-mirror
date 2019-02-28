Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099DB20248
	for <e@80x24.org>; Thu, 28 Feb 2019 10:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbfB1KKc (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 05:10:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:34983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730388AbfB1KKc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 05:10:32 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVrQS-1gWjBG2NPU-00X58H; Thu, 28
 Feb 2019 11:10:30 +0100
Date:   Thu, 28 Feb 2019 11:10:14 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Nazri Ramliy <ayiehere@gmail.com>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Markus Wiederkehr <markus.wiederkehr@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: git rebase: retain original head?
In-Reply-To: <CAEY4ZpPQxCVY5dZ_K9NRqF=YB0=s1nnJhnuDzL+ZytJ5uO2N7g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902281008000.41@tvgsbejvaqbjf.bet>
References: <CA+h-Bnuf6u=hkPBcxhMm06FbfkS+jtrozu+inqqmUY1cNkXrWQ@mail.gmail.com> <87va2zavu1.fsf@igel.home> <CA+h-BnvN7+ETU-vFxAGDvs0gvXUjAAhMkvTPUxoRTt2Gb4b2ow@mail.gmail.com> <CA+P7+xq++4W32JT9WcasXn=Oj9W-U1eteFgpLZn8GVqeO0foog@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901091501320.41@tvgsbejvaqbjf.bet> <CAEY4ZpPQxCVY5dZ_K9NRqF=YB0=s1nnJhnuDzL+ZytJ5uO2N7g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wz0Ceug1psJOT6i9zZcgFqWYpT9k6X3w1jkkETVVnJdKlywIW4Y
 MxczLnWv899iN4QJtPIxcOfEZ17TNY0wJ8BKyDun7eYOyIxNYFTndslgJyZietWJWKqhEMJ
 oUnSJfQeb//6uNrI+DK3vlds0RSX9ui7GUnWUjMMA+tzrbYkgJcXQAWlARthh1e8xg/Zvrv
 ak1qshR4pnkEHhyNu9H1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rDiDW8ykx78=:L+CNjg+JvXTD+N3jUx9Grq
 a6WrytxZFGb1gJQ4J04DdhWMTW4aSkkSFnZOzHPrQpw9zRCeUkty8/gi9BLVDfOhPIdzkRpl7
 tqfJWbWqt0MXzo9mwsqiZHRtvKzh4Z1f8IF9wlgKRlntZABXy9Bt4XZ0RfyMtzt3+o0bN66oj
 PeYH7LUdTF5m73KQxR8pQoX+TQEZBybLi2H2WclMINbRjCcGYMvACZTr2NLx1kiNwThcSa5DW
 5aFnL/2fLOS+3vac2qDPuNRs/XmvuIKuz9pskdCN+HQX9WRQplf4xBopZedXZCrIK6zhVVHNa
 RIw+sGhp0wKXX78LTIhJR9bHV0vi/Skc91oGa1ymzU3lDK3aD08A7NDPoqVdKB2cmFSQ+ei+7
 NdEidVUR9JjA15huciDEGHryNIBUzYVCPSxDjhFYrd9OB/FJKaQz5IqabtY0OVdx+Xiekhtn0
 p20/ab1ztadMceOY7xoVKPPrqbzUqEyMotwBQprIzt+Kw6q7Qo1uBvTHJRbQT3RR/hx6wYUR5
 qkyWtb99rS/PCoV6C2kpMFETzg9vzkEPoUbaNW+IFVUA7cVdi0StrF5H/ldO4evpH5yRw9aBh
 K6uuAsc3hCPw6VkoQiRfrlXkPQwLYBd9JVGNditIcswUjE54Q/79PX7qfow9ZtSF0bIM+6NAk
 ANpRrBdFhVBapsmeVfk/DO0td1+lQnKBLaZLhO19B5qHjZmsAezGzLoN4I2B6CUQ/DQ7PRgc9
 HTE67lHNC/oYKhExE0BJjBDWkcdcZ2NsPQUpOOMvhd3RjFkpn1Ech6AAHI/W9cux7tFkQ9WFD
 11DeaJs0kE6fDSvi+CD2QHdfxGN7l4JcifbzjFpzaWIiAhI08LQACg6TsU3PK8hOCPEgdszLz
 NiPmLmpnYSXfWsoZ/d9pgHXHBvtsM0lUuNiHUBFFVH+vNoPeSLKvDoYnFmqRpwXzq79G3xmMA
 3ZqZujxNp8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nazri,

On Wed, 27 Feb 2019, Nazri Ramliy wrote:

> On Wed, Jan 9, 2019 at 10:08 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:

Oh wow. Better late than never, eh?

> > Having said that, it is an unintended regression in the built-in
> > rebase. Markus, could you come up with a minimal test case, preferably
> > in the form of a patch to t/t3415-rebase-autosquash.sh?
> 
> Something like this, perhaps? ("gmail converts tabs to spaces" caveat
> applies to the diff formatting):
> 
> --8<--
> diff --git t/t3400-rebase.sh t/t3400-rebase.sh
> index 3e73f7584c..cb55597a8b 100755
> --- t/t3400-rebase.sh
> +++ t/t3400-rebase.sh
> @@ -59,6 +59,13 @@ test_expect_success 'rebase against master' '
>   git rebase master
>  '
> 
> +test_expect_success 'rebase sets ORIG_HEAD' '
> + echo Add B. > expect &&
> + echo Modify A. >> expect &&
> + git log --oneline --format=%s ORIG_HEAD.. > actual &&
> + test_cmp expect actual
> +'
> +
>  test_expect_success 'rebase, with <onto> and <upstream> specified as
> :/quuxery' '
>   test_when_finished "git branch -D torebase" &&
>   git checkout -b torebase my-topic-branch^ &&
> -->8--

I made it a little more stand-alone, and can confirm that this is now
safely a regression in v2.21.0.

> Bisect shows that the first bad commit is this one:
> 
> commit 21853626eac565dd42572d90724b29863f61eb3b
> Author: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date:   Fri Jan 18 07:09:27 2019 -0800
> 
>     built-in rebase: call `git am` directly
> 
> I verified that by undoing the crux of that commit, and that fixes the
> failing test:
> 
> -->8--
> diff --git builtin/rebase.c builtin/rebase.c
> index 7c7bc13e91..848f6740a0 100644
> --- builtin/rebase.c
> +++ builtin/rebase.c
> @@ -728,11 +728,6 @@ static int run_specific_rebase(struct rebase_options *opts)
>   goto finished_rebase;
>   }
> 
> - if (opts->type == REBASE_AM) {
> - status = run_am(opts);
> - goto finished_rebase;
> - }
> -
>   add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
>   add_var(&script_snippet, "state_dir", opts->state_dir);
> 
> --8<--
> 
> But something seems off by my bisection in that the "bad" commit
> happens about 10 days after this email thread :/

Yep, I had fixed the issue before this commit, and a regression test would
have come in handy to prevent that regression from creeping in *again*.

Anyway, I'm on it.
Johannes

P.S.: If you want to follow my progress, I'll push updates to the
rebase-am-and-orig-head branch at https://github.com/dscho/git.
