From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git/Mercurial interoperability (and what about bzr?) (was: Re:
 [VOTE]  git versus mercurial)
Date: Tue, 28 Oct 2008 11:03:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810281052490.13034@xanadu.home>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org>
 <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 28 17:09:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kur84-0002Tq-7u
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 17:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbYJ1QHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 12:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbYJ1QHk
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 12:07:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27167 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbYJ1QHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 12:07:40 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9G00F4QF47A700@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 28 Oct 2008 11:02:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99302>

On Tue, 28 Oct 2008, Peter Krefting wrote:

> Johannes Schindelin:
> 
> > While many may say that that is a half-baked solution, I actually
> > like it. Mercurial and Git are pretty similar in their concept (if
> > not in how the data is actually stored).
> 
> That touches on something that I have been thinking about for a while.
> 
> How difficult are the storage formats? Would it be possible, in a
> reasonable amount of work, to add support for the Mercurial protocol
> and format in "git clone", so that I could clone a Mercurial repository
> and work on it with Git, and then possibly use "git push" to possibly
> push the result back to Mercurial?

The git protocol is intimately tied to its repository storage format, 
making any interoperability at the protocol level really hard.  It is 
probably easier to perform the clone/push operations with native tools 
and do the interoperability dance locally between repositories, possibly 
with some wrappers hiding all the details.  In the end you could still 
be doing a "git push" but the native tool is best for handling transfer 
protocols.  Yes, there is git-cvsserver outperforming a real CVS server, 
but that's another story.


Nicolas
