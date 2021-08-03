Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887EBC4320A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7023560F41
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhHCWxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:53:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:43387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230141AbhHCWxY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 18:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628031191;
        bh=SWlVsGF06WCCPbs1F0X1e5gj3VJqW9oOD84LOeTwAWI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b3HqNOJS4Cg5JitiopOSeIOjgQTFGxo/5d/qVn487+ttux4go+q7RomFI1t+6n6YC
         2e0TeX9qS7RHmg1CEdAGyWOts8P5kJPHpsJhCIi0fmzxqvu5PYJotnptnXgNlLKmmG
         DkE1tCTjnvr7x1f2x27a2WfIfvvUwvbkmu5ndbaI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17YY-1n8oqj0uCY-012ai3; Wed, 04
 Aug 2021 00:53:11 +0200
Date:   Wed, 4 Aug 2021 00:53:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 01/10] git-rebase.txt: correct antiquated claims about
 --rebase-merges
In-Reply-To: <ab2367594a3267a5f8d01cdfdcba576f286e3823.1628004920.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108040052120.55@tvgsbejvaqbjf.bet>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com> <ab2367594a3267a5f8d01cdfdcba576f286e3823.1628004920.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1Spd05I4nE5bDe464862EoofnyJABYE/z+5D0uLIAzy/W9OVXP6
 VD73o0so9lVSUd5pyAo07sZFbtgmDmOlBHl8U17d5LOoW98O66gini97cZU59M0eOKYM/a7
 KoGnamI4zZbLrsdH7xtueU4uEnDp3zXnA9Nex8SszPeqabGFw31gEQJC4GYYxg0FTTSxBQ2
 AUOb8z5ohx/hpAkhAlD2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/zvZuV+75Hk=:7fhhtaLsD/QcTNfLZwsaLY
 yO+GpUBUYXQphazAn0RkQovz1W2/lj+7eh1DrvjvRL3PvdEmC5LALT537ODj+6pnZp8JDHYo2
 GeikyOy+apD9PPvADteSGQfGamseiRWKkZH6k/XBUNmxM5GTkMtPz2GCl0JF8TXYA0ObvCl1E
 7aE78xvrkTS4mB123B0d6eFfsyeZHST7eT26gVvL4jEPGfMziAKwXpm98cqo4+aDPFbFxK/Sq
 IIzSRiRiwOPlnP6RKVQpTuuaSupZxDrF1TfCU0xAZeLIAlKCx57wdRuyp444B2ClZ6sVfPwvw
 eRfgtq99yqHBWuJyWhFz45PXzmh0KWjdKExm4CJYosvkyjU+99F5yWFEW8jTZzPU9PhS2SKAJ
 o8+KNrLJ7s8vAcHa6EGXHcxayZN2k9F4pwiCq2OVVlF3WlQscYwd2AyUYRwsXUeVfJpAGgnEU
 0l6aiRi8sEye68RG5kWXBNPlYmsstD5KstZaDIn0zNWC9FjBD2g6YDpI6JnDFc+24b4tJFbCm
 dPLhiIDt205S1sUIYLJi7hXxFYs/0JprzQ4+xOUSE0LLFofhxgfp818V//AYzEqsgJ9N+QnG/
 br4cvMU+jhscLyOBi2GInHWr7Zq7gRw5n8P3h0l49WUB4ol1aQ7j7G5INbvgyWfsECJQq2/7J
 nnDpvAyLQ671X1cf6CC5jqmyTLAWlhT/GFvAzDzDX2x2FBf2ZWicNxDuIh3dRlpxeLdynZYho
 BTkk9PwKGBH1jTFZfqcUuhW8SoWXOGQ4zHM54sBOWOxmUpdGnAYxF4qwNeyTVyzF8/OEvPv5D
 Kj2pUCJgxaejDbxSBQWmH1HagOEQ4IKmfwVu0uZg85XXxoUJqfF6+Ar4MDu5CfxYE7xXMqcX6
 2r5Mbk7TRdweF5A/J7bgT+VYwV93qyrVWsIvA/unKMKuGBGDnzcyz2J4gxh3uBfM+oDjY/tB9
 eEwMtAjKrBly3+l6wXkxO4V4tscwZfZYoSBq3lj/s4QJqs2vvnYF/IUeCzVDdmga+G1iLNJI5
 mI8RP1xdecrBGuqEuJym61tHuGun//i1VGtx8YP1p3FZX5CRoCH3A7Rt48xoMFqcOwPXNDIYK
 g9TVszEZkMPzuQD0Z/L8b09I4bPMLY1OMTk3xOPCrEnVQBdyyEyXHlDXw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 3 Aug 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> When --rebase-merges was first introduced, it only worked with the
> `recursive` strategy.  Some time later, it gained support for merges
> using the `octopus` strategy.  The limitation of only supporting these
> two strategies was documented in 25cff9f109 ("rebase -i --rebase-merges:
> add a section to the man page", 2018-04-25) and lifted in e145d99347
> ("rebase -r: support merge strategies other than `recursive`",
> 2019-07-31).  However, when the limitation was lifted, the documentation
> was not updated.  Update it now.

ACK!

Thank you,
Dscho

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-rebase.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 55af6fd24e2..8a67227846a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -1219,12 +1219,16 @@ successful merge so that the user can edit the m=
essage.
>  If a `merge` command fails for any reason other than merge conflicts (i=
.e.
>  when the merge operation did not even start), it is rescheduled immedia=
tely.
>
> -At this time, the `merge` command will *always* use the `recursive`
> -merge strategy for regular merges, and `octopus` for octopus merges,
> -with no way to choose a different one. To work around
> -this, an `exec` command can be used to call `git merge` explicitly,
> -using the fact that the labels are worktree-local refs (the ref
> -`refs/rewritten/onto` would correspond to the label `onto`, for example=
).
> +By default, the `merge` command will use the `recursive` merge
> +strategy for regular merges, and `octopus` for octopus merges.  One
> +can specify a default strategy for all merges using the `--strategy`
> +argument when invoking rebase, or can override specific merges in the
> +interactive list of commands by using an `exec` command to call `git
> +merge` explicitly with a `--strategy` argument.  Note that when
> +calling `git merge` explicitly like this, you can make use of the fact
> +that the labels are worktree-local refs (the ref `refs/rewritten/onto`
> +would correspond to the label `onto`, for example) in order to refer
> +to the branches you want to merge.
>
>  Note: the first command (`label onto`) labels the revision onto which
>  the commits are rebased; The name `onto` is just a convention, as a nod
> --
> gitgitgadget
>
>
