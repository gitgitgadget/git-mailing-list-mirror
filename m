From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Stash away the original head in ORIG_HEAD when resetting.
Date: Mon, 08 Aug 2005 19:48:13 -0700
Message-ID: <7v7jevzuz6.fsf@assigned-by-dhcp.cox.net>
References: <7vy87dgdxb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508081111020.26210@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Aug 09 04:48:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2KA7-0006r4-4U
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 04:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVHICsP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 22:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVHICsP
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 22:48:15 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48087 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932417AbVHICsP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 22:48:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050809024814.TJUA1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 22:48:14 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Since there are not many users of git-commit's *-m* flag right now: Is it 
> necessary to confuse CVS people, who expect to be able to write
>
> 	git commit -m "I did this and that"
>
> I do not want to be too intrusive, but I think up to now there is just the 
> mailbox tools which use this feature, and users of git-reset. Thoughts?

I could be talked into renaming the option to something else and
using -m in a way that is CVS compatible.

That flag originally came from JIT, which uses:

  -M <commit>	literally take the commit message, no editing necessary;
  -m <commit>	start with commit message in this one but have user edit;

  -l <file>	use the log message in this file;
  -l -		read the log message from stdin.
