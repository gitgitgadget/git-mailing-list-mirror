From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs
Date: Sat, 07 Oct 2006 01:40:47 -0700
Message-ID: <7vbqoowmb4.fsf@assigned-by-dhcp.cox.net>
References: <20060929221641.GC2871@admingilde.org>
	<7v8xk2jofc.fsf@assigned-by-dhcp.cox.net>
	<20061006152925.GP20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 10:40:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW7jo-0000jE-51
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 10:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWJGIkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 04:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWJGIkt
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 04:40:49 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:20944 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751766AbWJGIks (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 04:40:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007084048.QOC13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 04:40:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XLgq1V00G1kojtg0000000
	Sat, 07 Oct 2006 04:40:51 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061006152925.GP20017@pasky.or.cz> (Petr Baudis's message of
	"Fri, 6 Oct 2006 17:30:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28459>

Petr Baudis <pasky@suse.cz> writes:

> BTW, couple of notes for people who will want to try it: if gitweb.cgi
> serves as your indexfile, this will break; you need to override $my_uri
> in gitweb_config. Also, you need to change the default location of CSS,
> favicon and logo to an absolute URL.

A patch to gitweb/README is in order perhaps?
