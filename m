Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF01BC433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 11:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F14206C3
	for <git@archiver.kernel.org>; Sat, 30 May 2020 11:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="U6HmRENJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgE3LlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 07:41:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:36143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgE3LlH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 07:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590838857;
        bh=0eXlTjACwY/m7XRePH0HF1o18HX/LkTAneCLZvuNsVY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U6HmRENJ5oFHfjPcV1j06JWPp0D2ulmWESrcjaZQy3oyvp53LlTIqylKcU3flNDV1
         EKigOCugjPfCVB7xyrkyt5KnHHom/wmx+WnZu3MrUsFAnOBbMG9PhGxQvULJay0Fes
         WrcPxSa6bK9VbvEhIdknt470ih9ICakntiOvAlgg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.215.219]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1jA7222e4h-00nRZs; Sat, 30
 May 2020 13:40:57 +0200
Date:   Fri, 29 May 2020 15:40:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org
Subject: Re: symbolic links in Git for Windows v2.27.0, was Re: [ANNOUNCE]
 Git for Windows 2.27.0-rc2
In-Reply-To: <20200529223200.GJ1915090@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2005291539080.56@tvgsbejvaqbjf.bet>
References: <20200526204539.6181-1-johannes.schindelin@gmx.de> <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet> <20200529223200.GJ1915090@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nw5vcfd7oX1So24+dxWLibj0FOVZElIQ0a+ScmyZ6oYpsVEvYDd
 ASQcvJNCkZhQGGBKXIAs9JSUOpB1eqaECFxAHkxsytYW3KqMwGDVdeLrJUJU4+ReBa3sJci
 cQowIR6dKlBXL5dOVOQO+UaDJL3IG+gJHye/W5V460b+7C1rtYMlTN25TN4ag0K7bE8Yr4R
 KMgzHjMbZfB1sFBzh+Tfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ecD7RWZ2nQk=:V7JMBfLHM3s+qz5x/bC1wE
 fzdMWZ1DF4+7YWGARZ7O9eqToiG17li/eLRRT/Kp28d7EkvBOua3COM8qK8Tytc4xrxft7kwe
 iE/oUsB9yuFpGy3TEVsj9qc1MuQWP9zewok1or3xSaM0yfV/jM1S2Rq9X2dz5Rbkt5IQsPqla
 vKqrrBiiqFA54k5O1JIBsawzZaf4tk2Pxs8YbwZklru84tiVHnuee/YTHPrKSWpSfvDkrlpAm
 nyjBD5eUBpN8JtSZvNHtVVU2bIuyPJiUIVFAYvfygu4RxaGeaBW5uN8Jx/+fFzoa3JzTCNQxc
 7MVYcMGWI/NWOvgfULkX852f9ssNCiiHtU6bxHXeDX92iR7D8lrIXFrLpepZ8UWIQ5f/wk/Sr
 ns1gduckDbmLQndR7MByjuVlqNQPgP6bTYgfrJ5XQMGYlY5+9bij4lIMpCuCWufbY771ye1wq
 Dx269jbedj2KUHBkLwa7UwF64BIbmjGHjcYDTDHwW4giomZutN8uynj+Db66RrGjsEtgc/pqr
 pOOfQQpgeYjX40W0lFyTZO1JpQYuW4bcO0AWGhP3as5F134ch0DIUb0GDvoIxcz8aaqT4WYLX
 HTxHnhQ5REcYdvFJIl5lqhbd+Jr1exl/2DSn7gpA7sHlqic0ei7eUsJ/cUbjLX/5H5Aia6kBT
 Owiu4ygQeNclz+27FANlRKIf0pubx8ZVCG3Es4hYCSaSz1UiGQ4p0jOb2Dl/58gmJSyvEtp8S
 CI8XaWMlPy/N9TfE4PWIY99seDtHhwfid9XjK8wftNGWmsjUaaczTZ1qgkya4zSdd2MdvxZRK
 GSFIVmuI9+DiXae1hN772jhxMfFu5Rzx9oXz3RUBy2aF9AwO1S8hjwAqNTgnJtEinnvjv81Ld
 hgksVdhq1qCncVMsorId8kH+zfkdS4e/0MZImSYw/f2cdZ6AK0xAXH/wTnYZv2kMLPr+9hP89
 bw6ijH1Kj59Rdsbzt4NELswQ5Cr2iDu9le9uJ7ZkNnwENn5FMLcLUBD5YedsurKQekqS+mlzK
 S3ceuZLQI6egoKHuTabW+pmxrzgyUBqH087aujST9vMWKMIycF9jI9Ln42ocGvUemMBk6NNYw
 VtMDZ/8Ge6Ubx94NzJB3pgabEijpMZt3Q2WS60KeLg2uziF8Fsx61Z7ocaiqeCL6g3zgLaqpG
 x16lTrhCgk9ZFQTqjxVu5qt3ImenYuGK4MlRt8iK9h+L0aYtnSt+lr+g0ysGUoXdCiXOWHENx
 EQrX1Izxp4vt3orHG
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, 29 May 2020, brian m. carlson wrote:

> On 2020-05-28 at 21:35:24, Johannes Schindelin wrote:
> > Dear Git users,
> >
> > On Tue, 26 May 2020, Johannes Schindelin wrote:
> >
> > > I hereby announce that Git for Windows 2.27.0-rc2 is available from:
> > >
> > >     https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc2.=
windows.1
> >
> > Git for Windows v2.27.0 will be out on Tuesday (or even on Monday if G=
it
> > v2.27.0 is released early enough). It has a (last-minute) bug fix wher=
e
> > the length of symbolic links that is recorded in the Git index is the
> > _actual_ length of the link target, so that `git status` agrees betwee=
n
> > Git for Windows and WSL Git.
>
> Thank you for this.  While I don't usually use Windows, this has been a
> pain point for a lot of Windows users, and fixing it will significantly
> improve the user experience.

To be quite honest, I had no idea that it was a pain point, as it did not
come up on the Git for Windows tracker.

Do you have a list of pain points on Windows that you're aware of? I would
love to get my hands on it to triage, prioritize, and address those
issues.

Thanks,
Dscho
