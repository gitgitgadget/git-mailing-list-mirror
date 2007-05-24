From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 11:38:44 -0700
Message-ID: <7vejl6xe17.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
	<20070524072945.GO28023@spearce.org>
	<20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241039200.4648@racer.site>
	<20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241201270.4648@racer.site>
	<20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241230410.4648@racer.site>
	<20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241315290.4648@racer.site>
	<8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
	<7vabvuywix.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	skimo@liacs.nl, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 24 20:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrID7-0008BI-V4
	for gcvg-git@gmane.org; Thu, 24 May 2007 20:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbXEXSir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbXEXSir
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 14:38:47 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:37327 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbXEXSiq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 14:38:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524183845.VNJM19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 14:38:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 36ek1X00E1kojtg0000000; Thu, 24 May 2007 14:38:45 -0400
In-Reply-To: <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 24 May 2007 10:40:52 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48288>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I actually really liked Junio's suggestion of
>
> 	[subproject "git://git.kernel.org/pub/linux-2.4.git"]
> 		URL = http://www.kernel.org/pub/linux-2.4.git
> ...
> Note how that example had nothing to do with subprojects per se: the URL 
> rewriting is really another issue. But yes, I think it might also be worth 
> it to actually be able to override the whole subproject data, ie also have
>
> 	[subproject "kernel/"]
> 		url = ...
> 		branch = xyzzy
>
> and allow that kind of information in .git/config to _override_ any such 
> entry in .gitmodules!

I just sent out a rather longish message that peripherally
touches this and said I liked the three-level thing Steven Grimm
suggested, which is essentially what you wrote above.

I am reasonably happy that we are in agreement and I was not way
off in the design area by myself.
