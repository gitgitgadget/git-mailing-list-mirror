From: Junio C Hamano <junkio@cox.net>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 09:49:49 -0700
Message-ID: <7vd5n5q9xu.fsf@assigned-by-dhcp.cox.net>
References: <20050919134838.GC2903@pasky.or.cz>
	<7vll1trqiq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509190924280.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 18:53:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHOrY-00073b-AY
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 18:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVISQuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 12:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVISQuR
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 12:50:17 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42942 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932495AbVISQuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 12:50:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919164948.QVGX25410.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 12:49:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509190924280.9106@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 19 Sep 2005 09:32:38 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8887>

Linus Torvalds <torvalds@osdl.org> writes:

> The Perl User::pwent module seems to agree, btw (also about '&'):
>
>    "Interpretation of the gecos field varies between systems, but
>     traditionally holds 4 comma-separated fields containing the user's
>     full name, office location, work phone number, and home phone number.  
>
>     An & in the gecos field should be replaced by the user's properly
>     capitalized login name."

I vaguelly recall seeing that & somewhere and wondering what
they do with mcdonalds ;-)

> I still worry about names of the type "Torvalds, Linus", but maybe that's 
> just not an issue.

Does not appear to be.  So I'd vote for us doing the "cut at
first comma, substitute & with toupper(login[0])+login[1..]".
