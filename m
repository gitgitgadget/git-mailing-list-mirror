From: Junio C Hamano <junkio@cox.net>
Subject: Annotate another problem report
Date: Mon, 07 Aug 2006 13:00:34 -0700
Message-ID: <7vpsfc1fkt.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060807115000.GC15477@h4x0r5.com>
	<1154952684908-git-send-email-ryan@michonline.com>
	<11549526841904-git-send-email-ryan@michonline.com>
	<7virl42w6s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 22:01:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GABHl-0005LJ-Jb
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 22:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWHGUAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 16:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWHGUAi
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 16:00:38 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38121 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932339AbWHGUAg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 16:00:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807200035.NQYE6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 16:00:35 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <7virl42w6s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 07 Aug 2006 12:16:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25037>

"git annotate Makefile v1.4.0" outputs this:

...
58e60dd2	(Nick Hengeveld	2005-11-02 11:19:24 -0800	13)# git.......
58e60dd2	(Nick Hengeveld	2005-11-02 11:19:24 -0800	14)# tra.......
	(          	1970-01-01 00:00:00 	15)#
6d9bbc50	(Patrick Mauritz	2005-09-19 16:11:19 +0200	16)# ..
6d9bbc50	(Patrick Mauritz	2005-09-19 16:11:19 +0200	17)# ..
...

There are a handful lines it couldn't tell where they came from:

	(          	1970-01-01 00:00:00 	15)#
	(          	1970-01-01 00:00:00 	179)
	(          	1970-01-01 00:00:00 	182)
	(          	1970-01-01 00:00:00 	274)endif
	(          	1970-01-01 00:00:00 	323)
	(          	1970-01-01 00:00:00 	384)else
	(          	1970-01-01 00:00:00 	385)	LIB_4_ICONV =
