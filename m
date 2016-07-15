Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB9B203BD
	for <e@80x24.org>; Fri, 15 Jul 2016 01:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbcGOB7h (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 21:59:37 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:37462 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbcGOB7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 21:59:36 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bNsPE-0005Gj-6l; Fri, 15 Jul 2016 10:59:08 +0900
Date:	Fri, 15 Jul 2016 10:59:08 +0900
From:	Mike Hommey <mh@glandium.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: 32-bit Travis, was Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160715015908.GA15796@glandium.org>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
 <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <xmqqmvllz2t7.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607140952160.6426@virtualbox>
 <20160714091240.GB26046@glandium.org>
 <alpine.DEB.2.20.1607141256100.6426@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607141256100.6426@virtualbox>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 12:58:47PM +0200, Johannes Schindelin wrote:
> Hi Mike,
> 
> On Thu, 14 Jul 2016, Mike Hommey wrote:
> 
> > On Thu, Jul 14, 2016 at 09:58:45AM +0200, Johannes Schindelin wrote:
> > > Hi Junio,
> > > 
> > > On Wed, 13 Jul 2016, Junio C Hamano wrote:
> > > 
> > > > Does Travis CI testing have an option to run our tests on some
> > > > 32-bit platforms?
> > > 
> > > AFAIR Docker does not support 32-bit, and IIRC that's what Travis uses.
> > > 
> > > However, it is possible to install a 32-bit toolchain and use that to
> > > compile Git.
> > 
> > You just need to install gcc-multilib on travis, and you can use -m32. I
> > did that for jemalloc recently.
> > See https://github.com/jemalloc/jemalloc/blob/dev/.travis.yml
> 
> Would we not also need
> 
> 	apt:
> 		packages:
> 			lib32z1
> 
> (or ia32libs in case of an older Ubuntu)?

And probably some libcurl-something-dev:i386 package too. 

Mike
