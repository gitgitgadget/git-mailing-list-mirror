Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4127C1F744
	for <e@80x24.org>; Wed, 13 Jul 2016 07:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbcGMH4r (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 03:56:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:56359 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbcGMH4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 03:56:43 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lpbqo-1arjlk44Aw-00fO6d; Wed, 13 Jul 2016 09:56:27
 +0200
Date:	Wed, 13 Jul 2016 09:56:26 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2016, #04; Mon, 11)
In-Reply-To: <CAPc5daVVU0+Ext0tk83kOLwZxPGPUFZQ9_5y7yyX4JD0O3Napw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607130954410.6426@virtualbox>
References: <xmqq37ng7x05.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607121515300.6426@virtualbox> <CAPc5daVVU0+Ext0tk83kOLwZxPGPUFZQ9_5y7yyX4JD0O3Napw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tJU1N1GShx+NzTx5dXcecWsSUF/FGmYYJwSypuD1nohau+fu5vl
 50nXl2uTZ7YxWQ+7Bm72GYx1ixY5EoAZnm+ssU5otO8m7Ad9bTDv6YFZWAq96WDK1N9MqLK
 7oT/H7KO+ToOnN7QFUPFN/PNTT8F884WCTzHoM5evvf45GvYizoqfJu/CPUvDzyOGAuUEKZ
 HNgChWNb5rIYq8z6nkdSQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:VbryhL/H09o=:rwPMCytku1hU4wVRV5D86X
 s9iudqup/Xbw0rOOWwrxu5K367cXcNr1T+SnsFDkEaZtTgBExqMRabuJy4jrY0O2K+fzPOS7O
 a+I7w4TGa/l6BS2m/qRq2cDiKrgu3HdTPvqR0ASqRxaAmCUB2eCIIp64ijm/2CdFQewmx/BDO
 NMOp977h2jWcL6sYTo+0C1aORZMC2qa/Ro7LJ8bMFt4JbTKSoFBBIYN1ESGE3E5NTy4cBJmuR
 12HJm68vk9B1fA0eSxrtjBzkW84TMw3JEpFx7OJ8j8Toa+DwcdxDvjOurHLFNNylonBUi9Srn
 J3a0hoHX0ZYZxyH77qcnpv3wdVDt/lm6YxwpfH+JaCt5uzQZ6O4Lq9+ExRFzxHbxPQv2RRvBK
 Lu8+KqILILbHiauTRaGsaC0IEtGkLhZDMFmPclxtCHKBLypFYC/cXlCuTF+gJNqrRjUifAFJh
 ixLWm4KlM0ZZECHc3eWXIoqkfrdOnIlu12VGrkyzai7WmtsVQYXt9UAc5RZfvmcNuz9gXrvSV
 I7yTYN/A+zezWZJzZTEWJlPdpvv8DXpLWDUTjxqYyOjhv8JwYLOqmwgjHtS7nNBL6we3Uv8dz
 /IvZOGJHQhZYqzSt55EqYiYfsSjIK99Xyb7xs4SdKFM3JCVSgy7pf4AddHKDuX35/EJ7SqMm2
 3ebHbGXB02eQXMuiIJCvkwZ2haaMkpM7vrMy2RLRNMX6NOoSeswfeuUwPr1bvXSzs1n62VCnM
 7c21gZYVAfslehQTVL8T/G1nf7LbzDwsImDJaXRkCAdMmNtRFYT5ReuEGxPUFVGqp4CrGoIIs
 Cm9pIpK
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 12 Jul 2016, Junio C Hamano wrote:

> On Tue, Jul 12, 2016 at 6:16 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 11 Jul 2016, Junio C Hamano wrote:
> >
> >> [New Topics]
> >>
> >> [...]
> >
> > What about http://thread.gmane.org/gmane.comp.version-control.git/299050?
> 
> Not forgotten.
> 
> It just is not one of the "New Topics" yet, together with several
> other patches sent to
> the list recently, hence it is not listed there.

Thanks.

I just nudged you because this is a patch I needed to include it in Git
for Windows and would have loved more reviews than just mine.

Not a big deal, especially because it is not forgotten ;-)

Ciao,
Dscho
