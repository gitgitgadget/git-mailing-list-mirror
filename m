From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/8] git-apply: work from subdirectory.
Date: Sat, 26 Nov 2005 10:54:19 -0800
Message-ID: <7vveyf1bqc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
	<7voe477n4i.fsf_-_@assigned-by-dhcp.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 19:54:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eg5Br-0006uu-DY
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 19:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVKZSyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 13:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVKZSyW
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 13:54:22 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40645 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750711AbVKZSyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 13:54:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126185350.FTBQ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 13:53:50 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511260932080.13959@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 26 Nov 2005 09:36:21 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12784>

Linus Torvalds <torvalds@osdl.org> writes:

> The only case where we care about a git directory is the "--index" case. 
> In all other cases we should happily apply it (or stat it).

True.  We should do the same as peek-remote.
