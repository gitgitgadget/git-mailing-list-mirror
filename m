From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sun, 05 Feb 2012 09:33:02 -0500
Message-ID: <1328452328-sup-6643@pinkfloyd.chass.utoronto.ca>
References: <201202042045.54114.jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 15:33:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru39d-0005No-FV
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 15:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab2BEOdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 09:33:04 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:50592 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab2BEOdD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 09:33:03 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:51169 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Ru39K-0004TQ-8Y; Sun, 05 Feb 2012 09:33:02 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Ru39K-0006KQ-7d; Sun, 05 Feb 2012 09:33:02 -0500
In-reply-to: <201202042045.54114.jnareb@gmail.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189940>

Excerpts from Jakub Narebski's message of Sat Feb 04 14:45:53 -0500 2012:

Hi Jakub,

These items are as much about UI as anything else, I think.  UI that
better helps users to know the state of their commits and branches can
only be a good thing.  People that have used git for a while and are
comfortable with it may not see the need/point of these, but I think
they could both really help new users.

> In Mercurial 2.1 there are three available phases: 'public' for
> published commits, 'draft' for local un-published commits and
> 'secret' for local un-published commits which are not meant to be
> published.

How do you envision such a feature in git?

A 'draft' commit (or chain of commits) could be determined from the
push matching definitions and then marked with simple decorations in
log output...This would extend the ability of status to note that your
are X commits ahead of foo.  This would see any commit on a branch
that would be pushed automatically decorated with a 'draft' status.

> While default "push matching" behavior makes it possible to have
> "secret" commits, being able to explicitly mark commits as not for
> publishing might be a good idea also for Git.

Do you see using configuration or convention to achieve this?

For example, any branch named private/foo could, by convention, be
un-pushable without a force option?  Alternately, a config item
similar to the push matching stuff to allow the users to designate
un-pushable branches could work too.

Please don't take the above implementation possibilities as anything
more than a starting point for discussion as they may be deeply
flawed.  I'm just tossing a few things out there as I think this is a
good discussion to have.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
