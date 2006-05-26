From: Junio C Hamano <junkio@cox.net>
Subject: Re: ~/.git/config ?
Date: Fri, 26 May 2006 10:38:51 -0700
Message-ID: <7vversk7o4.fsf@assigned-by-dhcp.cox.net>
References: <20060526152837.GQ23852@progsoc.uts.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 19:39:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjgH9-0000Rm-Gy
	for gcvg-git@gmane.org; Fri, 26 May 2006 19:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWEZRiy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 13:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWEZRiy
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 13:38:54 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29604 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751193AbWEZRix (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 13:38:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060526173852.GQIA24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 May 2006 13:38:52 -0400
To: Anand Kumria <wildfire@progsoc.uts.edu.au>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20824>

Anand Kumria <wildfire@progsoc.uts.edu.au> writes:

> It would be good if things were like:
> 	- try to construct one automagically
> 	- use ~/.git/config (if available)
> 	- use .git/config
> 	- use environment variables
>
> That way I could set my default email address in ~/.git/config and
> override it as required for those repositories that need it.

If you mean by the above "do all of these and take the last
value that was available", that sounds sane.  Except perhaps I
would suggest to use ~/.git-config instead.  Some people seem to
want to track their home directory with git, and that way, your
personal fallback default file can be version controlled.
