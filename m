From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Tue, 15 Oct 2013 16:51:40 +0200
Message-ID: <20131015145139.GA3977@shrek.podlesie.net>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
 <525d4354a5436_5844e73e843d@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 17:00:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW67B-0000d5-3q
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 17:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933255Ab3JOPAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 11:00:44 -0400
Received: from shrek-wifi.podlesie.net ([93.179.225.50]:55790 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283Ab3JOPAk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 11:00:40 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 17AB066; Tue, 15 Oct 2013 16:51:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <525d4354a5436_5844e73e843d@nysa.notmuch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236187>

On Tue, Oct 15, 2013 at 08:29:56AM -0500, Felipe Contreras wrote:
> Krzysztof Mazur wrote:
> > On Tue, Oct 15, 2013 at 07:32:39AM -0500, Felipe Contreras wrote:
> > > Krzysztof Mazur wrote:
> > > > 
> > > > But with core.mode = next after upgrade you may experience incompatible
> > > > change without any warning.
> > > 
> > > Yes, and that is actually what the user wants. I mean, why would the user set
> > > core.mode=next, if the user doesn't want to experencie incompatible changes? A
> > > user that sets this mode is expecting incompatible changes, and will be willing
> > > to test them, and report back if there's any problem with them.
> > 
> > With your patch, because it's the only way to have 'git add' v2.0.
> 
> Yeah, but that's not what I'm suggesting. I suggested to have *both* a
> fined-tunned way to have this behavior, say core.addremove = true, and a way to
> enable *all* v2.0 behaviors (core.mode = next).

I'm just not sure if a lot of users would use core.mode=next, because
of possible different behavior without any warning. Maybe we should also
add core.mode=next-warn that changes defaults like next but keeps warnings
enabled until the user accepts that change by setting appropriate
config option? That's safer than next (at least for interactive use) and
maybe more users would use that, but I don't think that's worth adding.

For me, old behavior by default and warnings with information how to
enable new incompatible features, is sufficient. So I don't need
core.mode option, but as long it will be useful for other users I have
nothing against it.

Krzysiek
