From: Nicolas Pitre <nico@cam.org>
Subject: Re: bad git pull
Date: Sat, 17 Dec 2005 16:04:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512171601430.26663@localhost.localdomain>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
 <7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net>
 <7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
 <118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com>
 <7vfyoshmp6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512161347490.3698@g5.osdl.org>
 <118833cc0512161637v1d180f9fh66a7dc6d3fe11d2b@mail.gmail.com>
 <Pine.LNX.4.64.0512161701400.3698@g5.osdl.org>
 <7vy82kbiho.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512162342010.3698@g5.osdl.org>
 <7v4q582htm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 22:06:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnjEx-0000OX-Vi
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 22:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVLQVEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 16:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVLQVEl
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 16:04:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:50577 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964947AbVLQVEk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2005 16:04:40 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IRN007OSUJPJ3C0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 17 Dec 2005 16:04:37 -0500 (EST)
In-reply-to: <7v4q582htm.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13779>

On Sat, 17 Dec 2005, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > That said, I think a lot of newbies might want to have a "git undo", and 
> > not because of any BK history. Even if it just ends up being nothing but 
> > shorthand for "git reset --hard ORIG_HEAD".
> 
> I agree to this in principle, but I am afraid "git undo" is too
> generic and fuzzy a term.  Things you might possibly want to
> undo depends on what you did last [*1*].  In most undoable
> cases, "reset --hard" is almost right but most likely would
> result in information loss.

One observation is that ORIG_HEAD should probably be named PREV_HEAD in 
such context to make it more obvious what it is about.


Nicolas
