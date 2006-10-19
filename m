From: Jan Hudec <bulb@ucw.cz>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 07:33:55 +0200
Message-ID: <20061019053355.GA9403@artax.karlin.mff.cuni.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 07:33:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaQXS-0006wL-9p
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 07:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161310AbWJSFdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 01:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbWJSFdv
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 01:33:51 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:12986 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1161310AbWJSFdu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 01:33:50 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id E06854A86; Thu, 19 Oct 2006 07:33:55 +0200 (CEST)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <4536EC93.9050305@utoronto.ca>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29323>

On Wed, Oct 18, 2006 at 11:10:11PM -0400, Aaron Bentley wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Linus Torvalds wrote:
> 
> > For example, what happens is that:
> >  - you like the simple revision numbers
> >  - that in turn means that you can never allow a mainline-merge to be done 
> >    by anybody else than the main maintainer
> 
> That's not true of bzr development.  The "main maintainer" that runs the
> bzr.dev is an email bot.  It's not an integrator-- its work is purely
> mechanical.  It can't resolve merge conflicts.

The point here is, that because of using the bot, the revnos on bzr.dev
are indeed stable (and many of the merges are in fact pointless merges
(ie. merges of revision and it's ancestor)). But if you don't use the
bot, than doing:

bzr merge mainline
bzr push mainline

makes your revision the leftmost parent is your revison, not the one
from "mainline". The fact that bzr treats leftmost parent somewhat
specially makes people to replace the above with

bzr branch mainline
cd mainline
bzr merge feature-branch
bzr push

which is, well, more complicated (but you see it's not about main
maintainer -- anybody with write access can push).

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
