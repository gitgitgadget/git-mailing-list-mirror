From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Wed, 16 Oct 2013 08:34:36 +0200
Message-ID: <20131016063436.GB24964@shrek.podlesie.net>
References: <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
 <525d4354a5436_5844e73e843d@nysa.notmuch>
 <20131015145139.GA3977@shrek.podlesie.net>
 <525d8ebd19c67_5feab61e8037@nysa.notmuch>
 <20131015220125.GA14021@shrek.podlesie.net>
 <525e100e45ee8_81a151de74ed@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 08:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWKgv-0003V3-2y
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 08:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab3JPGel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 02:34:41 -0400
Received: from shrek-wifi.podlesie.net ([93.179.225.50]:56035 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab3JPGek (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 02:34:40 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id CA68878; Wed, 16 Oct 2013 08:34:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <525e100e45ee8_81a151de74ed@nysa.notmuch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236233>

On Tue, Oct 15, 2013 at 11:03:26PM -0500, Felipe Contreras wrote:
> > not some "next" behavior that may change in future.
> 
> But I'm suggesting to add a core.addremove option as well, like you suggested,
> am I not?

Yes, I think we both agreed on adding core.addremove. I'm just not
convinced if we should also add core.mode.

> 
> So you would be happy if we had core.addremove = true *and* core.mode = next,
> right? You would use one, different people with different needs would use the
> other.

Yes, if there are people that will use core.mode it will be worth
adding. I'm just not one of them.

> 
> > > > That's safer than next (at least for interactive use) and maybe more users
> > > > would use that, but I don't think that's worth adding.
> > > 
> > > Maybe, but I don't think many users would use either mode, and that's good.
> > > 
> > > > For me, old behavior by default and warnings with information how to
> > > > enable new incompatible features, is sufficient. So I don't need
> > > > core.mode option, but as long it will be useful for other users I have
> > > > nothing against it.
> > > 
> > > OK, but that seems to mean you don't need core.mode = next-warn either. I'm not
> > > against adding such a mode, but I would like to hear about _somebody_ that
> > > would like to actually use it. I don't like to program for ghosts.
> > >
> > 
> > As I said earlier, I don't think that next-warn it's worth adding, but
> > such option might increase the number of people interested in the
> > core.mode.
> 
> Well that's a hypothesis, and I would be interested in finding out if that's
> true, but until I see somebody that says "I want core.mode = next-war", I'm
> going to assume they are hypothetical.
> 

Yes, that's just a hypothesis.

Krzysiek
