From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Wed, 16 Oct 2013 00:01:25 +0200
Message-ID: <20131015220125.GA14021@shrek.podlesie.net>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
 <525d4354a5436_5844e73e843d@nysa.notmuch>
 <20131015145139.GA3977@shrek.podlesie.net>
 <525d8ebd19c67_5feab61e8037@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 00:01:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWCgH-0001Vx-1a
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 00:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933769Ab3JOWB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 18:01:29 -0400
Received: from shrek-wifi.podlesie.net ([93.179.225.50]:40389 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932802Ab3JOWB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 18:01:28 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 2AD2278; Wed, 16 Oct 2013 00:01:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <525d8ebd19c67_5feab61e8037@nysa.notmuch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236203>

On Tue, Oct 15, 2013 at 01:51:41PM -0500, Felipe Contreras wrote:
> 
> I don't see what is the problem. We haven't had the need for push.default =
> simplewarning, have we? If you want the warning, you don't change anything, if

simplewarning makes no sense, because push.default=simple sets exact
behavior, not some "next" behavior that may change in future.

For instance, I was very unhappy once, when git pull failed and said
that I should do git pull --merge.

> you want to specify something, you already know what you are doing.
> 
> > Maybe we should also add core.mode=next-warn that changes defaults like next
> > but keeps warnings enabled until the user accepts that change by setting
> > appropriate config option?
> 
> Maybe, but would you actually use that option?

No.

> 
> > That's safer than next (at least for interactive use) and maybe more users
> > would use that, but I don't think that's worth adding.
> 
> Maybe, but I don't think many users would use either mode, and that's good.
> 
> > For me, old behavior by default and warnings with information how to
> > enable new incompatible features, is sufficient. So I don't need
> > core.mode option, but as long it will be useful for other users I have
> > nothing against it.
> 
> OK, but that seems to mean you don't need core.mode = next-warn either. I'm not
> against adding such a mode, but I would like to hear about _somebody_ that
> would like to actually use it. I don't like to program for ghosts.
>

As I said earlier, I don't think that next-warn it's worth adding, but
such option might increase the number of people interested in the
core.mode.

Krzysiek
