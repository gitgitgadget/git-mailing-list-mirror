From: Nicolas Pitre <nico@cam.org>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 11:30:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608181119410.11359@localhost.localdomain>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
 <44E546F2.7070902@gmail.com>
 <Pine.LNX.4.64.0608181041420.11359@localhost.localdomain>
 <44E5D522.8030407@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 17:31:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE6JJ-00052S-U9
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 17:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWHRPa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 11:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWHRPa6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 11:30:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8687 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751400AbWHRPa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 11:30:57 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4700LRD9RK6L80@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 18 Aug 2006 11:30:56 -0400 (EDT)
In-reply-to: <44E5D522.8030407@gmail.com>
X-X-Sender: nico@localhost.localdomain
To: A Large Angry SCM <gitzilla@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25670>

On Fri, 18 Aug 2006, A Large Angry SCM wrote:

> Nicolas Pitre wrote:
> > On Thu, 17 Aug 2006, A Large Angry SCM wrote:
> ...
> >>
> >> 1) I disagree with Nico's assessment that, other than his, there can not
> >> exist any type 2 packs that have bit 6 set to mean copy from result.
> > 
> > Care to explain why?
> > 
> > Since this code is mine I can tell you that no official GIT version ever 
>                                               ^^^^^^^^^^^^^^^^^^^^^^^
> > produced such a pack.  The code to make use of that bit was quite 
> > involving and the end result wasn't great at all so I never published 
> > said code.  This is also why current GIT accepts both pack version 2 and 
> > 3 without any distinction using the same code in patch-delta.c on the 
> > basis that no version 2 packs ever used that bit.
> 
> That doesn't prove the non-existence of other code to do it.

So?  If the official and primary code for GIT doesn't support it, what 
is the point?  I'm telling you that if such packs exist they will simply 
barf with all official GIT releases later than v1.1.6 making your 
argument pointless.

I don't mind you documenting that historic intent for a bit that was 
never officially used, but at least let's document it right.


Nicolas
