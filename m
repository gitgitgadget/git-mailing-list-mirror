From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Wed, 22 Apr 2009 07:35:03 -0700
Message-ID: <20090422143503.GG23604@spearce.org>
References: <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> <alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net> <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904141542161.6741@xanadu.home> <20090414T202206Z@curie.orbis-terrarum.net> <1240362948.22240.76.camel@maia.lan> <e2b179460904220255v58986bd5q7c22eb3ab8486157@mail.gmail.com> <alpine.DEB.1.00.0904221516250.14221@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Sam Vilain <sam@vilain.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matt Enright <awickedshimmy@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 22 16:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwdZ2-0002l9-VG
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 16:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZDVOfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 10:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbZDVOfF
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 10:35:05 -0400
Received: from george.spearce.org ([209.20.77.23]:34915 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbZDVOfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 10:35:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0DDB83821F; Wed, 22 Apr 2009 14:35:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904221516250.14221@intel-tinevez-2-302>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117200>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 22 Apr 2009, Mike Ralphson wrote:
> 
> > 2009/4/22 Sam Vilain <sam@vilain.net>
> > > Now that the GSoC projects have been announced I can give you the good
> > > news that one of our two projects...
> > 
> > It's sort of three, really...
> > 
> > http://socghop.appspot.com/student_project/show/google/gsoc2009/mono/t124022708105
> 
> OMG!  That's the third time they are wasting Google's money: AFAICT they 
> haven't learnt from the past two years' failures.  At least I am not aware 
> of any of them Mono guys trying to collaborate with us.

Yikes!

Wearing my Google hat, I have to cry a little.  I think its such
a waste.  But we don't tell the orgs what projects they should or
should not do, its at each org's individual discretion.  Clearly the
Mono folks feel they should "spend" a *fourth* slot on this project.
That or, Mono was granted one too many slots in the program.  *sigh*

Wearing my JGit maintainer hat, I have to cry a little.  The mentor
for this project should realize... we've spent over 3 years now
on JGit (it turned 3 on Mar 6 2009) and it *still* doesn't provide
a full replacement for git.git.

I'd like to think that I'm not a moron, and that it really does
take 3 years of R&D work to find a suitable implementation of Git
in a sandboxed language like Java.  Or, maybe I am a moron.  Linus,
Junio and crew had git.git implemented in less time.
 
> Oh well, maybe I should drop them a mail that they may get valuable input 
> here _iff_ they just ask.

I've tried that in the past two years.  I've given up.  The JGit
code is available.  Its license is quite liberal.  They can look
at it if they want.  My guess is, they won't.

-- 
Shawn.
