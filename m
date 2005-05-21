From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Date: Sat, 21 May 2005 12:54:06 -0700
Message-ID: <7vvf5cgxsx.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
	<7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
	<7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 21:54:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZa2O-0003LY-7O
	for gcvg-git@gmane.org; Sat, 21 May 2005 21:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVEUTyP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 15:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVEUTyP
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 15:54:15 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:3487 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261420AbVEUTyI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 15:54:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521195407.FRSE550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 15:54:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 21 May 2005 11:27:23 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Sat, 21 May 2005, Junio C Hamano wrote:
>> 
LT> I'm also somewhat surprised by the fact that it even seems
LT> to be usable on the kernel tree:
>> 
>> Surprised?  Correctness-wise and/or performance-wise?

LT> Performance-wise. It seems to be quite usable, even doing just a plain
LT> "git-whatchanged -C" on the kernel with no limits on what it does.

That is probably because you do not have the feeding of "same"
in diff-tree.


