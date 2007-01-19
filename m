From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Documentation/git.txt: command re-classification
Date: Fri, 19 Jan 2007 17:44:58 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701191729060.3011@xanadu.home>
References: <Pine.LNX.4.64.0701181713200.2577@xanadu.home>
 <7v1wlrle61.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701191437450.3011@xanadu.home>
 <7vbqkufyhy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 23:45:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H82Tv-0002yY-Ai
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbXASWpA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 17:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbXASWpA
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:45:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16918 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617AbXASWo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:44:59 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JC5007OO0IYB9B0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Jan 2007 17:44:59 -0500 (EST)
In-reply-to: <7vbqkufyhy.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37215>

On Fri, 19 Jan 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > OK.  But I think the following are still misclassified:
> >
> >   git-rev-parse
> >   git-runstatus
> >   git-fsck-objects
> 
> Thanks for proofreading.  runstatus should be a pure helper.  I
> am not sure what rev-parse and fsck-objects are, but they are
> not primary porcelain.  rev-parse could sit next to rev-list and
> fsck-objects, I guess.

I don't think fsck-objects is really plumbing though.  I'd tag it as 
ancillaryinterrogators.

Also, having:

   git-am(1)
          Apply a series of patches from a mailbox.

   git-applymbox(1)
          Apply a series of patches in a mailbox.

looks a bit weird.  Why two commands with almost the same description?  
Maybe one of them could be relegated to ancillary?  Or even both of them 
to foreignscminterface?

Is git-show-branch really a primary command?

Then what about moving one of annotate or blame to the main section?

> >> +The interface (input, output, set of options and the semantics) 
> >> +to these low-level commands are meant to be a lot more stable 
> >> +than Porcelain level commands, because these commands are 
> >> +primarily for scripted use.  To put it another way, the +interface 
> >> to Plumbing commands are subject to change in order to +improve the 
> >> end user experience.
> >
> > I think the "to put it another way" sentence is a bit confusing here.
> 
> I agree.  What I wanted to say was the interface to plumbing is
> sacred and we will not lightly change it without a very good
> reason, while Porcelains are more or less "for breaking".
> 
> Better wording is certainly appreciated.

I'd just drop the "to put it another way" entirely.


Nicolas
