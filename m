From: Nicolas Pitre <nico@cam.org>
Subject: Re: Detached checkout will clobber branch head when using symlink HEAD
Date: Thu, 16 Oct 2008 16:30:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810161629550.26244@xanadu.home>
References: <1224095087.5366.19.camel@localhost>
 <20081016191751.GB14707@coredump.intra.peff.net>
 <1224187863.2796.15.camel@localhost>
 <alpine.LFD.2.00.0810161619330.26244@xanadu.home>
 <20081016202202.GA9487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matt Draisey <matt@draisey.ca>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:31:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZVY-0001eM-9e
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbYJPUab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbYJPUaa
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:30:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12251 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbYJPUaa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:30:30 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8U006TUMAOPFE5@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 16 Oct 2008 16:30:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081016202202.GA9487@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98420>

On Thu, 16 Oct 2008, Jeff King wrote:

> On Thu, Oct 16, 2008 at 04:20:32PM -0400, Nicolas Pitre wrote:
> 
> > > so almost all my git repositories are still using a symlink HEAD.
> > > I have some old scripts That I use occasionally and still depend on it.
> > > Using detached checkout is the only problem I've had.
> > 
> > A symlink HEAD and detached checkouts are simply incompatible.
> 
> Agreed, but I think the complaint is not that it doesn't work, but that
> it silently clobbers the current branch when you try it.

That is unacceptable indeed.


Nicolas
