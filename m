From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Wed, 14 Oct 2009 16:18:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyAQy-0003gz-5f
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 22:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933859AbZJNUWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 16:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933845AbZJNUWt
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 16:22:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51115 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250AbZJNUWt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 16:22:49 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRI000OMTQ3SW10@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Oct 2009 16:18:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130334>

On Wed, 14 Oct 2009, Daniel Barkalow wrote:

> On Wed, 14 Oct 2009, Jay Soffian wrote:
> 
> > $ git commit -m "blah"
> > Cannot commit while not on any branch. Please use git commit -b <branch> to
> > specify the name of a new branch to commit to, or use git commit -f to
> > force a detached commit.
> 
> The difference is that some experienced users depend on being able to 
> commit while not on a branch, and want to not get a warning for every 
> commit while not on a branch.

I assume that the -f would silence any warning?


Nicolas
