From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] tone down the detached head warning
Date: Wed, 31 Jan 2007 22:47:31 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701312238420.3021@xanadu.home>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
 <20070131231942.GB31145@coredump.intra.peff.net>
 <Pine.LNX.4.64.0701311907500.3021@xanadu.home>
 <20070201030030.GA1979@coredump.intra.peff.net>
 <7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
 <20070201032925.GA2505@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 04:47:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCSvE-00039I-0F
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 04:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbXBADre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 22:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161299AbXBADre
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 22:47:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34390 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161131AbXBADrd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 22:47:33 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCR00LN4MJ7GEH0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 31 Jan 2007 22:47:32 -0500 (EST)
In-reply-to: <20070201032925.GA2505@coredump.intra.peff.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38325>

On Wed, 31 Jan 2007, Jeff King wrote:

> On Wed, Jan 31, 2007 at 07:23:21PM -0800, Junio C Hamano wrote:
> 
> >         M	foo.c
> >         Switched to branch "master"
> > 	: gitster project/master; git checkout master^
> > 	M	bar.c
> >         M	foo.c
> > 	Detached your HEAD -- you are not on any branch.
> >         If you want to create a new branch from this checkout, you may do so
> >         (now or later) by using -b with the checkout command again. Example:
> >           git checkout -b <new_branch_name>
> > 	: gitster project; 
> >
> > would feel very natural and much less scary.
> 
> 
> Much improved, IMHO. As an added bonus, I think it creates some feedback
> that lets a user know when they have mistakenly used 'git checkout' to
> switch heads when they meant to restore a file.

Indeed.

> I still wish there was some other language for detaching to a commit
> specified by a remote tracking branch; it just seems wrong to say "you
> are not on any branch" right after the user requests to checkout a
> branch (admittedly not one of their local branches, but for a user
> merely poking through the repository, the difference is probably not
> important).

But this language convey the truth and users will have to get used to it 
at some point. We should not hide the fact that HEAD is really detached at
that point, otherwise it could be presumed that a commit might update the
checked out (tracking) branch which is obviously not the case.


Nicolas
