From: Nicolas Pitre <nico@cam.org>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 21:47:38 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806102143080.23110@xanadu.home>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
 <m3abhtp42o.fsf@localhost.localdomain>
 <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
 <200806102159.02875.jnareb@gmail.com>
 <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
 <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
 <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
 <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
 <6dbd4d000806101422j39709906x1b4b03b82b504e62@mail.gmail.com>
 <alpine.LFD.1.10.0806101431410.3101@woody.linux-foundation.org>
 <6dbd4d000806101509l516cf467me06fadee6ead0964@mail.gmail.com>
 <alpine.LFD.1.10.0806101518590.3101@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806102026430.23110@xanadu.home>
 <alpine.LFD.1.10.0806101836510.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Denis Bueno <dbueno@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 03:48:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6FRx-00034i-8r
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 03:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbYFKBrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 21:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754256AbYFKBrj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 21:47:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14618 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513AbYFKBrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 21:47:39 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2900MC2ZNEXHA0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Jun 2008 21:47:38 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0806101836510.3101@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84575>

On Tue, 10 Jun 2008, Linus Torvalds wrote:

> 
> 
> On Tue, 10 Jun 2008, Nicolas Pitre wrote:
> > 
> > I think this only gives a false sense of security with a huge 
> > performance cost.  If the machine crashes at the right moment, the 
> > object will still be half written/fsync'd and you'll be in the same 
> > situation again.
> 
> No you wouldn't.
> 
> We do the write and the fsync() of the write to a _temporary_ filename. We 
> do the rename _after_ the fsync.

Ah, true.  That part somehow evaded my mind.


Nicolas
