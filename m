From: Junio C Hamano <junkio@cox.net>
Subject: Re: the war on trailing whitespace
Date: Sun, 26 Feb 2006 12:29:13 -0800
Message-ID: <7vhd6l6ezq.fsf@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 21:29:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDSW8-0003ic-3k
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 21:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWBZU3R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 15:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWBZU3R
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 15:29:17 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:22979 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751144AbWBZU3R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 15:29:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060226202620.FQTJ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Feb 2006 15:26:20 -0500
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060226103604.2d97696c.akpm@osdl.org> (Andrew Morton's message
	of "Sun, 26 Feb 2006 10:36:04 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16794>

Andrew Morton <akpm@osdl.org> writes:

> Thanks.  But it defaults to nowarn.  Nobody will turn it on and nothing
> improves.

This WS is clearly a policy, and while I personally agree that
it is a _good_ policy, I am a bit hesitant to hardcode this
stricter policy as the default to lower level tools.

I have a feeling that Linus is saying that pre-applypatch hook
is good enough, and you have to educate people who feed things
to you ;-)
