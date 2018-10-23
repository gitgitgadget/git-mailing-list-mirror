Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A221F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJWSii (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 14:38:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:45663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbeJWSih (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 14:38:37 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lw2dd-1fY1S63tsb-017oGL; Tue, 23
 Oct 2018 12:15:44 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lw2dd-1fY1S63tsb-017oGL; Tue, 23
 Oct 2018 12:15:44 +0200
Date:   Tue, 23 Oct 2018 12:15:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] repack -ad: fix after fetch --prune in a shallow
 repository
In-Reply-To: <pull.9.v3.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810231214350.4546@tvgsbejvaqbjf.bet>
References: <pull.9.v2.git.gitgitgadget@gmail.com> <pull.9.v3.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DHOFvwpQA8Kj0AiGjqNhS5FC3pynC7lwjytSeTbxGmOzJVIT7Mb
 2uf+TzGGCRRJX779BMEJMiRKAalC9kqz5+iQUXI0YgrkJ5I8V5qkISMF5kdIPobjHrQp02c
 cBM2q8YHpko+iQv7daSfFJqHIqA8/K5osjeraDp1NLfpncmY9rnNAb62p82Oh//fs8XycFG
 oBycGatyZs+k10cikXBgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LUJ1hyHt6AI=:tKOuvRSC6zQpjK2C6B5gly
 iXjt1JE3uTZolAJ/gGVu2Krk4SwbqWpl2EpOR9OYmw2Wy+NJrPuBljX9tltDB5DkQ66ouuOfz
 UMSmULUKZzuVvoqX965kK9P6keSkNNPzyso8YhMCGdCn14AyhBNgzMIFNzAkWhWT/fET+0b8K
 q3WHTrTDb7EJQT0EtA+5GaoCkRYalufNoxuNLmTR0uOdim0aKPvoEYtk+BPOd+F7HBk7EddYB
 HMGia6U0+LDIAAP8LSy5eI8ht3/f66nd/9LH0bcESBnHvHpd1jE78kNxCe9tDavGP89UkiesW
 XLqGuXvQEgM4Up1HyCan4KU+TSCVHMF6DaB5WI3TxOlYzvwYcRydO5CfMSAP6aLBkLVVbaPFj
 OYJJuowkZOyoZakqShipp1EKO2QOSOT7UHLtYewykW4rXiPc4Hxm8CaglWE0JgSmmIfMNtrgB
 ZDV7r3Ru4OCFcMg00dvuNDLO8G9nUojBp9qIuXnUi5hfEaZXSUowTE46Xs0CfOngu3nGBU70R
 D3WkwWAVyjkOxXaHeFCV5278xg8OmUN4GK63jFviCHNb8yBnXS7coP8yG9jNll8l/Dnt0baZy
 PlqCPRuWO7u78X963idvedGOVv05m0/vsC1PQRaOWITgmbA3h/hgMpM6xO11wtO3g4afMd1uF
 kawB0W6KfecNy54sGEg4zh8P12rAZY/PfZnt8koCykMsZOzlJQDtcxP3Bfk6cG9cE2t87dJ4i
 ISUbi9sWuUI2XadnATMRN+35taN1MlscdMx9tLf693Uk5hiAFcOq3yOrMyDr5zLW9ng2CY+P/
 IqXHL8JzmwnvGEqMFYuXZIzsA7XgXsyW+KbI1xSrAGqb8EqyLE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 22 Oct 2018, Johannes Schindelin via GitGitGadget wrote:

> Under certain circumstances, commits that were reachable can be made
> unreachable, e.g. via git fetch --prune. These commits might have been
> packed already, in which case git repack -adlf will just drop them without
> giving them the usual grace period before an eventual git prune (via git gc)
> prunes them.
> 
> This is a problem when the shallow file still lists them, which is the
> reason why git prune edits that file. And with the proposed changes, git
> repack -ad will now do the same.
> 
> Reported by Alejandro Pauly.
> 
> Changes since v2:
> 
>  * Fixed a typo in the last commit message.
>  * Added an explanation to the last commit message why we do not simply skip
>    non-existing shallow commits at fetch time.
>  * Introduced a new, "quick prune" mode where prune_shallow() does not try
>    to drop unreachable commits, but only non-existing ones.

BTW this was supposed to address Peff's concern that the SEEN flag would
not be marking all reachable shallow commits at the time when
`cmd_repack()` calls `prune_shallow()`, i.e. the last concern about this
stop-gap patch series.

Ciao,
Dscho

>  * Rebased to current master because there were too many merge conflicts for
>    my liking otherwise.
> 
> Changes since v1:
> 
>  * Also trigger prune_shallow() when --unpack-unreachable=<approxidate> was
>    passed to git repack.
>  * No need to trigger prune_shallow() when git repack was called with -k.
> 
> Johannes Schindelin (3):
>   repack: point out a bug handling stale shallow info
>   shallow: offer to prune only non-existing entries
>   repack -ad: prune the list of shallow commits
> 
>  builtin/prune.c          |  2 +-
>  builtin/repack.c         |  6 ++++++
>  commit.h                 |  2 +-
>  shallow.c                | 22 +++++++++++++++++-----
>  t/t5537-fetch-shallow.sh | 27 +++++++++++++++++++++++++++
>  5 files changed, 52 insertions(+), 7 deletions(-)
> 
> 
> base-commit: c4df23f7927d8d00e666a3c8d1b3375f1dc8a3c1
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-9%2Fdscho%2Fshallow-and-fetch-prune-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-9/dscho/shallow-and-fetch-prune-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/9
> 
> Range-diff vs v2:
> 
>  1:  d2be40131 ! 1:  ed8559b91 repack: point out a bug handling stale shallow info
>      @@ -48,4 +48,6 @@
>       +		origin "+refs/heads/*:refs/remotes/origin/*"
>       +'
>       +
>      - test_done
>      + . "$TEST_DIRECTORY"/lib-httpd.sh
>      + start_httpd
>      + 
>  -:  --------- > 2:  f085eb4f7 shallow: offer to prune only non-existing entries
>  2:  c7ee6e008 ! 3:  1f9ff57d5 repack -ad: prune the list of shallow commits
>      @@ -2,15 +2,19 @@
>       
>           repack -ad: prune the list of shallow commits
>       
>      -    While it is true that we never add unreachable commits into pack files
>      -    intentionally (as `git repack`'s documentation states), we must not
>      -    forget that a `git fetch --prune` (or even a `git fetch` when a ref was
>      +    `git repack` can drop unreachable commits without further warning,
>      +    making the corresponding entries in `.git/shallow` invalid, which causes
>      +    serious problems when deepening the branches.
>      +
>      +    One scenario where unreachable commits are dropped by `git repack` is
>      +    when a `git fetch --prune` (or even a `git fetch` when a ref was
>           force-pushed in the meantime) can make a commit unreachable that was
>           reachable before.
>       
>           Therefore it is not safe to assume that a `git repack -adlf` will keep
>           unreachable commits alone (under the assumption that they had not been
>      -    packed in the first place).
>      +    packed in the first place, which is an assumption at least some of Git's
>      +    code seems to make).
>       
>           This is particularly important to keep in mind when looking at the
>           `.git/shallow` file: if any commits listed in that file become
>      @@ -23,8 +27,16 @@
>           To avoid this problem, let's prune the shallow list in `git repack` when
>           the `-d` option is passed, unless `-A` is passed, too (which would force
>           the now-unreachable objects to be turned into loose objects instead of
>      -    being deleted). Additionally, e also need to take `--keep-reachable` and
>      -    `--unpack-unreachable=<date>` into account.
>      +    being deleted). Additionally, we also need to take `--keep-reachable`
>      +    and `--unpack-unreachable=<date>` into account.
>      +
>      +    Note: an alternative solution discussed during the review of this patch
>      +    was to teach `git fetch` to simply ignore entries in .git/shallow if the
>      +    corresponding commits do not exist locally. A quick test, however,
>      +    revealed that the .git/shallow file is written during a shallow *clone*,
>      +    in which case the commits do not exist, either, but the "shallow" line
>      +    *does* need to be sent. Therefore, this approach would be a lot more
>      +    finicky than the approach presented by the this patch.
>       
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>       
>      @@ -32,15 +44,15 @@
>       --- a/builtin/repack.c
>       +++ b/builtin/repack.c
>       @@
>      - 		if (!quiet && isatty(2))
>      + 		if (!po_args.quiet && isatty(2))
>        			opts |= PRUNE_PACKED_VERBOSE;
>        		prune_packed_objects(opts);
>       +
>       +		if (!keep_unreachable &&
>       +		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
>       +		     unpack_unreachable) &&
>      -+		    is_repository_shallow())
>      -+			prune_shallow(0);
>      ++		    is_repository_shallow(the_repository))
>      ++			prune_shallow(0, 1);
>        	}
>        
>        	if (!no_update_server_info)
> 
> -- 
> gitgitgadget
> 
