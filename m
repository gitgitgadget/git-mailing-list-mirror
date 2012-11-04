Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 25634 invoked by uid 107); 4 Nov 2012 17:40:51 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Sun, 04 Nov 2012 12:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab2KDRj7 (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Nov 2012 12:39:59 -0500
Received: from plane.gmane.org ([80.91.229.3]:34140 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab2KDRj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 12:39:58 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TV4B2-00008X-AI
	for git@vger.kernel.org; Sun, 04 Nov 2012 18:40:04 +0100
Received: from ip68-6-43-149.sb.sd.cox.net ([68.6.43.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 18:40:04 +0100
Received: from richard_hubbe11 by ip68-6-43-149.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 18:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	rh <richard_hubbe11@lavabit.com>
Subject: Re: [PATCH] gitweb.perl: fix %highlight_ext mappings
Date:	Sun, 4 Nov 2012 09:44:22 -0800
Message-ID: <20121104094422.7273cd146654f06ccb1b2baa@lavabit.com>
References: <20121102141226.643a96e61b8bf383428c5287@lavabit.com>
	<20121104134841.GC31623@sigill.intra.peff.net>
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
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, 4 Nov 2012 08:48:41 -0500
Jeff King <peff@peff.net> wrote:

> On Fri, Nov 02, 2012 at 02:12:26PM -0700, rh wrote:
> 
> > The previous change created a dictionary of one-to-one elements when
> > the intent was to map mutliple related types to one main type.
> > e.g. bash, ksh, zsh, sh all map to sh since they share similar
> > syntax This makes the mapping as the original change intended.
> > 
> > Signed-off-by: rh <richard_hubbe11@lavabit.com>
> > 
> > diff --git a/gitweb.cgi.orig b/gitweb.cgi
> > index 060db27..155b238 100755
> > --- a/gitweb.cgi.orig
> > +++ b/gitweb.cgi
> 
> Close on the format. There should be a "---" after the sign-off but
> before the diff. I can fix it up locally (and the patch looks good to
> me).
> 
> However, one final thing: the point of the sign-off is to indicate
> that you are legally OK to release the code under the DCO. For that
> reason, we usually require a real name (not rh). I can guess at your
> real name from your email, but I'd rather be sure. Can you provide it?

Roger wilco. Resubmitting. 
Thanks for the time and consideration.
> 
> -Peff


-- 


