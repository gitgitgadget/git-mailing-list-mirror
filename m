Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 31677 invoked by uid 107); 8 Nov 2012 18:37:05 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Thu, 08 Nov 2012 13:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609Ab2KHSgM (ORCPT <rfc822;peff@peff.net>);
	Thu, 8 Nov 2012 13:36:12 -0500
Received: from plane.gmane.org ([80.91.229.3]:33339 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754387Ab2KHSgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 13:36:11 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TWWxb-0003nb-S9
	for git@vger.kernel.org; Thu, 08 Nov 2012 19:36:15 +0100
Received: from ip68-6-43-149.sb.sd.cox.net ([68.6.43.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 19:36:15 +0100
Received: from richard_hubbe11 by ip68-6-43-149.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 19:36:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	rh <richard_hubbe11@lavabit.com>
Subject: Re: [PATCH] gitweb.perl: fix %highlight_ext mappings
Date:	Thu, 8 Nov 2012 10:36:20 -0800
Message-ID: <20121108103620.eb716adb2d7542c606c8b87a@lavabit.com>
References: <20121104094555.a46992b6d836c1e09524d2cc@lavabit.com>
	<20121108180157.GK15560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-6-43-149.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Original-Received: from slem by 1.1 with local
X-No-Archive: yes
Archive: no
X-Archive: expiry=11
X-Archive: encrypt
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, 8 Nov 2012 13:01:57 -0500
Jeff King <peff@peff.net> wrote:

> On Sun, Nov 04, 2012 at 09:45:55AM -0800, rh wrote:
> 
> > The previous change created a dictionary of one-to-one elements when
> > the intent was to map mutliple related types to one main type.
> > e.g. bash, ksh, zsh, sh all map to sh since they share similar
> > syntax This makes the mapping as the original change intended.
> > 
> > Signed-off-by: Richard Hubbell <richard_hubbe11@lavabit.com>
> 
> Thanks.
> 
> > diff --git a/gitweb.cgi.orig b/gitweb.cgi
> > index 060db27..155b238 100755
> > --- a/gitweb.cgi.orig
> > +++ b/gitweb.cgi
> 
> This is not the name of the source file in git.git, so "git am"
> choked. I was able to fix it up locally, though. No need to resend.

Somehow I knew that it wouldn't be a slam dunk!
Thanks for doing what you do.  FWIW maybe others can follow
this thread to know what not to do.  And save you extra work.

> 
> -Peff

--
"Now, in his heart, Ahab had some glimpse of this, namely; all my means
are sane, my motive and my object mad."

