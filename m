From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Sun, 14 Oct 2007 19:39:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141934310.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git list <git@vger.kernel.org>, Eli Zaretskii <eliz@gnu.org>,
	Make Windows <make-w32@gnu.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:40:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih8Nd-0005qO-Aj
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 20:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758825AbXJNSjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 14:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759385AbXJNSjO
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 14:39:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:58329 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754225AbXJNSjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 14:39:12 -0400
Received: (qmail invoked by alias); 14 Oct 2007 18:39:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 14 Oct 2007 20:39:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IHyZOuq3I5xTRTQ4KFq/T+m47jN/GynL/+v+fP6
	6OuCO93bZd86kW
X-X-Sender: gene099@racer.site
In-Reply-To: <47125F74.9050600@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60891>

Hi,

On Sun, 14 Oct 2007, Andreas Ericsson wrote:

> Benoit SIGOURE wrote:
> > Context: GNU make seems to be willing to switch from CVS to ... something
> > else.
> > 
> > On Oct 14, 2007, at 6:57 PM, Paul Smith wrote:
> > 
> > > [...] the big thing no one else seems to have addressed much in
> > > other discussions I've seen is portability.  It LOOKS like there are
> > > native ports of GIT to MINGW, but I have no idea how complete and usable
> > > they are.  If someone who has a Windows system could look into that it
> > > would be a big help.
> > 
> > I think the best thing to do is to ask directly on the Git ML.
> > 
> > Someone already pointed out that he'd like to use Git on Windows but 
> > doesn't want to install either Cygwin or MSYS.  Is this possible, or 
> > will it be possible in the near future?
> 
> It is sort of possible. Without cygwin he'll be in the black for the few 
> features that are still implemented as shell-scripts, but perhaps he/she 
> will then be inclined to help us migrate those scripts to C builtins.

Umm.  There are quite a few shell scripts still _necessary_ to run git: 
git-commit, git-fetch and git-merge being the most prominent ones.  The 
first two are in the process of being rewritten _right_ _now_, but no 
official git release has them yet.

And I have to disagree strongly with the "black": In msysGit (which brings 
its own minimal version of MSys), it is very smooth.

> >  Is it possible to use one of the various GUIs (git-gui, gitk, qgit) 
> > on Windows without requiring a POSIXish shell etc.?
> > 
> 
> qgit is possible to use natively, if one installs the qgit4 libraries 
> for windows, but it's more of a viewer than an action gui. git-gui and 
> gitk are usable if you have the windows TCL port. I haven't tried it, 
> but there are installers available, so testing it out (with all 
> dependencies) shouldn't take too long.

FWIW msysGit comes with Tcl.  You can run git gui and gitk without any 
hassles.

> > When will the librarification of Git be finished?
> 
> When someone gets around to doing it ;-)

There has been a GSoC project, and it has a nice small API which can be 
called from Python, for example.

Funnily enough, the first user is qgit as far as I know, which is written 
in C++...

> >  (if Git is available as a library, and if this library works on 
> > Windows, it will greatly help truly native Windows ports).
> 
> Yup. I believe the primary reason for libification is to easier support 
> both porting and fully-fledged gui's.

Why?

I do not see any reason why libification helps the user experience on 
Windows.

Ciao,
Dscho
