From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 22:09:05 -0700
Message-ID: <7voeazopse.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
	<20050524161745.GA9537@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
	<20050524184612.GA23637@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
	<20050524202846.GC25606@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org>
	<20050524213102.GB19180@vrfy.org>
	<7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505242153150.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 07:08:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dao7C-0001ap-Ug
	for gcvg-git@gmane.org; Wed, 25 May 2005 07:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVEYFJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 01:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVEYFJL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 01:09:11 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38041 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262270AbVEYFJH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 01:09:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525050906.ZGHI1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 01:09:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505242153150.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 21:55:17 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> The only sane interface I can think of is to expose the subdirectory 
LT> history and then pick from that. Otherwise you'd have to actually type in 
LT> the name, which is a bit against the notion of a graphical browsing 
LT> interface.

Knowing to type "merge-tree.c" you need to be an old timer ;-).

Since I asked that question I found out that each commit has a
link to the diff and the tree, so if I know when merge-tree.c
disappeared, I can go backwards from there.

I think what is useful, from software archaeologist point of
view, would be to give a way to the web users to use pickaxe.
Type piece of code in the textbox and have the CGI run "rev-log
| diff-tree -S'<that piece of the code>'".

