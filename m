From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitweb on kernel.org missing updates
Date: Sun, 11 Sep 2005 10:35:54 -0700
Message-ID: <7vpsrftslh.fsf@assigned-by-dhcp.cox.net>
References: <46a038f9050911000742b6b7cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 19:37:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEVkK-000689-3s
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 19:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVIKRgA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 13:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVIKRgA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 13:36:00 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62617 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964965AbVIKRf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 13:35:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911173555.CGFJ17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 13:35:55 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8304>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> I was under the impression that gitweb on kernel.org was reading from
> the same repos that are published via http/rsync. I've just now
> fetched a batch of updates via rsync that aren't visible on gitweb.
>
> Is something broken in kernel.org or should I blame my ISPs proxy?

I've seen the same last night and found out the two IP addresses
www.kernel.org eventurally resolves to have different copies
(one was up to date and the other was stale.)  I've notified the
kernel.org administrators.
