From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-update-cache: allow dot-files
Date: Thu, 26 May 2005 02:02:54 -0700
Message-ID: <7vd5ree4w1.fsf@assigned-by-dhcp.cox.net>
References: <7vhdgstb7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241723060.2307@ppc970.osdl.org>
	<7v8y24taai.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241748520.2307@ppc970.osdl.org>
	<7v3bscrtwx.fsf@assigned-by-dhcp.cox.net>
	<20050526083745.GD22262@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 11:02:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbEFH-0006Xc-9e
	for gcvg-git@gmane.org; Thu, 26 May 2005 11:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVEZJDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 05:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVEZJDJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 05:03:09 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39327 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261295AbVEZJC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 05:02:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526090254.WJMN20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 05:02:54 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050526083745.GD22262@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 26 May 2005 10:37:45 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> That doesn't make any sense. When I'm working on kernel.org, why
PB> would you prohibit me to set GIT_DIR to /pub/scm/cogito/cogito.git ?

What you say makes perfect sense, but avoiding hardcoded ".git/"
does not make any sense either in that situation.  

Alternative suggestions welcome.

