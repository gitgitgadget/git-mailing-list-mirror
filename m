From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 09:05:57 -0800
Message-ID: <7v8xvpn8ne.fsf@assigned-by-dhcp.cox.net>
References: <1132034390.22207.18.camel@dv>
	<7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
	<1132042427.3512.50.camel@dv>
	<7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
	<7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051115121854.GV30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 18:10:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec4GD-0006RT-KH
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 18:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVKORGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 12:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVKORGA
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 12:06:00 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25804 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964937AbVKORF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 12:05:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115170533.LNTC15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 12:05:33 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051115121854.GV30496@pasky.or.cz> (Petr Baudis's message of
	"Tue, 15 Nov 2005 13:18:54 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11918>

Petr Baudis <pasky@suse.cz> writes:

> Yes, I would very much like to have this. I still want to go
> symrefs-only for public repositories created for cg-admin-setuprepo, so
> that fetching over HTTP works properly.

Sorry, I must have missed that part.  How does fetch-over-HTTP
break with symlinked HEAD?
