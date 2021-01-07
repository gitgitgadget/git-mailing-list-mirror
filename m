Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B65AC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 23:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9AC2368A
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 23:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbhAGXa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 18:30:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:59677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbhAGXaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 18:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610062131;
        bh=yrrYsgGsvB4LRFGUXbMotYvP+jewIy1BReqPjz1MTX4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hGBmaY+O+oKJTaIfe3+v4rzTRXflmS/kp91Wu4F4yYBEsDNmNlrA6KdquBz6l6iP0
         Xk1YM1RjTUsWEEyUVDSXQrpHtzqWGONes0hykFDAGz1yk6TUeXPNfQ6IpsPYR+okB3
         WAOHt8/3J7R2RTXVWWTcIqgx/CYiovWFlpu15B6k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mFY-1jz7b52g1M-013ARN; Fri, 08
 Jan 2021 00:28:51 +0100
Date:   Fri, 8 Jan 2021 00:28:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: Re* [PATCH v2 2/2] CoC: update to version 2.0 + local changes
In-Reply-To: <xmqqft3g463x.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101080028150.2213@tvgsbejvaqbjf.bet>
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>        <20201228171734.30038-3-avarab@gmail.com>        <xmqqmtxxedwd.fsf@gitster.c.googlers.com> <xmqqft3g463x.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1040697933-1610062131=:2213"
X-Provags-ID: V03:K1:D6Rt8hNmRu+lBCeRe2khKSlX8CYfU7j6YXIFbf79w9ehzEgtxsF
 aXhIF/WYc1o6ouWfzQXgAdDw8elGmEJfycfWQY+b1PgATfrMKe0037oGMQ0dQxaGRlplcSZ
 o13hAzmLHW/o+wTbLiS2bfF9EpFslwJYbBMfGaEaV3hp82uyJ0Z65sq2ypVFaeZW8vYR9/U
 PqbKCkVQMBrytrT9BX88A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9JUfMGYUVso=:u+6pdB5Qr7yQhjcnfiQgok
 2pwoCRZvbTefeFyQU9g8hH2RHJYnMZeTC9LfrIvWU4YWEJ6cRH40kN5i4S+tDhW8OB9q7uCHw
 j5q+AH8nsBSqj+rd0dXK2x/QkdHyvDGImffp6nLMoLg6R0eYlj6laVYrQBl1BgMGtnI6pO7Iu
 CNfVF1cX6Acehw1ueZCFWKqai1X6AVdMseZ0qKsnjGUqC4TdSRJ8WL2mcYY/rfQUFCpsrTQDe
 R/ywE/JyEbZmx402rgVNqlIyHLe7La0eJ1JojJ8zb+cDnCd+/ak1gqosK2hoYgiZD104RD1kw
 nzVhlKcMH+8Oov2YbASLRNn1slDS/F1d0OLEPbphMyZEEqz+gW7DE0U2RZ+iChpqMWVvmSX7G
 H8Bo+YmV3NSMzQsis4x+Nni/Bs3rR/CmcLDXzm7IpAlN6ENCjJHR92FjU28VCmSuwFS0lphvd
 HzcxH1Bhe+wZ0OcrbwpNrG7eJjB5fGUtMi2LaMnH7xQb8N+W4mPWl1fmIfvzlOL8B0NElvmi+
 Ed684mV1THMtA95M/I0uDutATF0VMF7meWKzs2Xcdr2y1KoVW4r9uuWsvzdrySbl0R7pghuah
 zKc0ns+WasT1BI7e1nAq+KgIAaoRRH+pmhPKt363sQvXsmwUikdiSKFMaaORdsw2X4TKou38N
 ePG9CfHtMb/EREa8AQuyrs7VGWA2cduVTwsWQhrBAiT4myGhKUVzw/zicj7d3xRBvgU0V3qFF
 T1AFateXSrRyZLzpMGIkQgvuzzgDS+ar+CiE9+Hrr2xREQuFCuRtq5/UIvuC7TeokI7QT/6cz
 ditpVJPfFX6w/UOqr5fE1EMHR7+8MxJvhL6fSklwjbH2fnNi8A7GZMYM/f69iPIXbrHDk7PdF
 ZlhTlYL9xieloyE0lfsGqWF3/lvKISOgewH5D+EvM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1040697933-1610062131=:2213
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 4 Jan 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> >
> >> This change intentionally preserves a warning emitted on "git diff
> >> --check". It's better to make it easily diff-able with upstream than
> >> to fix whitespace changes in our version while we're at it.
> >
> > I think there are only two lines that needs to tolerate trailing
> > whitespaces, and even if we strip them, it should be still easily
> > diff-able with the upstream with --ignore-space-at-eol or whatever
> > appropriate option, so I am not sure if it is worth try "keeping"
> > these whitespace breakage.
>
> In the meantime, I'll insert this as step [1.5/2] while queuing.
>
> In any case, your [2/2] lacks your sign-off, which we eventually
> need to have before applying these patches.  In the meantime, we
> also need to collect Acks on the move to 2.0 from folks.

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks,
Dscho

--8323328-1040697933-1610062131=:2213--
