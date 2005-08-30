From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bisection visualization hint..
Date: Tue, 30 Aug 2005 10:47:57 -0700
Message-ID: <7vhdd7joz6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508301026450.4293@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 19:50:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAADU-0003Av-AT
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 19:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVH3RsI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 13:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVH3RsI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 13:48:08 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:12934 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932234AbVH3RsH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2005 13:48:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050830174758.HAXQ24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 Aug 2005 13:47:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508301026450.4293@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 30 Aug 2005 10:29:39 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7957>

Linus Torvalds <torvalds@osdl.org> writes:

> I'm testing bisection to find a bug that causes my G5 to no longer boot, 
> and during the process have found this command line very nice:
>
> 	gitk bisect/bad --not $(cd .git/refs ; ls bisect/good-*)
>
> it basically shows the state of bisection with the known bad commit as the 
> top, and cutting off all the good commits - so what you see are the 
> potential buggy commits.

> But it's not the nicest of command lines and depends on knowing how
> bisection works, so maybe we could make
>
> 	git bisect visualize
>
> do this for us?

Will do.

Another thing that might make sense is roll it also into gitk, a
new command from "File" menu to cause it to re-read not just ref
values but the rev-list itself out of that particular rev-list
command (and add any other common patterns as we discover them).
