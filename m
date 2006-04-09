From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Sun, 09 Apr 2006 16:51:35 -0700
Message-ID: <7vy7ye9uk8.fsf@assigned-by-dhcp.cox.net>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604090950590.9504@g5.osdl.org>
	<7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
	<Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0604100000430.30000@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 01:51:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSjh7-0006Du-3P
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 01:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWDIXvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 19:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWDIXvk
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 19:51:40 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21907 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750747AbWDIXvj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 19:51:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060409235136.BIKQ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Apr 2006 19:51:36 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604100000430.30000@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 10 Apr 2006 00:01:40 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18572>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 9 Apr 2006, Johannes Schindelin wrote:
>
>> On Sun, 9 Apr 2006, Linus Torvalds wrote:
>> 
>> >  - keep it - for historical reasons - as a internal shorthand, and just 
>> >    turn it into "git log --diff -cc"
>> 
>> It is "git log --cc", right?
>
> Like this?

I do not think so.  You should default to --cc only there is no
explicit command line stuff from the user.
