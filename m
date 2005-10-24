From: Junio C Hamano <junkio@cox.net>
Subject: Re: User-relative paths
Date: Sun, 23 Oct 2005 19:08:19 -0700
Message-ID: <7voe5fsm3w.fsf@assigned-by-dhcp.cox.net>
References: <435ABB99.5020908@op5.se>
	<7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se>
	<7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 04:08:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETrlA-0004c6-P4
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 04:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVJXCIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 22:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbVJXCIV
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 22:08:21 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:3070 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750918AbVJXCIV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 22:08:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024020743.ISVU2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Oct 2005 22:07:43 -0400
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 23 Oct 2005 12:56:11 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10525>

Junio C Hamano <junkio@cox.net> writes:

>  * In a URL, a colon after hostname means "port number
>    follows".  So it was a good intention to make these
>    consistent:
>
>         git fetch ssh://kernel.org:git
>         git fetch kernel.org:git
>
>    it should not be done.  IOW, if I wanted to use the former
>    form (which I do not think I'd use myself), I should say either one
>    of:
>
>         git fetch ssh://kernel.org:~/git
>         git fetch ssh://kernel.org:~junio/git
>
>    Oh, I just noticed you do not handle the former, because you
>    did not have to, but now you need to.

The "should be this way" examples should have been something
like this:

        git fetch ssh://kernel.org/~/git
        git fetch ssh://kernel.org/~junio/git

Otherwise what I said does not make *any* sense.

          	 Junio "Oh, I am an idiot" Hamano
