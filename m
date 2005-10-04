From: Junio C Hamano <junkio@cox.net>
Subject: cvsimport using proxy?
Date: Tue, 04 Oct 2005 14:42:34 -0700
Message-ID: <7v4q7xc62d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 23:43:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMuYg-00025O-KW
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 23:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVJDVmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVJDVmn
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 17:42:43 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53647 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964990AbVJDVmn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 17:42:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051004214226.FBID29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Oct 2005 17:42:26 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>,
	Martin Langhoff <martin@ng.eduforge.org>,
	Sven Verdoolaege <skimo@kotnet.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9689>

I was going to try cvsimport over the firewall --

CVSROOT=':pserver;proxy=firewall;proxyport=3128:anoncvs@anoncvs.postgresql.org:/projects/cvsroot' cvs co -c

works fine, but it does not appear to me that cvsimport knows
about the proxied connection.  Is anybody savvy and helpful
enough to look into adding this?
