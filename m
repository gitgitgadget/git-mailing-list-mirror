Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC992C33CB3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 21:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B787820643
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 21:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="V68wZLgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBAV24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 16:28:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:36523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgBAV24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 16:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580592531;
        bh=ySgjQoctZW3MGe3Cn7PSHyzNCqD48eI4FLBLwgLpIW0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V68wZLgydsrTPp0JKRf45SLlpTwipRG2qDu38vr2+if/6SYDBOQHa6iTv6mn/LbTY
         VrlPNfRJurUlirFqZ0tWg//QW8Yubf0BcdEGM//Kp9ydIvYcCVQk820/ZIaTT+vF3E
         jbpSTcZ+TH3LftqTAcco2P4bePRNUk9Bf9b8kSBA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQkK-1jkDBb1F2W-00vO3S; Sat, 01
 Feb 2020 22:28:51 +0100
Date:   Sat, 1 Feb 2020 22:28:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     jnareb@gmail.com, christian.couder@gmail.com, t.gummerer@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [GSoC] Finalising a project
In-Reply-To: <20200201173841.13760-1-shouryashukla.oo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002012226350.46@tvgsbejvaqbjf.bet>
References: <20200201173841.13760-1-shouryashukla.oo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Gc7rbaRDzipJzOtj9hQjL3xeKYOHveebvGmCb9k6yI1XrwfRiMW
 hJ1wKXnV6jb9oxTV4Dp3sh8FGiuE+61tkjq7xaVBxKcyvNKZ3Bshj2XvNZt2VLnY2uHZ5ny
 GUB9hLoau6liMH0xxXLjrc7vrntMKCVgj9JIO7SqpEJdJfsZDmndctWXA6z9TOnwY9vAwMB
 J7EWkm7dw4TJWaAzZWeRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4HpwMwL7vAY=:ITFu6h25uri2gJQyAQVHA3
 Wfo6dxqfmljD/MVpCabC2kknnmavkdOrJy7mLOLFHx05l/p2xwvyex+yIeCwI4lEZ8LCbqe61
 eej9W4LO4OZC/dhJqAAyIfqOpCMQQ/Mf61qME6LN+JU6UnY2XkdLOwZHZnXVtZ6wsg0zkkkNu
 yd3OQpbNiIeglpmfSwkWfOt2osUFzQLDJ09NVzsa2P+cK4/1jPFvF3K+qYf3QI2aD72OWGRj2
 pwbBfnkVd8M9ceS12O8K4AFlixfXc70s3yEIyfTk+z88aSUeWysY7ceA1HXBaz5kxyOOhM90m
 ZE4SA7Ln/l14ZCXtFjL+U6f+AmiMuU9PM1eLFBEvrMh4C6lfTnZvA6M6Wvyk5arylEL1jlRwT
 /L5r0c9SzRfh1QwW4si4iL4NKnY/Ea64Q2UX+cIB3ItNzjibSy3s4Mtvig60PwouRfOnDfwA4
 zUcbBUb1dHZJAdE71JpNOKyfIMmcdD4fYMNMxdU/v/pDmNNuUmOvCXwR/dXO+vhHlZeNS4pHq
 2CF9N3cStYjObwcfgJMyViEedTCD6IUe+TJ029dQqIW2jjItxG6JTcExQDNl24RUEGcPDmc1/
 vdTRnmhOevpUjqRUaAgLtmQ3B5dkQFfRPYkPNAFV1qmoZ9MJnkFPyjwuSRxu+GK6z7VSmYgOJ
 qCeAWXhsNHY6SM/fAB0W5A8Ly+7QsddS6dyeBhs6EBIC3YOAHcXeOV6udM+FXblKaij09hN54
 9VnDWC7+k0qn2pBCRm8hi5D4L1DJNbrkBEWxjguj52c96uCGKiuKcBFYPIuoQFgpX0l25p+w/
 q4yUbJjYZ7T6OuxqT1BxpPC9L+f3utnZ4PGcj0JejcgSZeFmKb/hjd99+dHRdT306GGTvcIeV
 0jHMsCs5ALDdB0zmz6mZ8bktT2pJmnOZHMPKKN9XG+mVTmVG6UzRejg5sNveWH3cxi44SPTrj
 HRIETGGWKaa5JAYyTtHYwTzQeBLnMHAMrFvXF05uK/9qkBTi10/PbLyvKTswFhups/v3jUuAK
 E/5stmrv/jPP6UfFeA3mwvwvS7xfclpReG4yaYyYUqHwjB7WnSFf1HawbSvqr3H+kCTCdMWj9
 k4lL+ZMn78EHtzQA9OlVl6fTdY6/xWPScjORorvTgfPl4LF1RSgW2l4zhIqZ7qxg75wtwsdhn
 axg0ZB0VdaI0AG33rwcFqZvX6PzbKeAmNy3gt1uYAK21t4lQAIHykZoFQQzYUaMPuhvG1QI2u
 1+1ty1kldq2rgebKI
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Sat, 1 Feb 2020, Shourya Shukla wrote:

> Following your and Derrick Stolee's discussion[1][2], I wanted to ask
> if it would be okay if I start working on the conversion of 'git
> submodule' from now itself because I inferred that it would take
> quite some time to complete and one season may not be enough for
> the same.

Oh, there is no need to ask for permission in open source to start work on
anything. Just do it. ;-)

> Also, if the need calls, I will keep working on it post GSoC as well as
> it would keep the continuum in place. I understand that it is not an
> easy project and will take quite some time to complete.

Indeed, it will take time. Note that I do not even know whether we will
participate in GSoC this year (your email sounds as if you assumed that
you'd "start your GSoC project early" or something).

> As of now, I am researching how the previous commands were converted
> and check if maybe those ways are feasible to convert 'git-submodule'
> too.

That's a very sensible course of action.

Ciao,
Johannes

>
> I would love to recieve everyone's guidance on this problem and learn
> ways to solve this!  :)
>
> Regards,
> Shourya Shukla
>
> [1]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001311007590.46@tvgs=
bejvaqbjf.bet/
> [2]: https://lore.kernel.org/git/39a8c249-f0bc-fb0f-2ed5-5ecceb6d4789@gm=
ail.com/
>
