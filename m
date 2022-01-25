Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E13CC433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 15:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386847AbiAYPpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 10:45:53 -0500
Received: from mout.gmx.net ([212.227.15.19]:55937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345591AbiAYPnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 10:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643125379;
        bh=EBH+/+AxXq7hLnr6Ug+MEHzVFpIb9pTAtpatf+qjlnA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CRFceEyrAr00uhXD+NZ3MDQJgh6vzYpW5qwdaLNZNr0KpZFE7vI7iReAk1IGAkmEu
         zB0/E336rcMOqlYv9BQ29YcQsZlQPxWCtt+Tyr1aJ/eyNTw/QO1OVT7HlIk3zjN14b
         2/JyNtdWOumRkzpDVA2izkIHC3mnkjuXoaZUCa/8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1mGKFT2KJI-0139m4; Tue, 25
 Jan 2022 16:42:59 +0100
Date:   Tue, 25 Jan 2022 16:42:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Cogoni Guillaume <cogoni.guillaume@gmail.com>
cc:     git@vger.kernel.org, git.jonathan.bressat@gmail.com,
        guillaume.cogoni@gmail.com
Subject: Re: [Newcomer] Any ideas for microprojects ?
In-Reply-To: <e5a0448a-4606-7ed1-78d9-b06520688616@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201251639540.2121@tvgsbejvaqbjf.bet>
References: <e5a0448a-4606-7ed1-78d9-b06520688616@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-228403446-1643125379=:2121"
X-Provags-ID: V03:K1:vMAreDbDBQ1vPqiJBve6ZV0FKsEk4zfqfPf7ajLf1p7BaRrU3V3
 0c3xFQXmrG/xnputHSKT717wobYEg/HpygZKExu1w7+wHpfVVuN1u/juv2JmDkUga57/5iB
 4tsi+QztZCkoQ7JjIfPD6hjSZXm/4aZiCorx5doI8tthBTT5tUsboF5GNNNZp25prQhJWux
 TCAOuM60QmUDLK0RLA0jQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lnFbnDXLCOc=:FzwsZUfSGwoqTM5RqHOckD
 6+fV83bxXHzrK9exlmva7GuVS2+0a+AUMoUHaTBNVijJQXjflt2lBrCGZb5Ga0rbIQobACCs4
 x4ZwK16IWecbfZ4L7nBib2AEQ9uCDXDAnNoo1QqjcN3nnlaa3ZZqh/vqHxqvgzV4SqFhfZsZg
 heozTIjd6gdfJ8r495srHo8LLuUotyayzXj9EqdwlRmulnXue88ZNBgXbVH3GD4wVr0am0KAc
 75BpAe1yVFDM+6xeYXmFSjnI1DSEgCm23stCfq/6zfWF80AHK19EV1sThDAyqLaGq5v/h3m/b
 r6QlAgA2376xhoQavAsD13aJ4zNPU5hlA+rEx+dNDQ17cypaUwb5AbeamLQ884gUmgkRrJawc
 UbTRTk4GolbC+Ei9M0i3tebnJDWwJzlDAXpWgvveH5E1YYRuS0cmpe+ZBlA0cLNUbIv8Hc9Bl
 Otkj9DFziXub/v2Ye5kmCOBEVrU9XY8pGGOJnRgRzliwGFzt1nGQxV9kVtw4StaL9ZBqnlkOu
 EIlQq6VaDez1SxKTTZqgQnH+EteQfglSHPBnP4gNJXrTL48EUvft/TsDU1eOk2ebp8V5FXUWu
 frbx3eo6UdrGGUxbS9UFkufGYvrnlbLKvcFNZhJ+HtEfAhcLOWG+MZeo/aUxXFTlUKmoYKqyO
 hXuGdD5WBZF1Wt2NVsi3ivx//ZHE9tOWwcgT03z0Wwl+X3r+MORxNaKjwQOmK+HxYTFr3qzKy
 QZdSuyb6Kk95cvXZGQA/HlSX1VyekBzXC7g6XNCMqdV43GrI1/f77eit2tvIPbTDJAn+G7u2n
 zz27fHghyDOQavNrd0h+8VQFuBF4Jjs7mcWFj4Gs8xBqvyPu1x+NRoNsAgu6AaTC8MtuVup/X
 wm5Z9C9fDaSK2k172eA0b6BW9RSmr8afpk1qhSD2ISY7BV82vac8FK0Ck97OyHRTNp3iIzcQ/
 AxbW1ltAolG+cYy4oyvemC2H8CsqtbothDX3BlYzs8G1NVnsuLYqd5/sVDozjCxyb9cgShVO2
 vwjhhGtx3j3kzasZ+L61m4N1UAvbSbR1gcY8DGN7Of6nv6QrwAcN+Yn/kclFHYjMbz3HbZISg
 m6JHFcP9BAUkhQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-228403446-1643125379=:2121
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Guillaume & Jonathan,

On Sun, 23 Jan 2022, Cogoni Guillaume wrote:

> We are students from Universit=C3=A9 Claude Bernard Lyon 1 in France in
> first year of Master=E2=80=99s degree Computer Science
> We want to try to contribute to the Git project as a part of
> our studies.

Welcome to the Git project!

> Our mentor in this work is Matthieu Moy, who has already contributed
> to Git a lot.
>
> So, we are looking for ideas to start our contribute.
> Can you help us ?

If you need ideas, you could look for tickets at
https://github.com/gitgitgadget/git/issues (an inofficial bug tracker for
the Git project). You might want to look for the label "good first issue",
e.g. https://github.com/gitgitgadget/git/issues/1125

> And if we have an idea, how we submit it to be sure that we don't
> go in something wrong. Is there a special tag ?

There is no special tag. You might want to mention your background in the
cover letter, but that is not necessary.

Looking forward to your contributions!
Johannes

>
> Thank you in advance for your help.
>
> Sincerely,
> COGONI Guillaume and BRESSAT Jonathan
>
>

--8323328-228403446-1643125379=:2121--
