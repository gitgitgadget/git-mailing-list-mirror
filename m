From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH 3] Copy description of build configuration variables to configure.ac
Date: Sun, 09 Jul 2006 13:43:18 -0700
Message-ID: <7vwtamecgp.fsf@assigned-by-dhcp.cox.net>
References: <200607030156.50455.jnareb@gmail.com>
	<1152392835436-git-send-email-jnareb@gmail.com>
	<11523928361444-git-send-email-jnareb@gmail.com>
	<7virm7nq7h.fsf@assigned-by-dhcp.cox.net> <e8rbuk$je5$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Sun Jul 09 22:43:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzg7k-0006l1-UY
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 22:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWGIUnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 16:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbWGIUnZ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 16:43:25 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:6854 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161134AbWGIUnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 16:43:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060709204324.YMNF985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Jul 2006 16:43:24 -0400
To: git@vger.kernel.org
In-Reply-To: <e8rbuk$je5$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	09 Jul 2006 18:47:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23563>

Jakub Narebski <jnareb@gmail.com> writes:

>> [...] I think you are better off making a list of
>> supported and yet to be supported ones in the comment in
>> configure.ac, and when you want to see if the list got stale
>> over time, grep for '^# Define' from the Makefile and match them
>> up.
>
> This is kind of such a list. Also let me point out that this was in _first_
> patch of the series, as a kind of TODO list.

Yes, you are right -- I spoke too early without realizing what
was going on.  The others build on this TODO list to fill the
gap rather nicely.
