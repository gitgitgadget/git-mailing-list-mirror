From: Nicolas Pitre <nico@cam.org>
Subject: Re: Unresolved issues #3
Date: Sun, 20 Aug 2006 19:10:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608201840310.11359@localhost.localdomain>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
 <44E546F2.7070902@gmail.com>
 <Pine.LNX.4.64.0608181041420.11359@localhost.localdomain>
 <44E5D522.8030407@gmail.com>
 <Pine.LNX.4.64.0608181119410.11359@localhost.localdomain>
 <44E68DCD.8010603@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 01:10:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEwR1-0005Ix-Ou
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 01:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWHTXKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 19:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWHTXKZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 19:10:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15170 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751792AbWHTXKY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 19:10:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4B0026GKDBH640@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 20 Aug 2006 19:10:23 -0400 (EDT)
In-reply-to: <44E68DCD.8010603@gmail.com>
X-X-Sender: nico@localhost.localdomain
To: A Large Angry SCM <gitzilla@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25771>

On Fri, 18 Aug 2006, A Large Angry SCM wrote:

> Nicolas Pitre wrote:
> > On Fri, 18 Aug 2006, A Large Angry SCM wrote:
> >> That doesn't prove the non-existence of other code to do it.
> > 
> > So?  If the official and primary code for GIT doesn't support it, what 
> > is the point?  I'm telling you that if such packs exist they will simply 
> > barf with all official GIT releases later than v1.1.6 making your 
> > argument pointless.
> > 
> > I don't mind you documenting that historic intent for a bit that was 
> > never officially used, but at least let's document it right.
> 
> Historic fact. Between Thu May 19 08:56:22 2005 and Thu Feb  9 21:06:38
> 2006 bit 6 of the first byte of a delta hunk was interpreted to mean
> that the source of the copy was the result buffer. From Thu May 19
> 08:56:22 2005 on, the code to decode delta hunks in type 2 packs was
> available to everyone and anyone interested could make a pack encoder
> that would create packs that the core Git code would correctly read. The
> commit of Thu Feb  9 21:06:38 2006, d60fc, actually introduced a bug
> that would treat valid type 2 packs as invalid.

The "actually introduced a bug" sentence is your own interpretation not 
a _fact_.

And I simply disagree with that interpretation of yours.

I don't think this is worth arguing any further.


Nicolas
