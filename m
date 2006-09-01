From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: gitweb_check_feature always return list
Date: Fri, 01 Sep 2006 12:37:50 -0700
Message-ID: <7vk64n5qep.fsf@assigned-by-dhcp.cox.net>
References: <ed8a90$pfn$1@sea.gmane.org>
	<11571390683018-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 01 21:38:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJEq9-00037O-Ox
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 21:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbWIAThp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 15:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbWIAThp
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 15:37:45 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41675 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751731AbWIAThp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Sep 2006 15:37:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060901193744.RSJD20060.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 1 Sep 2006 15:37:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id H7df1V00W1kojtg0000000
	Fri, 01 Sep 2006 15:37:40 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <11571390683018-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Fri, 1 Sep 2006 21:31:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26307>

Jakub Narebski <jnareb@gmail.com> writes:

> Modified feature_blame so it returns one-element list and not scalar,
> thus making gitweb_check_feature always return list.  Updated comment
> to explain that part.

I do not understand what you are fixing.

	sub A { return (1); }
        sub B { return 1; }

Don't they quack the same way?
