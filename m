From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Initial AIX portability fixes.
Date: Tue, 06 Dec 2005 16:12:52 -0800
Message-ID: <7vvey1zrwb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512070055430.5888@wbgn013.biozentrum.uni-wuerzburg.de>
	<21075.1133914036@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 01:13:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjmvZ-0008Bu-3m
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 01:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbVLGAMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 19:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbVLGAMy
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 19:12:54 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:29338 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932668AbVLGAMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 19:12:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207001123.OBWG17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 19:11:23 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <21075.1133914036@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Tue, 06 Dec 2005 16:07:16 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13308>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> And Johannes Schindelin writes:
>  - Why not enclose the #define in #ifndef/#endif, and do the real magic in 
>  - the Makefile? Within the AIX clause:
>  - 	ALL_CFLAGS += -D_XOPEN_SOURCE=500 -XOPEN_SOURCE_EXTENDED=1
>
> Because other files do _not_ compile when given those options.
> I'm going for minimal changes to the existing structure; the
> #define for glibc2 has been there a long, long time.  Yes, it
> probably can be done better, but these are 1.0rc versions...

I agree with your approach of least impact for now.  Thanks.
