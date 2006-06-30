From: Pavel Roskin <proski@gnu.org>
Subject: Re: Git.xs merge status
Date: Fri, 30 Jun 2006 03:28:12 -0400
Message-ID: <20060630032812.zg9vgkksg08kkkk4@webmail.spamcop.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	<7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<7vmzbvmny4.fsf_-_@assigned-by-dhcp.cox.net> <1151644101.10496.22.camel@dv>
	<7vlkrfkt6q.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, hpa@kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 09:28:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwDQM-00041r-Ck
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 09:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWF3H2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 03:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWF3H2P
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 03:28:15 -0400
Received: from mailgate.cesmail.net ([216.154.195.36]:19075 "HELO
	mailgate.cesmail.net") by vger.kernel.org with SMTP
	id S1751227AbWF3H2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 03:28:14 -0400
Received: (qmail 17473 invoked from network); 30 Jun 2006 07:28:12 -0000
Received: from unknown (HELO delta.cesmail.net) (192.168.1.30)
  by mailgate.cesmail.net with SMTP; 30 Jun 2006 07:28:12 -0000
Received: (qmail 28711 invoked by uid 99); 30 Jun 2006 07:28:12 -0000
Received: from pool-68-163-63-69.phil.east.verizon.net
	(pool-68-163-63-69.phil.east.verizon.net [68.163.63.69]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Fri, 30 Jun 2006 03:28:12 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkrfkt6q.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22964>

Quoting Junio C Hamano <junkio@cox.net>:

> The kernel.org machine I am using for testing does not seem to
> have perl-Error installed, and I suspect Pasky arranged to ship
> our own Error.pm for people building git from source because the
> package is not so widely installed.  I guess I should ask the
> admins there before I can build perl-Git RPMs for release.

It's better than to have conflicting packages (perl-Git and perl-Error).  The
build requirement can be relaxed if needed (either by finding and removing
Error* after the install or by adding another flag to Makefile.PL), but I think
it's logical to have it because perl-Error would be needed by git-core anyway.

Another solution would be to arrange Error.pm to be installed and used as
Git::Error, but that would be a case of code duplication.

--
Regards,
Pavel Roskin
