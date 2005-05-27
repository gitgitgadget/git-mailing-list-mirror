From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix ptrdiff_t vs. int
Date: Fri, 27 May 2005 11:20:43 -0700
Message-ID: <7vfyw8zg1w.fsf@assigned-by-dhcp.cox.net>
References: <42971EB4.2050403@oberhumer.com>
	<Pine.LNX.4.58.0505271013260.17402@ppc970.osdl.org>
	<Pine.LNX.4.58.0505271024280.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 20:22:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbjSd-0003iL-Sn
	for gcvg-git@gmane.org; Fri, 27 May 2005 20:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVE0SWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 14:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVE0SWt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 14:22:49 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62623 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262529AbVE0SUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 14:20:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527182044.KPHM550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 14:20:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505271024280.17402@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 27 May 2005 10:25:51 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Fri, 27 May 2005, Linus Torvalds wrote:
>> 
>> I can compile a kernel with "-m64", but since I don't have any 64-bit
>> libraries installed, user space doesn't work that well ;)

LT> Btw, since this was the piece of code that I didn't bother simplifying 
LT> last time it was discussed (then it was just "ugly"), I took a different 
LT> approach instead, and committed the following..

I thought about this after getting your "Your solution is the
yucky one" message, but make sure that you are not adding an
extra blank line when this is combined with diff-helper.  I
think you currently do.

