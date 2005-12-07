From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Use printf rather than echo -n.
Date: Tue, 06 Dec 2005 19:31:43 -0800
Message-ID: <21616.1133926303@lotus.CS.Berkeley.EDU>
References: <7vfyp5zmqe.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 04:33:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejq2Z-0007w6-51
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 04:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbVLGDcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 22:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbVLGDcF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 22:32:05 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:65433 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1030320AbVLGDcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 22:32:04 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id jB73Vh6d021618;
	Tue, 6 Dec 2005 19:31:43 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id jB73VhWM021617;
	Tue, 6 Dec 2005 19:31:43 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7vfyp5zmqe.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13318>

And Junio C Hamano writes:
 - Perhaps printf '%s' "$blah" to futureproof, instead of just
 - saying printf "$blah"?

Definitely more likely to stay correct.  I'm just lazy.

 - <rant mode on>
 - While I do not have anything aginst system without "sane" echo,
 - I really do not like it.  Not your solution, but *having to do*
 - something like that.

Um, you think the wrong one is sane.  ;)  Why should echo 
in Bourne shell take C-shell arguments?  (I blame AT&T for
their crappy licensing.)

Jason
