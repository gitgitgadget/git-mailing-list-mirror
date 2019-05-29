Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FDFE1F462
	for <e@80x24.org>; Wed, 29 May 2019 09:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfE2JjE (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 05:39:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:36063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2JjE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 05:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559122742;
        bh=zDhkV43tlaRKu/MpapJA3fYx3X1zlPHbP2ItLvG28os=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WYGa624oLwd5LGN2uyre4rfOpaknlC2p+OgJuSXsm1P34ZUk/ysOu08k2pC85E6Ah
         anywMthV/yvcBmyhknGCX9HnvcvA+iu03KN83LRqMXZhyObvFhww1Itw9YXIarlT8s
         dF3MwX2HV6kbrz4hJUYocwF+7FRNxpEXjArINsBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLA45-1hWC1v0CaP-000P1a; Wed, 29
 May 2019 11:39:02 +0200
Date:   Wed, 29 May 2019 11:38:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [GSoC] Some #leftoverbits for anyone looking for little
 projects
In-Reply-To: <87in9ucsbb.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905291137070.44@tvgsbejvaqbjf.bet>
References: <87in9ucsbb.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1348207627-1559122742=:44"
X-Provags-ID: V03:K1:s3ZHl+VgxO2h3txvgEDn7Bfq0wDJAfUTUuKRhVsig2j2CMg5BHL
 bRPF955V1Kypa64gN3nQLlQm2zE6TdHtlp+2Qye7UgMKTrXvPqQdsw0dY8skCAUW4PKA+8D
 L/bq5/cxk/MAYn1ZmMSL/uTH0EkKTjb0KM8SI8M+Cw621OMIdBmxU2G1JUVa05Rip9qjxkb
 AuE+mBqzK0BjNbFU3p+DA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rfUpn67xooE=:xBsw8hQqsh8ORy7Ujt7MQE
 8/lyUgxPW8oIOpXYl65K1HqW2Zf6F6vs4tlOvtSYJa5RpfB9StNzGvT6KQ9FNoW2ft2T5zBWB
 VkSb7dIUlxUMx2DjFxj2bJhb/X6dg0ndadhygND17VgiM5tAl2Sr78XEqSgQ566Utf0QVg8ja
 5TteUK93FfVlZ5jrWqdCDGhCWn9bz+NdwQvaAhG7Yx5zZ5fDXUPxoRXTkSgjQ0qo4jwqYGmWa
 M/Jnlbcuebcv2jjpkSYfNynu3uFVOov+xazFKe46LbuqgLEWIOGJvGN9zJj4dPjATUyw1tsGm
 Ot48W1FG0CO2f3ymV7HAr6Hv6a7gUIbyAHLIE878H+zplQYqWpPEPIIO5pc4oLv3j3psDUhPR
 RhPdmHHep0wwVc/maxlMLiyKiAyGcigxhtygH+36DxPopt0lEjL0mBJGl736IwBRTpIBYHdKw
 Gs57f2tAAHZW/nUeVN8N9RtiBvvAK5T/Kxu+JB4GvnOl5eUdF0UTE1vsyj/R23v7kunST2JHg
 35stm65bSBW7q3GmS3iLMwKAMTgjTiWCs6uzt5+dV8dociWoFXx+rn74swrIVTJQ5MckDN/6N
 tYdzgNDZQhfDWcBr6o2GAPELtWlreKcO/YbMtQiVbsBY41jMKFXGDgGxNHULpoQp22FmMciNB
 kSHztmcrgrnWZ+i/FToLGINKiF1wZEvGo/9c/6M17q6hXkKGUDP0Yrl5nJ4g+Zrvp9FuEeTy2
 UtR9q+z/ILGLpoQn1WX11UsQmmUxUiiA9yIwQLeMbyZlxSKPJ073qohowkD/+97MySRoQPexL
 cXWoAf48lPuwNiVvUCSCzxi2r9yItupOb9lCx62+cFoLXSln1KdoFevagX2eG3b3qe2H5MF3m
 U/e3tseYQnw9iEnq0+xEeIEbUUVD5RioC63iaGn29ObTmo8Acraj6t5qGUOrPVBTqdG5TvKwd
 EbHMrqbnTcpr9rzAcc7KjqOF7BJ4q7LMrAaBYrdJcFNRJ2vscKYtL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1348207627-1559122742=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Sat, 17 Mar 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> In lieu of sending a PR to https://git.github.io/SoC-2018-Microprojects/
> I thought I'd list a few more suggestions, and hopefully others will
> chime in.

I am in the same camp, and figured that GitGitGadget (which *already*
augments the Git mailing list-centric workflow via GitHub's convenient UI)
would make for a fine location for these small left-over bits. So I added
them to https://github.com/gitgitgadget/git/issues/234 (except the
"git-unpack-*" idea, as I think that should be done as a test helper
instead, and it should be done in the context of a new test case that
actually needs this).

Ciao,
Dscho

--8323328-1348207627-1559122742=:44--
