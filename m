From: Nicolas Pitre <nico@cam.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 09 Jun 2006 17:05:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606091655420.2703@localhost.localdomain>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com>
 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org>
 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 23:06:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FooB7-0001Uh-MW
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 23:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWFIVF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 17:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWFIVF6
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 17:05:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47786 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965208AbWFIVF5
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 17:05:57 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0M000ME2LWXAC0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Jun 2006 17:05:56 -0400 (EDT)
In-reply-to: <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21560>

On Fri, 9 Jun 2006, Jon Smirl wrote:

> I haven't come up with anything that is likely to result in Mozilla
> switching over to git. Right now it takes three days to convert the
> tree. The tree will have to be run in parallel for a while to convince
> everyone to switch. I don't have a solution to keeping it in sync in
> near real time (commits would still go to CVS). Most Mozilla
> developers are interested but the infrastructure needs some help.

This is true.  GIT is still evolving and certainly needs work to cope 
with environments and datasets that were never tested before.  The 
Mozilla repo is one of those and we're certainly interested into making 
it work well.  GIT might not be right for it just yet, but if you could 
let us rsync your converted repo to play with that might help us work on 
proper fixes for that kind of repo.

> Martin has also brought up the problem with needing a partial clone so
> that everyone doesn't have to bring down the entire repository.

If it can be repacked into a single pack that size might get much 
smaller too.


Nicolas
