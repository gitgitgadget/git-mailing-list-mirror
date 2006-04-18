From: Junio C Hamano <junkio@cox.net>
Subject: Re: Log message printout cleanups
Date: Mon, 17 Apr 2006 17:22:46 -0700
Message-ID: <7vejzvka09.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
	<7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
	<7vodyzkehq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171647380.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 18 02:22:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVdzY-0006bn-3Z
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 02:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWDRAWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 20:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWDRAWt
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 20:22:49 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:62907 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751380AbWDRAWs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 20:22:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060418002247.CNZN18351.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Apr 2006 20:22:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604171647380.3701@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 17 Apr 2006 16:59:42 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18842>

Linus Torvalds <torvalds@osdl.org> writes:

> I suspect it would be better to just have the _first_ 
> diffstat, and always make the merge diffstat be the one for "result 
> against first parent".
>
> I realize that Dscho has been looking at some much "fancier" merge 
> diffstats, but I really do believe that the "what got merged" difference 
> to the original branch (ie parent 1) is what you want in practice.
>
> Anyway, that's a totally separate issue, I'll let you guys fight that out.

I agree with your opinion 100% from usability point of view,
although I admit one of the fancier format was suggested by me.

Showing stat from the first parent makes --stat inconsistent
from what the "fake diff" shows, but I think it is a sensible
thing to do.  The purpose of two are different in that (1) stat
is a way to see the extent of damage to what you had before you
merged, and (2) --cc is a way to see how complex the merge was,
to spot obvious merge mistakes and sanity check the merge at the
contents level.
