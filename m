Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3AA01F4F8
	for <e@80x24.org>; Fri,  7 Oct 2016 11:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbcJGLVA (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 07:21:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:50683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbcJGLU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 07:20:58 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MCcE2-1bj9oZ1lpK-009Sc6; Fri, 07 Oct 2016 13:20:41
 +0200
Date:   Fri, 7 Oct 2016 13:20:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
In-Reply-To: <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610071319520.35196@virtualbox>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-99205195-1475839241=:35196"
X-Provags-ID: V03:K0:w1W1s9y2WSTjNiIbvmjihc5w8Ccpfa38aL/koccU2V0cli4jBTf
 h0ALt4eqrggAAfeL99oqRSxwqLbnrz7GndgSDTPEcfrajx2F2a3xbiKIrEvVmWIzqfjEJMJ
 1a6DLjwtJR1ImjzTnTmvz525XUwy88ogo03zXo7eMewBCouHn1ChUKkzlK6s0A3gOZ78BoA
 +1B1UXF8XaVkFuRFHTuXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0Yx0iINJxE0=:aDrSwQMAS7WIYlAP3F/FcU
 v2aSvAHuiigFQVsiV+FWMjSfE+DmhuOGrUS0jGE9uFrIqMZ5fMVHw591hc/rh8NaB0OoS4Fk2
 Dgl+Zipanf9UgLwL7IQ+A8HK2moynrIEvfH8ur5jS+Tg3zEWlPpY3j7MxMTYsfCB7U7v/0NlW
 YoBNFj+IPl4CqTjEHagykeuinkTZwvJ8OUpBDtFT0K8DJmLo9fm8k4a12n3sn8BxRHDfQcaqg
 f/9M2CMqkT7A+cetgXPAWt7jIKECzSZCGlyJjvVzQe4Aq9OGHo8NyGcULU4dFfU0YYrcFOKq7
 +53Wcic1jhnN/mi/vjtRtvX3PQ2Pk9HDgI9E0LOlZYqnJjOYLPjAMT6CUWu4nzLXev+NF5D5x
 b7o6BFTp2YQFqAUH9DPxZMu9pkz6ZqK6Kqnx0suVBGaH+HiAzZmi7FAavnWz4Op3pybRCb4nw
 XO9ukIS+zN2CLT+AKl7KKjEFmGxZrNBC0rRMLfv7lizz1CzGjqLxfvSR6tRN5fqmmsqlZ34/n
 LFlRgTpdYkTeareWQKkyjBnJwAJKLDRwaFpqT4R7MHz0T0+OR6SF5dEwikCX860hTsqVFP5N0
 Ya3K/MZ8RSf7EHpbviReLZSrT4uooSbnaT9aSvlr06j1kCG0RFZA1TvpGrpFPP4wtIX/va5GG
 fctT+M/lx206PVbmedohl2BYMAdyoXhbH/ZkzCm/4pBxT7VB7GrGlnO/NB3b/7FavhaEyKq2U
 TGn5Ptd90XYZQZpS15d2tQfuVbEy/h6htLaqRjMcWS/bANwYZYpaiSmjMqZkuIDGTgIrTxlqM
 2DRpyNm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-99205195-1475839241=:35196
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Thu, 6 Oct 2016, Junio C Hamano wrote:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>=20
> > Throwing something at the mailing list to see if anybody is
> > interested.
> >
> > Current '!' aliases move cwd to $GIT_WORK_TREE first, which could make
> > handling path arguments hard because they are relative to the original
> > cwd. We set GIT_PREFIX to work around it, but I still think it's more
> > natural to keep cwd where it is.
> >
> > We have a way to do that now after 441981b (git: simplify environment
> > save/restore logic - 2016-01-26). It's just a matter of choosing the
> > right syntax. I'm going with '!!'. I'm not very happy with it. But I
> > do like this type of alias.
>=20
> I do not know why you are not happy with the syntax, but I
> personally think it brilliant, both the idea and the preliminary
> clean-up that made this possible with a simple patch like this.

I guess he is not happy with it because "!!" is quite unintuitive a
construct. I know that *I* would have been puzzled by it, asking "What the
heck does this do?".

Ciao,
Dscho
--8323329-99205195-1475839241=:35196--
