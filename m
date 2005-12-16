From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] faking cvs annotate
Date: Thu, 15 Dec 2005 17:42:16 -0800
Message-ID: <7vpsnxlsw7.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90512151713i118e58acia466d0f65ff91383@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 02:43:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En4c1-0004YR-8T
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 02:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVLPBmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 20:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVLPBmS
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 20:42:18 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:25576 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751273AbVLPBmS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 20:42:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051216014053.CSPL17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 20:40:53 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90512151713i118e58acia466d0f65ff91383@mail.gmail.com>
	(Martin Langhoff's message of "Fri, 16 Dec 2005 14:13:16 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13727>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Suggestions of GIT machinery that would shortcut the trip from
>
>      git-rev-list HEAD $path
>
> to a annotate-ish output. Did I dream it or is qgit showing something
> annotate-ish in its screenshots?

I haven't actively done anything but one of the good things that
could happen is to split out the access routines for annotate
database qgit build when run the first time in the repository,
and make them available to other Porcelains.  There is no need
to reinvent the wheel.
