From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 09:44:43 -0800
Message-ID: <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
	<43737EC7.6090109@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 18:47:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaGTi-0004zm-9A
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 18:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVKJRoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 12:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVKJRoq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 12:44:46 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:43660 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751131AbVKJRop (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 12:44:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110174422.CXRD1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 12:44:22 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43737EC7.6090109@zytor.com> (H. Peter Anvin's message of "Thu,
	10 Nov 2005 09:09:27 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11494>

"H. Peter Anvin" <hpa@zytor.com> writes:

> May I *STRONGLY* urge you to name that something different. 
> "lost+found" is a name with special properties in Unix; for example, 
> many backup solutions will ignore a directory with that name.

Yeah, the original proposal (in TODO list) explicitly stated why
I chose lost-found instead of lost+found back then, and somebody
on the list (could have been Pasky but I may be mistaken) said
not to worry.  In any case, if we go the route Daniel suggests,
we would not be storing anything on the filesystem ourselves so
this would be a non-issue.
