From: Jan Hudec <bulb@ucw.cz>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 20:34:28 +0200
Message-ID: <20061021183428.GB29927@artax.karlin.mff.cuni.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <20061017073839.3728d1e7.seanlkml@sympatico.ca> <20061021141328.GE29843@artax.karlin.mff.cuni.cz> <20061021102346.9cd3abce.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 20:34:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbLfu-00053a-FW
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 20:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWJUSeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 14:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWJUSeX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 14:34:23 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:62926 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964773AbWJUSeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 14:34:22 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 31D0549C2; Sat, 21 Oct 2006 20:34:28 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061021102346.9cd3abce.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29652>

On Sat, Oct 21, 2006 at 10:23:46AM -0400, Sean wrote:
> On Sat, 21 Oct 2006 16:13:28 +0200
> Jan Hudec <bulb@ucw.cz> wrote:
> 
> > Bzr is meant to be used in both ways, depending on user's choice.
> > Therefore it comes with that infrastructure and you can choose whether
> > you want to use it or not.
> 
> >From what we've read on this thread, bzr appears to be biased towards
> working with a central repo.  That is the model that supports the use of
> revnos etc that the bzr folks are so fond of.   However Git is perfectly
> capable of being used in any number of models, including centralized.
> Git just doesn't make the mistake of training new users into using
> features that are only stable in a limited number of those models.

For one think I, like others already expressed, think difference should
be made between 'centralized' and 'star-topology'. Subversion is
centralized -- I don't think bzr is biased towards that kind of
centralization, though it provides tools (bound branches) to make it
easy.

I would agree it IS biased towards viewing branches as organized in a
hierarchy, while git strictly treats them as equal peers, which I'd call
star-topology (and I don't think it is because it _has_ revnos, but
because the user interface strongly favors them over revids).

On the other hand git is biased away from centralized (as in subversion
is centralized) in that it takes extra work to make sure you are always
synchronized (while bzr has bound branches to do the checking for you).
For open-source development, centralized is a wrong way to go, but
people use version control tools for other purposes as well and for some
of them staying synchronized is important.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
