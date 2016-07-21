Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B122203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 15:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbcGUPSN (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 11:18:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:58184 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998AbcGUPSL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 11:18:11 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MexlN-1bfsoM0mN7-00OaMd; Thu, 21 Jul 2016 17:18:03
 +0200
Date:	Thu, 21 Jul 2016 17:17:18 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Eric Wong <e@80x24.org>
cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] config.mak.uname: set PERL_PATH for FreeBSD 5.0+
In-Reply-To: <20160720180702.GA13404@starla>
Message-ID: <alpine.DEB.2.20.1607211716100.14111@virtualbox>
References: <20160720025630.GA71874@plume> <alpine.DEB.2.20.1607201322350.14111@virtualbox> <20160720180702.GA13404@starla>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:no0dyi1R2hjv7ApcGp9FL2lj0pO1AZdMYDqMvRSKZwconfCIwKI
 CqihIQbK7ErEqKmhD30RJxWsM/q9gla18Xpe/IEg0tKTVRVIFXStxscQCfzJ4fLPHZlxyV9
 FQX0g+/JRGCgq2WtSG18ARcCRu/Wyk8zYjAJh5NL4Fz0QISI69K7P9K2d6IWObi1iu24tpx
 nITW5rUj3SABQvwRnLiaw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ZDY3zCiP88c=:CsvE/K9MkSpP1+oXUc1Mos
 EgoXNeg4LgTZWQJ2eh1IBv0ba6tvVgj3ypsHgZhdZ7SNfOJVauDxcrX2wWuVmSSWNT/nduFQS
 nAQMVPxKQKKC9bqjfUsoSEKhohNcZZllm0pahvpmtSDxDLWYVLko6wJPtQdmMa28NbfkaSjy4
 c6EonCTk2EGY/rbNPcfPzO6QVTHCbnJUHdV+9EQjSVjEEB5bZBIJItQjw5TGr/7deRONDMQ6P
 Xayp5YCoXpInucsLKFDR/DNJQcEA4dya77fCfhO0f1zJRor8UbS6TcEVCHL8Ne3XPJ0jPzE0A
 D0mRE78DLjfCPZSSXJWJMcYhy+rE0rezYWwgj5oVIn4d59yKrgRm3StLC2a/XWw87iLwEfhP8
 E+TrlCg0MT17vl9v6Dd8a08EmDtUBweuL4i8544e5dHh0Yv0oKDa2YWagyCM+9h4BVpZJm4FT
 OU0hMhq20MspKygNJZVG9GAgF5OlntY4X2UKtt21vfpHgnJ2jNJ8bIsF9wNRLpud1oz3n329L
 dUNmAyqibnAI8G974Iuz4vOpJyX4PCnhUshsHWfpYTcQOj6wba1GLkRfvig1gyu5ClUQn5OtX
 phHc0X6S8v+4gpOkC/Jhsvk/osYaTfRCek71GfM4ctBoNUrgcOscZAsZ11OHgBG0zFf9S2gPG
 TLC6J8AA/YAMlikcJ8Zxo83vryX2sVp8L+IsvSZ8qEkK8tqdnZJjFNMi0xEyxks5qTq7ueuH9
 PdfDgwppwnjXZ1ecpdOfQbpUWeD32I6Q9ExWNccxinCz6EWUXPakUQ1Y/t2vZlGiCZTuqY3Mk
 pKeUoUP
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

On Wed, 20 Jul 2016, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > On Wed, 20 Jul 2016, Eric Wong wrote:
> > 
> > > diff --git a/config.mak.uname b/config.mak.uname
> > > index a88f139..6c29545 100644
> > > --- a/config.mak.uname
> > > +++ b/config.mak.uname
> > > @@ -202,6 +202,11 @@ ifeq ($(uname_S),FreeBSD)
> > >  		NO_UINTMAX_T = YesPlease
> > >  		NO_STRTOUMAX = YesPlease
> > >  	endif
> > > +	R_MAJOR := $(shell expr "$(uname_R)" : '\([0-9]*\)\.')
> > > +
> > > +	ifeq ($(shell test "$(R_MAJOR)" -ge 5 && echo 1),1)
> > > +		PERL_PATH = /usr/local/bin/perl
> > > +	endif
> > 
> > In keeping with other uname_R usage, should this not read
> > 
> > 	# Since FreeBSD 5.0, Perl is part of the core
> > 	ifneq ($(shell expr "$(uname_R)" : '[1-4]\.'),2)
> > 		PERL_PATH = /usr/local/bin/perl
> > 	endif
> > 
> > instead?
> 
> That's fine; however I don't use `expr` often, so it required
> a little more time to realize the '2' means 2 characters were
> matched.

I never use `expr`, so I had to go and see the surrounding code to
determine what the code style is.

> Also, my use of a numeric comparison may be more future-proof
> in case FreeBSD decides to have /usr/bin/perl again.

That is a very theoretical concern ;-)

Ciao,
Dscho
