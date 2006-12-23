From: Junio C Hamano <junkio@cox.net>
Subject: Re: author/commit counts
Date: Fri, 22 Dec 2006 20:43:54 -0800
Message-ID: <7vfyb7usqd.fsf@assigned-by-dhcp.cox.net>
References: <20061222181030.d733deb3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 05:44:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxyjt-0000mi-8l
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 05:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbWLWEn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 23:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbWLWEn4
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 23:43:56 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:35487 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbWLWEnz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 23:43:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061223044355.JDTR25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 23:43:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 24jB1W00K1kojtg0000000; Fri, 22 Dec 2006 23:43:12 -0500
To: Randy Dunlap <rdunlap@xenotime.net>
In-Reply-To: <20061222181030.d733deb3.rdunlap@xenotime.net> (Randy Dunlap's
	message of "Fri, 22 Dec 2006 18:10:30 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35261>

Randy Dunlap <rdunlap@xenotime.net> writes:

> Is this useful?  or it needs fixing?
> or you already have better solutions?
>
> example:
> git log v2.6.19.. | authorcount -m | less

Perhaps you are talking about this command?

$ git shortlog -n -s v2.6.19..
