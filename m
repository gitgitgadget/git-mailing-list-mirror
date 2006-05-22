From: Pavel Roskin <proski@gnu.org>
Subject: Re: synchronizing incremental git changes to cvs
Date: Mon, 22 May 2006 12:29:22 -0400
Message-ID: <1148315362.29228.27.camel@dv>
References: <87mzdcjqey.fsf@rho.meyering.net>
	 <Pine.LNX.4.63.0605210104470.3148@wbgn013.biozentrum.uni-wuerzburg.de>
	 <873bf3jy2t.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 18:30:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiDIa-0003Y0-6b
	for gcvg-git@gmane.org; Mon, 22 May 2006 18:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWEVQaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 12:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWEVQaZ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 12:30:25 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:56286 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750971AbWEVQaY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 12:30:24 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FiDIU-0001TZ-Sn
	for git@vger.kernel.org; Mon, 22 May 2006 12:30:23 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FiDHW-0006kN-RZ; Mon, 22 May 2006 12:29:22 -0400
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <873bf3jy2t.fsf@rho.meyering.net>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20513>

Hello, Jim!

On Sun, 2006-05-21 at 15:40 +0200, Jim Meyering wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 21 May 2006, Jim Meyering wrote:
> >
> >> Why am I interested?  I want to switch the development of GNU coreutils
> >> from cvs to git.

I believe you have a very good reason to talk to decision makers in FSF.
Savannah is very poorly maintained, and I actually took one of my
projects (Orinoco driver) to SourceForge Subversion.

If losing a Linux driver is next to nothing, losing GNU coreutils is a
big deal for the GNU development site.  You are likely to be heard if
you request git support.

>   I would also like to continue making the repository
> >> available via cvs, for the sake of continuity.  At worst, I can always
> >> cut the CVS cord, but that's a last resort.

Subversion is as easy as CVS for potential users, but it has a useful
"log" command if nothing else.  It also have real changesets, which
means no more guesswork when moving changes back and forth.

> > If you only want to make a cvs repository available for tracking the
> > project, git-cvsserver is what you want. It is even faster than the
> > original cvs...
> 
> That might work if I had sufficient access to the system hosting the
> public CVS repository.  But there are restrictions (like no ssh access).
> Currently I rsync the master repo to an intermediate site, from which
> it is periodically pulled by savannah.  Paranoia on both sides.
> 
> If I end up leaving savannah, can someone propose a good site,
> i.e., secure, yet with git and rsync access?

Sorry, I don't know any free git hosters, but here's what you can do:

1) Pressure Savannah to support git
2) Use arch on Savannah
3) Move to Subversion on SourceForge, GNA.org or Berlios and use git-svn

-- 
Regards,
Pavel Roskin
