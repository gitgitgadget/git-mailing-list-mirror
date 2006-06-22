From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually used.
Date: Thu, 22 Jun 2006 11:58:31 -0700
Message-ID: <7vlkrpkofc.fsf@assigned-by-dhcp.cox.net>
References: <0J1800MC1NKJD2C0@mxout2.netvision.net.il>
	<7vwtb9veqv.fsf@assigned-by-dhcp.cox.net>
	<20060622131235.GA21864@pasky.or.cz>
	<7vodwlp12i.fsf@assigned-by-dhcp.cox.net>
	<20060622175815.GC21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 20:59:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtUO5-0004PJ-Am
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 20:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWFVS6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 14:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161199AbWFVS6e
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 14:58:34 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:12167 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1161196AbWFVS6d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 14:58:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622185832.VYAV18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 14:58:32 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22357>

Petr Baudis <pasky@suse.cz> writes:

> ... while the Git.pm module should be available systemwide even
> for non-Git applications, so it's really best to leave it to Perl where
> to put it.

OK, if that is the intention passing prefix might be sensible.
