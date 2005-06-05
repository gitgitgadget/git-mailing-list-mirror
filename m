From: Junio C Hamano <junkio@cox.net>
Subject: Last mile for 1.0
Date: Sun, 05 Jun 2005 16:21:06 -0700
Message-ID: <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 01:18:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df4NA-0007GQ-Jc
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 01:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVFEXVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 19:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVFEXVL
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 19:21:11 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54264 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261159AbVFEXVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 19:21:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605232106.EOGD550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 19:21:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 5 Jun 2005 15:11:26 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> You document the "rename" header as being "rename from/to", which is 
LT> sensible, but doesn't match reality. diff.c has "rename old/new". I found 
LT> that out the hard way when doing git-apply ;)

The document was cut & paste from the version of apply.c before
you found it out "the hard way", so of course its wording is
sensible ;-) Anyway, I think we settled this part.

There are still some remaining issues before 1.0.  The ones I
personally would want to see merged and/or addressed are:

 - git-ssh-push documentation updates from Dan Barkalow, which
   he mentions in *1*.  I am the primarily guilty one about
   "other people seem to have missed it".

 - "-w heads/master heads/master" extension to the pull family,
   again from Dan, mentioned in the same message.

 - "--merge-order" extension to the git-rev-list, from Jon
   Seymour, last posted as *2*.  I have not tried it on
   something big (like linux-2.6 repository) and cannot vouch
   for its correctness myself, but I find what it claims to do
   quite sensible and attractive.

 - Tutorials you have been working on.  I'd appreciate it if my
   earlier "what about cvs annotate" example *3* finds its home
   somewhere in that document ;-).

 - "What happens when a merge goes wrong" helper script Jeff
   wanted to have in *4*.

 - Documentation from Jason McMullan for more commands, reminded
   by Petr Baudis in *5*.

[References]

*1* <Pine.LNX.4.21.0506031927000.30848-100000@iabervon.org>

*2* <20050605134733.3123.qmail@blackcubes.dyndns.org>

*3* <7vll5s35pd.fsf@assigned-by-dhcp.cox.net>

*4* <42A181C1.3010902@pobox.com>

*5* <20050605204739.GR17462@pasky.ji.cz>

