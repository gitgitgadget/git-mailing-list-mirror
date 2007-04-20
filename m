From: Petr Baudis <pasky@suse.cz>
Subject: Re: History cleanup/rewriting script for git
Date: Fri, 20 Apr 2007 20:44:23 +0200
Message-ID: <20070420184423.GP4489@pasky.or.cz>
References: <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site> <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org> <Pine.LNX.4.64.0704191118050.8822@racer.site> <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org> <20070420155446.GA11506@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0704202037140.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 20 20:44:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hey69-0001xJ-SX
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 20:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767195AbXDTSo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 14:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767190AbXDTSo1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 14:44:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34892 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767195AbXDTSo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 14:44:26 -0400
Received: (qmail 30473 invoked by uid 2001); 20 Apr 2007 20:44:23 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704202037140.8822@racer.site>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45122>

On Fri, Apr 20, 2007 at 08:39:25PM CEST, Johannes Schindelin wrote:
> Telling by your description, cg-admin-rewrite-hist is more capable. And I 
> think it should not be too complicated to rewrite the cogito specific 
> parts, what with the parts we added to Git with cogito as a model. And it 
> is in Perl... which makes it more portable than Python in my part of the 
> world.

It is in shell, actually. (Well, bash, but I think [[ is the only
bashism in that one.) And it was specifically written to be as
independent of Cogito as possible, I think it uses only Cogito's cool
commandline parsing routines. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
