Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD8C1F4C0
	for <e@80x24.org>; Sun, 27 Oct 2019 21:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfJ0VFy (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 17:05:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:56655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbfJ0VFw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 17:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572210347;
        bh=JlEnHUZYELJgofnCuaaui6fBz4Bwu1lF6ei90PYWdCY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Myr5WwQXB+BnLltWfp0F93eFGXNNTeg6ThsdrX7QlC0ChN85qqtJb/YBRqvXESjYQ
         7BeTJWhFxcyIQoqzz+RFUlPH3/iWfMR5sPd4WvnFiEQBce1BGqvt54jY2353V+rKok
         DreE5xh/vMS0eW3XatYzMuyFPUydoMZd6IHuo/3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1iDtUx11oW-00FTlV; Sun, 27
 Oct 2019 22:05:47 +0100
Date:   Sun, 27 Oct 2019 22:05:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Fix git stash with skip-worktree entries
In-Reply-To: <pull.355.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910272203360.46@tvgsbejvaqbjf.bet>
References: <pull.355.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mq3h6pG5+4887eHE+u7K8fssMa+cZ9PVmU1/0JV47wZVFz1VVga
 iOgSl8QUB+9RxdbirEG7HBDKQuL8Y1DHvBQ6hB7pcHSQKvtRDlUp4aOdqwLgTIaMkoGjGDg
 jTjLuHdU2iyEgXy0C87RKpKsTTPiGhsYP8sTZucz8i7JKoDbgvz9XiBj6GxyvPMiDzRdvHv
 fhJ9JTTXVT/I2Y7Ac9YKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S7NnTK9RxKI=:uH479waAOU3dvEdYTfH9Bx
 hS6QcmBj4YWARLii1a6nXzys9kI0nrQfjgrDDepZfPgGvZZFoVtLUE5IGP9iYjUHhn/4yvnAc
 uMxHCww56GuA4B3pxtNGGBcZ0opjo6NHe/+PG17NsRqSn0TRc+9DwAsPCEiLQeLSpivToLdtS
 2gsQ6N3euu8Xg8lhNBPmADOq/lYTk4xI345UPXWyeWRfcwKoIxW9+US6030SlxvcGHYZ990XP
 emOm+MnLcKVTWiO8yHZAnZaVC3G6+zUUj/XksB/fyErVpz7JZRgiDIHR0V4DIfIEPJn4Vjho9
 K/Z0VXjxxhVsAi2mMKdm7oVLsKMYh10pzrchkI1BelYe92bC+P2Md+kgrYK6aqtqzq5u8Dp6E
 rvjS8+zg01wU2UjIw5j9aEpBPz4Pm0jBk3136grsn94DqlkVaoa1DBZ7s0Np1WoIx1Aq+NVmU
 kBsmezpEfE4gwHuUwOJV+05pa0EdOHF2B+x3SojKvhntAcbXAvz0/WHbaDvupX6aqbQX/+U89
 O5BccJ9GHEecjeagrXrCyFo9BB6SHLC9dBQIrbDzL9uYhocthA+C1q8hbcBVlS14o/RLu+Aro
 vzVg0JR99bKb+y9Zxw1KC8np/iHVQ1uRDrihhFaKBBhJ585czrgrbs+XOoi8k+6y5aCBbxeD/
 Kc811nHz+M2DpcYCa1w+YJ5mUnS4o9GOEAO4zNpB/Az8IdX8rEd5DDY0C3ibpT7MvgEnG7jeJ
 kbYjrk9RCD2VUHjWW5GWyhnrdkU3pebWlcFXxyInMjgBs+8LmuKGOwWj1NR4zJ4WrpnuTuDnv
 HFU2sXGLoD0OytRJf7/ayrE5SrQp8xs520rrmxul5Wi/hDfHEHbXOISCQXwH3eYXBLfbLCdhI
 umg62I076wV9EB3T+dWlyft4Lmni+Q2GNKluTwSf+NlmfDWfKJD7NddNZK3ZNJQypZbTgNvl9
 KXb4zPIFJPjHKlvnhm7/9pikevQ3LKyNCDFOW9HB451QPPZyyGKE2mG5KELEpUv4zt5v5+1ZT
 g3DK3P+a04IWCcQtFoCqYEMcIWbcJx6HEsZkug/ls4LlzPheB8B7XzEwl30b5m23tzM7J7jtn
 dEQpGbtBd2yAoTflE8NBGDgTG4h8TDEbGK2kEBxZhoNyXDq29BfJ8fDrU9wPKNc2q9PLk+UIa
 ab5RUsfYcXuqXN4WK9O83EYg32BAUF6J7CKEOyleTCL5jWQNpxGe+EHASa3xdU9+MIr/CMkXT
 FqkKD8R1Jhd8NRf+HleAWH61jrrkL9rH94HjqOZJB+TH5ZOqcjs7Rnj7n3nw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 26 Sep 2019, Johannes Schindelin via GitGitGadget wrote:

> My colleague Dan Thompson reported a bug in a sparse checkout, where git
> stash (after resolving merge conflicts and then making up their mind to
> stash the changes instead of committing them) would "lose" files (and fi=
les
> that were not even in the sparse checkout's cone!).

I only realized _now_ that this patch has not made it anywhere; I would
like to have it at least in Git for Windows v2.24.0.

Could I ask for this to still be picked up into `pu` at least, so that
it does not fall into oblivion?

Thanks,
Dscho

>
> I first considered changing the behavior of git diff-index to simply ign=
ore
> skip-worktree entries. But after re-reading the documentation of the
> skip-worktree bit, I became convinced that this would be incorrect a fix
> because the command really does what it advertises to do.
>
> Then, I briefly considered introducing a flag that would change the beha=
vior
> thusly, but ended up deciding against it.
>
> The actual problem, after all, is the git update-index call and that it
> heeds the --remove (but not the --add) option for skip-worktree entries.
> "Heeds", I should say, because the idea of the skip-worktree bit really =
is
> documented to imply that the worktree files should be considered identic=
al
> to their staged versions.
>
> So arguably, it could be considered a bug that git update-index --remove
> even bothers to touch skip-worktree entries. But this behavior has been =
in
> place for over 10 years, so I opted to introduce a new mode that does wh=
at
> git stash needs in order to fix the bug.
>
> Johannes Schindelin (2):
>   update-index: optionally leave skip-worktree entries alone
>   stash: handle staged changes in skip-worktree files correctly
>
>  Documentation/git-update-index.txt |  6 ++++++
>  builtin/stash.c                    |  5 +++--
>  builtin/update-index.c             |  6 +++++-
>  git-legacy-stash.sh                |  3 ++-
>  t/t3903-stash.sh                   | 11 +++++++++++
>  5 files changed, 27 insertions(+), 4 deletions(-)
>
>
> base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-355%2F=
dscho%2Ffix-stash-with-skip-worktree-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-355/dscho=
/fix-stash-with-skip-worktree-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/355
> --
> gitgitgadget
>
>
