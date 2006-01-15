From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: RFC: Subprojects
Date: Sat, 14 Jan 2006 18:55:50 -0700
Message-ID: <20060115015550.GD9672@socrates>
References: <43C537C9.4090206@hogyros.de>
 <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
 <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org> <43C951B6.5030607@gmail.com>
 <Pine.LNX.4.64.0601141154590.13339@g5.osdl.org> <43C95F69.7090200@gmail.com>
 <7vk6d2fsu6.fsf@assigned-by-dhcp.cox.net>
 <46a038f90601141628n2ec32e8fy7fc23d8d7884c0f2@mail.gmail.com>
 <7v4q4671tg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 15 02:54:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exx6W-00088o-04
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 02:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWAOByp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 20:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWAOByp
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 20:54:45 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:14640 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750840AbWAOByo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 20:54:44 -0500
Received: from pd4mr7so.prod.shaw.ca (pd4mr7so-qfe3.prod.shaw.ca [10.0.141.84])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0IT400DTI2N8ZK30@l-daemon> for git@vger.kernel.org; Sat,
 14 Jan 2006 18:54:44 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
 by pd4mr7so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0IT400JTD2N8RC80@pd4mr7so.prod.shaw.ca> for
 git@vger.kernel.org; Sat, 14 Jan 2006 18:54:44 -0700 (MST)
Received: from socrates ([68.148.44.80])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0IT4004QD2N7LEA0@l-daemon> for git@vger.kernel.org; Sat,
 14 Jan 2006 18:54:44 -0700 (MST)
Received: from socrates (localhost [127.0.0.1])	by socrates (8.13.4/8.13.4)
 with ESMTP id k0F1to3H008101	for <git@vger.kernel.org>; Sat,
 14 Jan 2006 18:55:50 -0700
Received: (from cougar@localhost)	by socrates (8.13.4/8.13.4/Submit)
 id k0F1toh2008100	for git@vger.kernel.org; Sat, 14 Jan 2006 18:55:50 -0700
In-reply-to: <7v4q4671tg.fsf@assigned-by-dhcp.cox.net>
To: git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14692>

On Sat, Jan 14, 2006 at 04:49:15PM -0800, Junio C Hamano wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
> 
> > I am with gitzilla on this one. Let the projects have their own
> > bootstraping mechanisms, using make, ant or whatever catches their
> > fancy. One of the great things about git is that it doesn't assume
> > that it's being used by all the projects in the world -- thanks to
> > Linus' disregard for arbitrary metadata and to your git-cherry
> > implementation, it's all about the content -- and so it interoperates
> > great with Arch, SVN, CVS, etc.
> 
> 
> I hope this settles this issue and nobody would bring up "Wee
> want subprojects" ever again ;-).
> 

But since we can import everything into a GIT repository, and have
(some) tools for pushing changes back, we can pretend that it is being
used for every project in the world.

  Tom
