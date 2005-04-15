From: Junio C Hamano <junkio@cox.net>
Subject: Re: ls-tree enhancements
Date: Fri, 15 Apr 2005 11:25:54 -0700
Message-ID: <7v64ynj3rh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	<7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	<7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
	<7vzmw0ok45.fsf_-_@assigned-by-dhcp.cox.net>
	<20050415161330.GH19078@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 20:26:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMVVg-0005Cs-Ji
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 20:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVDOS0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 14:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVDOS0q
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 14:26:46 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:12163 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261910AbVDOSZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 14:25:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415182555.WIVD19936.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 14:25:55 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050415161330.GH19078@pasky.ji.cz> (Petr Baudis's message of
 "Fri, 15 Apr 2005 18:13:30 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

>> +static void _usage(void)

PB>  This infriges the system namespaces. FWIW, I prefer to add the
PB> underscore at the end of the identifier if wanting to do stuff like
PB> this. Or just call it my_usage().

Thanks.  My bad.  Noted.


