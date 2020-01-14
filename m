Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B10C33CB2
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5857A24670
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Phl/mIHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgANVuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:50:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:47601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgANVuk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 16:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579038633;
        bh=ZB+di3cllSIk5kuTFUOJ2QNWo3/6KpdCZgopH20/zik=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Phl/mIHmGgW0jsks7zWS0KCXX9DpM18a98aQN0u5gpVTSxMLfyJHs/eJ642VSCz6o
         c5St/9plbz3EQcFiQXQW09oYZrLk20UJl1oUq1XoaYbYEDMjcp024Uvy8mj0EJ52h8
         TN6qOFxVdIvgVZeXPninC5bk4adJDSjtYVlsLnLI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXFr-1iw6e00YJF-00DX04; Tue, 14
 Jan 2020 22:50:33 +0100
Date:   Tue, 14 Jan 2020 22:50:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0
In-Reply-To: <20200114024938.GA17003@generichostname>
Message-ID: <nycvar.QRO.7.76.6.2001142249020.46@tvgsbejvaqbjf.bet>
References: <xmqqtv4zjgv5.fsf@gitster-ct.c.googlers.com> <20200114024938.GA17003@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-926607568-1579038633=:46"
X-Provags-ID: V03:K1:QALsYtO98dZhdd9SiufgtBCu/2EpPXnwNGMmbRqxS0/Hf4TktHU
 OzR3MQFgt7sTF5j6bmz5x8rozn/xXBz+hG8RYTXYpFC8Gn5qDUHq/PD98M8WQBGIUiQ9RJa
 Y23o+AX3h/IWvSm/i6j5uj0n9Wma4eQSHdxeFJj1yVcxVLQyewVlRMepjTtTQ2GYXx8Jbwq
 iRyJaIOkaHTUOPDVHQ5jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EyJGbVMYohM=:MJyQXLY+xU6MRhrLbDUOZb
 2paO9z8wNgwk9Bo/LYoYMS6p4YT8heTyzFCtRpXIl/LHj/lq8M68WnayXw/9xHn8FBaT45xIL
 Qyx4sKYi+heyXhSAhgbWr58JbJ24hECrVr8AjTQYN3Z/9SwR4R+2VqzaAkLmpDItNqFkNgr/4
 iy+Zzsp63wZWN6gUMWk4pic7nK0J+HGHxeQ2Tjwg4vYgiPZdnd9fiEmdvPki9yvELT/V04sxE
 MnhFr00B0h9Pb3gd1VnXgXCsFcuBSI3Q60HbYIiwy7TggSeXh7J1LvQmxQpUFb0ym4Cc2Pqf6
 o9HEV2cK7sQ9mIE7j664WJ8s7t31Ojcy7P9Qxyi6cJw73Zsp3GNRKOecbSEXTYa0Jm2Al8OLn
 qDhNW4NEGiutT1YrLIObC5dWBJSfcvTlQPk5lLunAH/09ErRFqnfwayTMuvA4ElY6HHEw+A9I
 A6ZNBRojuKRQvwyiA8hUIt0Lag7oPCno98s98A7lCypzQAXwG26henwTae4L4waOXcd4cWP7g
 SZ9Qqlfwrnb2PTZ0zHzZxmps1zco/IiVeUSSymPglusryC/zI8vQRmAroUuEejaWq0E0musHZ
 3M4q/zBgqi77B2urY5PJHapHKHamot7NBDXupmR1DnlF4mkOrrIw5tqDGimobf6mYknWQbGzF
 p6UXhUUd664VPu37ua72+qpLTk0VxelT8P9TZ0OjSGATy+izReliFIXT+CB6n/evebz8IsLgh
 UAUqC4ZqO/FpKWuGCEBgBuMjgt10pmbXKhdJICC4az9+eWDUWACTTirT8NGP3T9BotOZjHzQn
 3nC02ywku5uaMx5U1eAvom2Nry+1ZRlrJuJZMDNSVnoYWk8KeWOVeDuNyewtLwJC4mYqbH1xR
 HwmGpFOXDR5i0QPz6tEae1WfX3dptkdIcgq9Pamak5K1pPPNij8YDVq5E9GcDBEGX8FcUWLqW
 KdNKbhECDUNaUSgOLTxjWp8QQ0shz7sPF+re8Kn483/ODSu6Z9w8LTCCRBd6AD4hTlExfeIpp
 ZcgGtjNgG0Ur+9Tu64usdxXfyLTP7FJVdYH5t/WRjrD9lKZT/UfwlcOX2qHCnmOf9e73Ssqv9
 EmegC1a9J2D6AwO7Inrfxucp6ZDNBcP3xjajngzcyZDthk7t5IfSiZuoXiePPZ+V9WHfJ0yJn
 A90fckNMBbW1ZODiQR14eiE8eIvL0fPGEHBljV858cKdR4A3Yo+86Xml47CuIfZQQ16IXXpXD
 +w3H2RZ+R/+N3wA2mkVPQDAyI7p5R9lV0NDpopXyFTyAapwhxaqUVTFh6gb4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-926607568-1579038633=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Denton,

On Mon, 13 Jan 2020, Denton Liu wrote:

> On Mon, Jan 13, 2020 at 11:28:30AM -0800, Junio C Hamano wrote:
> > New contributors whose contributions weren't in v2.24.0 are as follows=
.
> > Welcome to the Git development community!
> >
> >   Ben Keene, Colin Stolley, Dominic J=C3=A4ger, Erik Chen, Hariom
> >   Verma, Heba Waly, James Coglan, James Shubin, Johannes Schindelin
>
> I was quite surprised to see Dscho's name in here until I realised that
> this was just erroneous authorship information. Below is a mailmap patch
> to fix this.

Thank you. This is the PR that fixes GitGitGadget:
https://github.com/gitgitgadget/gitgitgadget/pull/188

(This was one fall-out from the change that lets GitGitGadget avoid
sending a cover letter when sending a single patch; Let's hope that it is
the only one.)

Ciao,
Dscho

>
> >   via GitGitGadget, Jonathan Gilbert, Josh Holland, Kazuhiro
> >   Kato, =C5=81ukasz Niemier, Manish Goregaokar, Matthew Rogers,
> >   Mihail Atanassov, Miriam Rubio, Nathan Stocks, Naveen Nathan,
> >   Nika Layzell, pan93412, Paul Menzel, Philippe Blain, Prarit
> >   Bhargava, r.burenkov, Ruud van Asseldonk, ryenus, Slavica
> >   =C4=90uki=C4=87, Thomas Menzel, Utsav Shah, Yi-Jyun Pan, and Zoli Sz=
ab=C3=B3.
>
> [...]

--8323328-926607568-1579038633=:46--
