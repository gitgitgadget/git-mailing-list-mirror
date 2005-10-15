From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Some curl versions lack curl_easy_duphandle()
Date: Fri, 14 Oct 2005 22:49:37 -0700
Message-ID: <7vmzlbpbwu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510150038550.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Hengeveld <nickh@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 07:50:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQevU-00006Z-VM
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 07:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVJOFtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 01:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVJOFtl
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 01:49:41 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:30354 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751082AbVJOFtl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 01:49:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051015054926.ZOMN9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Oct 2005 01:49:26 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10128>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This patch looks bigger than it really is: The code to get the
> default handle was refactored into a function, and is called
> instead of curl_easy_duphandle() if that does not exist.

I'd like to take Nick's config file patch first, which
unfortunately interferes with your patch.  I'd hate to ask you
this, but could you rebase it on top of Nick's patch, and...

> Tested once.

maybe repost after some more testing?  And I'd like to ask
either Nick or Daniel to give an ack on the rebased one.
