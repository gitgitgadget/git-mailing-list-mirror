From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb.cgi in C
Date: Fri, 09 Dec 2005 09:59:38 -0800
Message-ID: <7vhd9i40dx.fsf@assigned-by-dhcp.cox.net>
References: <20051209152847.28358.qmail@web34310.mail.mud.yahoo.com>
	<86r78m8ea2.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 19:03:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkmXP-0008R1-C0
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 19:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVLIR7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 12:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVLIR7l
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 12:59:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40079 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751283AbVLIR7l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2005 12:59:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051209175814.NHFL26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Dec 2005 12:58:14 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz),
	Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <86r78m8ea2.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "09 Dec 2005 07:45:57 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13431>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Mark" == Mark Allen <mrallen1@yahoo.com> writes:

> Mark> I haven't looked at the libification work that Smurf is
> Mark> doing (haven't made time for it lately), but if it's not
> Mark> TOO python specific, maybe I can use it too.

> A "lite" version using Inline::C can be quickly constructed if
> only the API were all listed in one place, or a few easy to find places.

Guys, the "libificiation work" is more than that, and the more
important and bigger task is not the part you connect libgit to
your favorite P* languages, but first the part to reorganize
libgit to be usable in that form.

I've outlined what needs to be done a couple of months ago:

	http://marc.theaimsgroup.com/?t=112687447700001
