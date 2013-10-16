From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Wed, 16 Oct 2013 09:09:00 +0200
Message-ID: <20131016070900.GC24964@shrek.podlesie.net>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
 <525d4354a5436_5844e73e843d@nysa.notmuch>
 <20131015145139.GA3977@shrek.podlesie.net>
 <CAEBDL5V8wfbQTZ5do-UMRpSsxRN8bFaHVnG7kRNfP0t+oYbfNg@mail.gmail.com>
 <525e0e1b28c87_81a151de743f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 09:09:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWLEF-0004Pp-8Y
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 09:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab3JPHJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 03:09:06 -0400
Received: from shrek-wifi.podlesie.net ([93.179.225.50]:57078 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab3JPHJF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 03:09:05 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id A2C6078; Wed, 16 Oct 2013 09:09:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <525e0e1b28c87_81a151de743f@nysa.notmuch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236236>

On Tue, Oct 15, 2013 at 10:55:07PM -0500, Felipe Contreras wrote:
> John Szakmeister wrote:
> > 
> > I like the idea that we could kick git into a mode that applies the
> > behaviors we're talking about having in 2.0, but I'm concerned about
> > one aspect of it.  Not having these behaviors until 2.0 hits means
> > we're free to renege on our decisions in favor of something better, or
> > to pull out a bad idea.  But once we insert this knob, I don't know
> > that we have the same ability.  Once people realize it's there and
> > start using it, it gets harder to back out.  I guess we could maintain
> > the stance that "the features are not concrete yet," or something like
> > that, but I think people would still get upset if something changes
> > out from under them.
> 
> We cannot change the behavior of push.default = simple already, so at least
> that option is not in question.

If we add core.addremove=true the same applies to it - we cannot remove
it later, the only we can do is to disable it by default in future
versions after testing (core.addremove=true or core.mode=next).

> > So, at the end of the day, I'm just not sure it's worthwhile to have.
> 
> This is exactly what happened on 1.6; nobody really tested the 'git foo'
> behavior, so we just switched from one version to the next. If you are not
> familiar with the outcome; it wasn't good.

BTW, I'm still using pre-1.6 git-foo, I have /usr/libexec/git-core
in my PATH. So I would like to always have an option to disable some
new incompatible "improvements".

> 
> So I say we shouldn't just provide warnings, but also have an option to allow
> users (probably a minority) to start testing this.
> 

and an option to keep the old behavior, like we did with push.default.

Krzysiek
