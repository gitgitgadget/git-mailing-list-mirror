From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Wed, 9 Jul 2008 15:46:29 +0200
Message-ID: <20080709134629.GA3848@joyeux>
References: <20080701150119.GE5852@joyeux> <20080709101330.GA3525@joyeux> <alpine.DEB.1.00.0807091427270.5277@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 15:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGa15-0006bh-GU
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 15:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbYGINqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 09:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbYGINqd
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 09:46:33 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:41022 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbYGINqc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 09:46:32 -0400
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay04.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KGa07-0006Nf-3z; Wed, 09 Jul 2008 15:46:31 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807091427270.5277@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]965142
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87883>

> >   On the symbols side, I propose:
> >     > submodule commit is a direct descendant of the commit in the
> >       superproject
> >     < submodule commit is a direct ancestor of the commit in the
> >       superproject
> >     + no direct relation between submodule commit and commit in the
> >       superproject
> >     ? the commit in the superproject cannot be found in the submodule
> >       (replaces the initial '!' in my patch)
> 
> I like the output of "git checkout" when your local branch is not agreeing 
> with the tracked branch.  Maybe it would be more user-friendly to have 
> submodule use that type of message, instead of cryptic single letter?
Mmmm ... Yes that could be a great idea. I'll try it.
 
> On a related note, the long commit name has been a constant nuisance for 
> me.  A short commit name is perfectly enough, methinks.
I also think so. The commit ID is completely useless for humans.
Nonetheless, that would change the git-submodules output which
(according to someone-that-I-dont-remember) would be a Bad Thing(tm).

> > - define a git-submodule 'fetch' subcommand which call fetch in each
> >   submodule and runs the verbose mode of git-status (can be disabled by
> >   a --quiet option).
> 
> I like it.
> 
> You probably can refactor the code for "update" to do that nicely.
OK

Sylvain
