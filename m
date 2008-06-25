From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack.indexversion config option now defaults to 2
Date: Wed, 25 Jun 2008 14:53:41 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806251449530.2979@xanadu.home>
References: <alpine.LFD.1.10.0806250025130.2979@xanadu.home>
 <alpine.LFD.1.10.0806242130450.22069@hp.linux-foundation.org>
 <7vd4m66rfp.fsf@gitster.siamese.dyndns.org>
 <20080625055605.GD28563@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 20:54:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBa8k-0000eL-GG
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 20:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbYFYSxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 14:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbYFYSxu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 14:53:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39692 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbYFYSxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 14:53:49 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3100HJN8HH1M60@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Jun 2008 14:53:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080625055605.GD28563@glandium.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86319>

On Wed, 25 Jun 2008, Mike Hommey wrote:

> On Tue, Jun 24, 2008 at 09:59:06PM -0700, Junio C Hamano wrote:
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > 
> > > On Wed, 25 Jun 2008, Nicolas Pitre wrote:
> > >> 
> > >> Git older than version 1.5.2 (or any other git version with this option
> > >> set to 1) may revert to version 1 of the pack index by manually deleting
> > >> all .idx files and recreating them using 'git index-pack'.  Communication
> > >> over the git native protocol is unaffected since the pack index is never
> > >> transferred.
> > >
> > > Rather than talk about when it does _not_ matter, wouldn't it be better to 
> > > talk about when it _can_ matter?
> > >
> > > Namely when using dumb protocols, either http or rsync, with the other end 
> > > being some ancient git thing (and it is worth mentioning version of what 
> > > counts as 'ancient' too, I can't remember, probably means that pretty much 
> > > nobody else can either).
> > 
> > I agree with you that the description of the change (in the commit log)
> > and the instruction (in the documentation) could be more helpful and
> > explicit.
> (...)
> 
> Wouldn't it be a good idea to add a warning in git update-server-info
> when it detects pack.indexVersion is not 1, too ?

That would give the idea that index v2 is not good, while what we want 
is to encourage everyone to move to index v2 ASAP.


Nicolas
