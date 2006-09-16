From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: export-ok option
Date: Sat, 16 Sep 2006 13:37:51 -0700
Message-ID: <7vy7sj8s4g.fsf@assigned-by-dhcp.cox.net>
References: <20060916192750.GA27008@moooo.ath.cx> <eehjtn$ipm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 22:38:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOgvG-0003OL-Kn
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 22:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWIPUhx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWIPUhx
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 16:37:53 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:18336 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751496AbWIPUhw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 16:37:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060916203752.KWTJ12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Sep 2006 16:37:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id P8dt1V0081kojtg0000000
	Sat, 16 Sep 2006 16:37:53 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eehjtn$ipm$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	16 Sep 2006 21:40:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27132>

Jakub Narebski <jnareb@gmail.com> writes:

> Matthias Lederhofer wrote:
>
>> Perhaps there should be another option which allows only those
>> repositories to be shown which are in $projects_list.
>
> If $projects_list is a file (and not directory), only repositories
> specified there are shown.

If you can _guess_ project's name, you can go directly to
git_summary with it, and the page (or links that the page leads
to) does not check $projects_list at all, no?

I think Matthias's patch addresses that issue.
