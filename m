From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-config-set: add more options
Date: Sat, 19 Nov 2005 23:13:25 -0800
Message-ID: <7vr79b3i7e.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511200650130.12832@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 08:13:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdjOE-00066X-Jk
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 08:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVKTHN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 02:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVKTHN1
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 02:13:27 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30693 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751060AbVKTHN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 02:13:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051120071258.YDDK15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 20 Nov 2005 02:12:58 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511200650130.12832@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 20 Nov 2005 06:52:22 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12372>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	The only thing I am concerned about now is how to deal with
> 	anti value_regex's, i.e.
>...
> 	Note: we could adjust the pattern syntax so that a prefix "!"
> 	means "no match", and "\!" means "match literal !", but this
> 	is ugly.

I do not think it is so bad, except that I would not even bother
doing the quoting of prefix '!'; the user can always say '[!]'
to mean a positive match that begins with an exclamation point.
