From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sun, 01 Jul 2007 11:16:20 -0700
Message-ID: <7vir946lcb.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
	<7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
	<20070630194335.GK7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<7vtzsoami9.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0706301955560.1172@woody.linux-foundation.org>
	<7vsl8894tc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707011301540.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Carlos Rica <jasampler@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 20:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I53yL-0005E3-GA
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 20:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbXGASQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 14:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbXGASQX
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 14:16:23 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46733 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbXGASQW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 14:16:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070701181621.LWRG17683.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 1 Jul 2007 14:16:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JJGM1X0091kojtg0000000; Sun, 01 Jul 2007 14:16:21 -0400
In-Reply-To: <Pine.LNX.4.64.0707011301540.4438@racer.site> (Johannes
	Schindelin's message of "Sun, 1 Jul 2007 13:12:16 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51314>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Carlos had a cute idea on IRC, but was too shy to mention it here. There 
> is a central place for Git's shell script, git-sh-setup. Defining an 
> environment variable there, GIT_NO_ALIAS, and honouring that in the Git 
> wrapper. Something similar is possible in Git.pm for perl scripts.
>
> Note: I am opposed to overriding default parameters via alias. I am only 
> stating that it is still possible.
>
> I am in favour of Linus' patch. Here's why: quite some times, I have been 
> asked (at a very late stage) "What still confuses me: what is the 
> difference between git-xyz and git xyz?" It _is_ confusing for beginners, 
> even if it is easy to explain.

Ok, please consider the idea sold.
