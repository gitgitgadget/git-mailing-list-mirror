From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-bisect failure
Date: Sat, 10 Sep 2005 14:40:44 -0700
Message-ID: <7vfyscfvoj.fsf@assigned-by-dhcp.cox.net>
References: <20050909011034.12f2bf64.akpm@osdl.org>
	<7virx9ir3a.fsf@assigned-by-dhcp.cox.net>
	<20050910022638.20832803.akpm@osdl.org>
	<Pine.LNX.4.58.0509101202070.30958@g5.osdl.org>
	<20050910141343.578649c7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 23:41:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EED64-0003tH-Ag
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 23:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVIJVkr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVIJVkr
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 17:40:47 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52719 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932327AbVIJVkq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2005 17:40:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050910214044.IRWB6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Sep 2005 17:40:44 -0400
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050910141343.578649c7.akpm@osdl.org> (Andrew Morton's message
	of "Sat, 10 Sep 2005 14:13:43 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8263>

Andrew Morton <akpm@osdl.org> writes:

>>  So the bisection algorithm may have done the right thing from a technical 
>>  standpoint, but I suspect it could be made to be a bit more forgiving, or 
>>  at least when somebody realizes that bisection didn't work right, we could 
>>  have the trail of good/bad markings to try to debug what happened...
>
> Yup.  Simply keeping a little log file would suffice.

Will do.  Thanks.
