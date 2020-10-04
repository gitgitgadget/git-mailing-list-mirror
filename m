Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD57C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96BD20848
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bMKM+GPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJENIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:08:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:46425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgJENIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 09:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601903301;
        bh=gPeN3m7QztbSh+8J1e6WM5/CkJ5eIfwJbFobm2i6bbE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bMKM+GPRciuq6OrfdEucUacA4ZX/bQysLhwu+CiPKCBItXmDyOKi08QP9qmkkRucn
         afAmcyh1i8UkobMTlj7F4N1pB4CpXwqfM0j1gmSwrM41Zdnp90r1iPuxcWMS4hOHMS
         Bubsg9ifNNxtMX1czQEThmZiFQKNCi3eX+tvaHaI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.214.27]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK4Z-1kgx6q357J-00rGEW; Mon, 05
 Oct 2020 15:08:21 +0200
Date:   Sun, 4 Oct 2020 21:18:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] po: adjust for the recent change in
 send-pack/transport-helper
In-Reply-To: <CANYiYbHtC1VkMJ=R=q+g4jbU5GJiBQMczUtj=LD=x=F2KLpfwg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010042117560.50@tvgsbejvaqbjf.bet>
References: <pull.742.git.1601763568860.gitgitgadget@gmail.com> <CANYiYbHtC1VkMJ=R=q+g4jbU5GJiBQMczUtj=LD=x=F2KLpfwg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2008032156-1601839087=:50"
X-Provags-ID: V03:K1:KDLQsR+s9dVhzGwPq2E+4TiOpaSsB558VQz91m33wuQyC5bgx6I
 mXjuJbdui51Xdsx9hUDrre3F4V+CZwPyuEj1j0ePnkt+5FBpLSMsdFdN59Jt34cbWK2q09j
 ZVFlQzrQuLjswJO5hWvDFJoeOQ/rrMGg37PZCzJj4y9mGzVt2m5dltLcHG0ngY/RhI4jFZ+
 U/cWNItAwbb8qX1Mxmu2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rcesNhxJhi0=:yfA8ClRgDq8+OruoaJgrDy
 Sjek8sCZEcnfG9AC3ndET4GU8/Gze5f9318L0KriU+f+4C49Q/9fb/hCRaERw/VDbtmUzzXID
 HDhFyqrLa/LskemHoWyGkhzJfexFGGL29X04tTJa9tIQZ/yY6wk+v8166ueSafvZEgnQk4Kte
 GVtFrBrChxEw74V+pr+p6XglLQBHSZDCiZHXMW+SPolL/P+Ge5bpMxWlEetOpHi22ivlo9dlV
 eSZkF1JWLt6Txev7ykFF7ucatfPC039UA+9Kig01PkP7gLb+L2J9tTPjsGeBvkhT+HD491C9J
 mnd0rTWALOndTwdyNAyrdbyqGHpzNzTsGjNqlJo/0f6R8n4U9xuXbX0RZ6nNfDG9rjLO7Zdz0
 wa//KZC2qorhTeb1UR43ctIyHJ8NBiqP7D9TtMZveQgOuct060UP1OW6S1WHLc6QDkDxnjzP0
 gO1LYyrntySNm5waso7IMJML/OszAj3iVdxUl7er3xV70YNOzn3ECEUJGDQ/Q3oJjohVRRslB
 eIcMApPHCDlA2nFT0w//OcmJYQKav5nxsPY3C9Ng0MY9a2zgxm8wbpmyYxloh7KxYrCHA5KBg
 Q3bhO9r7vYOM2PNNsOQxWV2/ZqfroLzIsNjGDGpSnU5LKmrcc+rCfx7g00QF6T16mys43USdU
 K+FS2TwFXAd6UgYEwZkGfVeOV0VHNXMfAfjVpQ1cbqOy7fL+zhoo3uQrvo2GJVNW5naNqgDj0
 5lwLAiZk3LflVBxW+oeDPvAj9QflrxJKl6UhnQrsVuN0v3tKozVfh6TQgZMTxGHiKOEW/zFoF
 6tba4j65XQQNWGvLBX36+bRQX5pWydED9RYJhE9UyL0kUvlxvcL8BwIeKrSh5FExvhPEdAAAd
 JUSC6um9c6KQalYT2ixDggCK05Y/pPeXEWvWnraDMP5iskniTYFIPOGYI64/hDi5Ro9Nc72sf
 4kDE8jkGqWo4iJQIALZxq3dR62B6d6XM9rqsn9eWDLVChhsE+jmZyrEPcoTfBznzH7RoUW1p5
 ezBsw3SuuoYv1N/OexaqJHTDxJgsPdNlUwFjiLzBcMmc/NzvtAouKWgQqxVztZEoB29NFENy/
 HZLOS/gkIQW2sFtiOz65usMpX3Z7fe3ZLnU2kDpMdh3lqn3QOapU7lDcbpRjCvPC7CT5j7VBa
 tcmxtf0VJYowZmuI1fLhl7sILlA3KFXmT+iKzEdcrwmB4TPI5+C+ob3RCblkWzdPANDjyrlYE
 RGER8RPDFgJI0Nsq6IV93W2M89XhPzDKfhgeB8Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2008032156-1601839087=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 5 Oct 2020, Jiang Xin wrote:

> Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
> =E4=BA=8E2020=E5=B9=B410=E6=9C=884=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=
=E5=8D=886:19=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > As of 4d04658d8b5 (send-pack/transport-helper: avoid mentioning a
> > particular branch, 2020-06-24), the message does not mention any branc=
h
> > name anymore.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     po: adjust for the recent change in send-pack/transport-helper
> >
> >     I hope that I am being helpful here... Please let me know if I sho=
uld
> >     just leave the translations alone instead.
> >
>
> Will update "po/git.pot" after the release of git 2.29.0-rc0. And
> other l10n team leaders will fix the issue you found accordingly.

Okay, so I'll just close the GitGitGadget PR.

> Thank you for the update.

No problem.

Thank you for coordinating the translations,
Dscho

--8323328-2008032156-1601839087=:50--
