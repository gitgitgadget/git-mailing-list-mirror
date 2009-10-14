From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Wed, 14 Oct 2009 16:48:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyAof-0007lo-Si
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 22:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759886AbZJNUtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 16:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757204AbZJNUtL
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 16:49:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26459 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227AbZJNUtK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 16:49:10 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRI00CY6V4T56A0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Oct 2009 16:48:29 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130339>

On Wed, 14 Oct 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > On Wed, 14 Oct 2009, Daniel Barkalow wrote:
> >
> >> On Wed, 14 Oct 2009, Jay Soffian wrote:
> >> 
> >> > $ git commit -m "blah"
> >> > Cannot commit while not on any branch. Please use git commit -b <branch> to
> >> > specify the name of a new branch to commit to, or use git commit -f to
> >> > force a detached commit.
> >> 
> >> The difference is that some experienced users depend on being able to 
> >> commit while not on a branch, and want to not get a warning for every 
> >> commit while not on a branch.
> >
> > I assume that the -f would silence any warning?
> 
> It won't help to alleviate my irritation if I need to give -f to each and
> every invocation of "git commit" while detached, though.

Agreed.  Presumably some expert mode config would imply -f 
automatically.


Nicolas
