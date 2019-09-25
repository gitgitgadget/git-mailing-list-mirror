Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489341F463
	for <e@80x24.org>; Wed, 25 Sep 2019 15:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439685AbfIYPfW (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 11:35:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:33375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439481AbfIYPfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 11:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569425715;
        bh=rlfqcnmwWsTOdaIvj+bAuY+E7WLBqPgqvi5qsJpJHYc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=THWxtam/B+dq82NSxYUDZgb8xK58f96nQmLpi7wumkOu1cnyyay9Tc4tRMGQH/uRA
         ppW6dsYKeZxC+XDnGPP4Z/FEm7Iqo/2Ys6eg7s92vW2aECzPZXqKZt8/9Sfw08a+iF
         UtxUB2QVlIPRnkunhdEPQKa7jwf59CIIA9yx5SJw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7R1J-1i7Lw625KX-017l5J; Wed, 25
 Sep 2019 17:35:15 +0200
Date:   Wed, 25 Sep 2019 17:35:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kunal Tyagi via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] git-add--interactive.perl: Add progress counter in
 the prompt
In-Reply-To: <pull.349.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909251728370.15067@tvgsbejvaqbjf.bet>
References: <pull.349.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eo/SpPOaw/qPbuiJHtEBxPGejZSezcc6hEOMI3m6cj6Y2pf4dUJ
 sH89C0ZfP0XUA5iEXKeeDpwP4ff2MJXPg/QP8YI9XsNMXma7VejYizmRztlJhRKdAtBwsms
 lcmi763f0874wm3BxmUBpMeAGzEGxdZ6QobTp4ctSXJvPotXXpAZ3xkq/uSq9PiuUf4dQp4
 r3aepLriHLBomHrnQDjZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B2wFt1S8ARE=:IodVcxF911YkFLYNEtOkdi
 dwfeONO1dRziqf3ehUdcPz7/ICv2i7rgR4uKD5vpJ31huGN4IMKRpukxr9XuWYPszkrIBig6e
 yZmbLCJ1XegSuV9pkgIBaUMutPz7Fw1t/Ma22VZ845V93p4O207jEwfpYAMQS9+zpjDX/c7KW
 s+aEMcN5Qen4EntsamgPm7fQXDQc1p3vkVtEWFhD5stUAPWf1N/SQoaZViNl725VrNMe/UwIG
 7bd3OBC1+exzfXU+MqAf3G6Rg7qv3nbiUwxnpUY2A3tIz7Llz81JmhjJur/nsazba+payZF+/
 J4Ct0o1IBmAAb7hlU8OKBO3C7yb7UpcwhsAWPxnEgq6znN2GJ6F3cw7a04aRFeg8rV66jY+GL
 +Wxy+ntSTOsNE9qXq1IkuF/zrR6p9NEVFlsXUFEd8UI6UK2lmyXiVr5CFjNxgQhG47p+rDE0a
 xhg8XDRi0O41iFuhqqJ5V6fIoiTij+IgYco0r56AUwpvxzVAWjqhJEJV8MuKYZAgc+UXe22af
 FUdJWPx22gJCK/wOq32EvOSlLoSwxAdhWMES60osBDUxaCr7OwrygQiXK38JhWvFDQIkCwgME
 pBtqqHlF7GWF49tlF1wgfd0ojoz0oMzZH0jNTHbNk29jKmuTVMYqGk0xqNC7RFgp+Uv2Heyjy
 y6ieB4W618EuTsI4syhlSZMEWowW5zqrqlFQ5HxmyvJA5X3i4czTfCmnGmC8J46sRF0qT7LZd
 phcY3PYZkLslnf2WXrvFS2T6+S//akzUlI8wn4T/UIGucCfjmr6+QrQe9i4uzH6W8dG5om1PF
 Q+9lMwJ4krIoLoII4og+Um669X1L5dRdI37U69wWS+VWIH7aY3wkhy8wjAFHXphDXybqEg01o
 Dj6EvBUYFUAj9rhqJtGHfOeA6cNXAo2JxZLOhixv0yHYCHbNK49vQrDa8e2tcrTk0+VCN1HGi
 ryutowjRCE3HWmG5b8Qh3gA3VizU9wRVbEBSiy5KqWmUqOlXy8x6CGLEZUf6i3CxMFfjqxSST
 iCNiQG8Lo4dRenYB+PhMMq7tEUjmAKbnhLtkkpPkJBrTqOwxLB+M8jzme19oYO2IINZckgFLY
 PS6XAO6s7pDGHTYeLazs8T8H3oCnA4+tPqhhchxBVCN4UmDAsWWerjLDQAgjZd8XwlvhR6jao
 jFGK7gWwUJ0nv/OS85LvgXDUdXIVLsSBrvTwm6xpqrvaTRnPueFz/jNQErX+GB3P1PpkKTNuh
 fp3JQGiSdJ82MNHR0+tRXjVr35fjgThkPjkkQ0078c/CD8MmotAy7bcPd5gI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 23 Sep 2019, Kunal Tyagi via GitGitGadget wrote:

> Hi git contributors!
>
> I'm Kunal Tyagi. While I was choosing the relevant patches for a commit
> using the git add -p command, I found that there was no feedback regardi=
ng
> how many hunks from the current file had been processed and how many wer=
e
> left. So I decided to add a small change to the prompt which basically j=
ust
> displays (${current-hunk-id} + 1/${total-hunks}) before displaying the
> prompt during user interaction. This patch doesn't account for all total
> hunks, only per file.

I like this idea!

> I don't know perl so even this one liner might have mistakes. I did test
> this locally and hope this works for others. Personally, this change fee=
ls
> helpful to me when I have to separate a long list of changes after an
> erroneous commit.
>
> On the #git-devel freenode channel, I was informed that @dscho is rewrit=
ing
> git-add in C. If so, perhaps a similar change could be added in the rewr=
ite.
> I haven't seen his patches in detail so I can't comment if it'll be as
> trivial as in perl.

I bet it will be trivial to implement it in C. Don't let this stop you,
your change should go in before built-in add -i.

Thanks,
Johannes

>
> Regards Kunal Tyagi
>
> Kunal Tyagi (1):
>   git-add--interactive.perl: Add progress counter in the prompt
>
>  git-add--interactive.perl  | 2 +-
>  t/t3701-add-interactive.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
>
> base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-349%2F=
kunaltyagi%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-349/kunal=
tyagi/master-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/349
> --
> gitgitgadget
>
