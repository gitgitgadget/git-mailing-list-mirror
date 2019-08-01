Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF91A1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 21:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfHAVlH (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 17:41:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:52151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfHAVlG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 17:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564695658;
        bh=UA9oBUF+CAgoC67F+qmZp9CvCRXkeh8ic8TBPA0ZsEE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N7TSWZ0PpkKNyhrvNgyqEoXy0E93IgrTG+WuTuh5acMm6iGlsymtB7VvmS5l50IVQ
         81u5QDi0SzMiVheEnibeW0N/fJ2QP0pgAkjE9wb9OXgmRR6lSbbp6Uf75gb6g4XMj9
         2wln8MekbLP6eNoRNYPVl/8cw/644WNm+P56TXak=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUHoI-1hjv8C0Jjm-00Qy35; Thu, 01
 Aug 2019 23:40:58 +0200
Date:   Thu, 1 Aug 2019 23:40:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bryan Turner <bturner@atlassian.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git@vger.kernel.org>, git-packagers@googlegroups.com
Subject: Re: [git-for-windows] Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE]
 Git v2.23.0-rc0
In-Reply-To: <CAGyf7-FnqiTDjSRcxhaJZtfws9XqJ4a9-OGwVY+juibVuwBMBQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908012340300.21907@tvgsbejvaqbjf.bet>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet> <CAGyf7-FnqiTDjSRcxhaJZtfws9XqJ4a9-OGwVY+juibVuwBMBQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wYOt4i4sAXBQ+1CR7zhar3kYNaFLeJjUCNVF0tu4XXTYI5n5EIu
 XTHWzXM5a4gd0lxZ+mY9ChZdXbRJpWPLa0bAWwHeDAxyzpMUENr4rkfKjkAPcHNt/oSJK15
 Kcnrz/B+e6Pt/dBvKDEwI9IXkfxh3F4CBHS3USc/x72oa7uyR0Q+HIdG1Zee+SVasDF60sw
 7iYd2P0vkcvao7W5JfnpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pDe4DTgTvos=:Np/Hoibtof5AGlhogw1L1E
 f9lAtkQcJWzlfViAGUliyG07euRpsK4ou9v/YnjB4BJGHoeo+bFtz3J91kSMfTu5V3Fir19v0
 TBZSTOyxmNYYmnUIi3hi22VY+6coivw6s3CnELBfjtiM7VnoNGOlhPz0c/DNvXn1a4xemEmT5
 uXgdwtTLf/iAqae4yuxpajJiJhc4TDPT/h1PO+EAQrzziPTjZxijtORVBBqz0AP0cXvjtcMpi
 qhQEI7rVys8GMdgHeh311dlH+J2UnfmAROEBBNvkOvrQuEGNUQl6mBkNN5d/DktB8sFYe5qcg
 RH39QGx44ldD2FwDes3XckGyQY06Z0X/7tlO2OhB7lqmwJ21llDTVlrV9/CWUmQX59SLC9ljA
 X6vC65mrY7mjWWXxWJdixmjyQ9fTDjeLpOTBgf2G69QUiFCa4FBg1YFodP8JTHhHSBl/xc/1w
 UCSAhuwi+6sVpd+wX7oId2sIUre1DaRHYoBGNzFK1LL2rglvIABV4b6nBxyuJ+EPIS3l2Dnq0
 NWoyWXauKG+APfg7gx08xOCx54tOL/9Depc4xm45SCAX15h3Grkq+5ZhtHTVA1xk0UzwrAWM6
 3vT3SpihfcKLbWZAodr/AB0NDghVOd7uHoBt6nw+AMOw/9ECri+KkZeeBOzi0pOBQj86PfpDL
 WcwTMsVPZwe8PSlrNUdup+27DPBNt68UqSLO7aClsOsn4Qe0wWgHki3oVCAqiKOgjRKrnlmi0
 PPPKIuh9Cyjw0eNp/wAT3friaY5sJYD0EEmph46eMzMG0AYBIQKhjzsX875/xHFqffyta7UpI
 BorJhPCaavMrFTxFphkAqg58oVtzk1+zgurBYzmpcnrJ66EdditXOfpIMjnKiFtlee2MGMFwt
 azp1QwCrhFP6F0NV9Bfllv4qlPNUJiv3Z3B+AlG/QjzZALcCbu4u+9/pizTJ4ssjQDWD660vy
 sK8eaveyjYCIQ5tG4KNWFHBZHKvBCdDAvH+b+FFa+AWCKutFB4jYeOIUsYacujbfX0cgfZa4I
 sfGu6JREqHa/cA7o9Pg9sE5j4fx7ipfjdw3fHu4ydfRYn01jL3gVGZIQ2WE0ZWM4vNMpMm147
 UBtnzhOR0jSsk6Ukx5xi2FIdGlbsvrw5Ct/chwuGfnOb1J6huj3anbvJhk0tGP4omEE++I0Yv
 hOz74=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

On Wed, 31 Jul 2019, Bryan Turner wrote:

> On Wed, Jul 31, 2019 at 5:43 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi,
> >
> > On Mon, 29 Jul 2019, Junio C Hamano wrote:
> >
> > > An early preview release Git v2.23.0-rc0 is now available for
> > > testing at the usual places.  It is comprised of 420 non-merge
> > > commits since v2.22.0, contributed by 62 people, 23 of which are
> > > new faces.
> > >
> > > The tarballs are found at:
> > >
> > >     https://www.kernel.org/pub/software/scm/git/testing/
> >
> > And a corresponding Git for Windows v2.23.0-rc0 can be found here:
> >
> > https://github.com/git-for-windows/git/releases/tag/v2.23.0-rc0.window=
s.1
> >
> > Please test!
>
>
> I've run the full test suite for Bitbucket Server against 2.23.0-rc0
> on Linux, macOS and Windows. No test failures to report.
>
> Thanks again for these early release candidates! They're a great
> opportunity to test new releases in advance.

Thank you _so_ much for diligently testing all of them ;-)

Ciao,
Dscho
