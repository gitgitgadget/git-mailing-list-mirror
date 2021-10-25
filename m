Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159E3C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 13:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6FD60F9B
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 13:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhJYNHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:07:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:41925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233391AbhJYNHG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 09:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635167077;
        bh=cHABubggtig7G9LoY6KwshB601sk7ZOaG0MjiuaqfO4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AD1wzLzjL8Gaiv3kFei7TdGaeY3nuc0VnWMSMMHM/ynnbH/7GHpRlzSgLTF2xZEW0
         rY8UWlY188s47ghVMEsy+Y0FoTs1fsWQ8sVxpaLbiW9XTfKTQiLwfztVJIGSm9usm9
         1k9f1BgJQSd6NGIUVT6fvoS4T9j8PKdj/tFtuqMU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1mkP3B1VhU-017TjO; Mon, 25
 Oct 2021 15:04:37 +0200
Date:   Mon, 25 Oct 2021 15:04:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Sven Strickroth <email@cs-ware.de>, git <git@vger.kernel.org>
Subject: Re: tortoiseplink ssh variant still needed?
In-Reply-To: <xmqqtuh79zmq.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2110251459100.62@tvgsbejvaqbjf.bet>
References: <dad761bf-3121-8934-fad6-78610bc21121@cs-ware.de> <xmqqtuh79zmq.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:p2yCEsEvXRqclhMBxi9k/CsVbvHEzZRiUV8i2/tTM0wu0MgNhRp
 6HUgJquXRbr6SU+LgYOgaE6x0wUrgCSES2Dghm3wS2SJarxvQdg9Yda0X0CWMhQ3SFlX9uJ
 jCO4mEs6IjL16TgpbaCdy7D2ETpax8gKkPFOAAMxGy1g5O2DvM47Llug/vT39iFn/S8/jup
 CJ0SKLWqWzYfVmkqAmifw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ss73HVz953s=:7TITLXeKzKhBUJd0zE1Ncq
 24y+KWa3ligCegTQzxF3m1dWi37mxp9UzrlaG7iJMt0Ptzj+puP37/dSAwmFizH1UNHtRmC/9
 Ujn5wFqJs95huzYEMFJ6+3VKIxlj9ZxOzGf7klZP0ONZc6Lzqzer7zvOpa1pC4aa39SNRJXA3
 yItpp8E6veJFRMkOSJMKiSSZh/zCad6Djx2xQx4riWVG+RKLuHN5F6LE7HcXdonMylIn7yyyR
 0SURGlzj9CLuUlwDvobjfm97VmH5oZgN77uD3zyGkMSp7LfJy0H6FAUybAFnLMOy6czAfDEZz
 boRKSSORNWNCIAs0t3yt21NCmOV11yO1sxEZMIPEhH85w7aS6xVA7K6u4GWFE2UhHcQUN6Chm
 Zs4WXvEJYo0Cdijwwe4R4vdpvLrXiESsq4ISu2dNAK8IUsK/DeWcdROnRUy2JKCB2F0RAn+9V
 n2qznCRiSQPejce7w86Z83/0WjuOnwQHNJMxYIzZNRa7SfMu+TAP1qGjYiz18HdPWKtN7m+hU
 16KmhTDufz3c07Ztq+ZV+pco5OUytXufaXacin9F9qmM/CEWxywBR9tkndwtZVY7HuprAIJb4
 hckPh7FCPThcQgBqWvoXDZgmTzTzJoNdDrWYvqJul8rRoTXZK5cU/fyC9V+LSQjrOh9g4UyKQ
 MN8RsElxfoBb89N9aMhstkhn1SQkYZuJgfAiIjrIdfRqPD2Uuukx760Fxv78EohDjXr3pkyg+
 XnkpW0Ws9r83Ft39NRRWXX4/4Rs3/WTbv4Az2KSDhG3i7BC5B7uZBMvccW8N5lKME0UyPkr+u
 ro1dtUMF+1585H8WhrK7HTf36Kp39xXi4IJ0+k1W+RFJ8NMnQ4BqXzWK+wE45HmZDtNB5fEJ/
 RkW3FZTILRDD1dWlwCP60pa/p/suAyJW1DlB4G7Dmp3W7zX56MeCRRBwoXOUvF0jOf///bmSy
 lIAT2oiezFisRjqKqDNbQa5CDUAe0vSHr9vpVwS/LUojYAiv2tqp/Lo5eecGTg0sooU92b1bu
 D6mzdGF1y7HhLOYDzdED45HaV+TdX5x3gVyX+L5hv6SfP4mJuYbGx0JGhpwlVzW5KTRK7C5qx
 0w49DuNLHxJpM4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 23 Oct 2021, Junio C Hamano wrote:

> Sven Strickroth <email@cs-ware.de> writes:
>
> > Therefore, my first question: Does Git still want to support very old
> > versions of tortoiseplink or should I provide a patch which drops
> > support for it?
>
> [...]
>
> I am guessing that nobody other than those on Windows use
> TortoisePlink, and that everybody other than those who build their
> own Git from source use Dscho's Git-for-Windows, and I further
> assume that the GfW comes with its own copy of OpenSSH.
>
> So our intended audience is those who started using Git on Windows
> back when TortoisePlink was still a thing, are still happily using
> TortoisePlink, and are willing to only update Git but not migrate to
> OpenSSH.  How big that audience is, I do not know, as I do not do
> Windows.

Nobody really knows, but we started discouraging `plink` usage (also
`tortoiseplink` usage) already way back in the msysGit days. AFAIR we
simply ran into too much trouble, and started to only offer `plink` as an
option if the user had _any_ PuTTY saved sessions.

> How much maintenance burden is the "support" costing us?  A quick
> scan in connect.c tells me that the "add --batch to the command
> line" would be the only thing we would be able to shed; everything
> else seems to be shared with plink and putty.

Since I have to assume a very small usership, I would think that we can
drop support for the older `tortoiseplink`. But you're right, what does it
_buy_ us?

My guess is that Sven wants to go further and enable the `-o SetEnv` thing
for protocol v2 (which we figured out together, over in the Git for
Windows bug tracker, to be turned off when pushing). But that would
require the `tortoisegitplink` variant, I think.

So maybe a better idea would be to focus on introducing support for
`tortoisegitplink` and work on the `-o SetEnv` issue, and leave the
`--batch` code alone for now.

Ciao,
Dscho
