From: Junio C Hamano <junkio@cox.net>
Subject: Re: Three-way merge with the index as one way
Date: Fri, 04 Nov 2005 11:05:43 -0800
Message-ID: <7vslucutbs.fsf@assigned-by-dhcp.cox.net>
References: <20051015174103.GA2609@tumblerings.org>
	<7vu0fimzhn.fsf@assigned-by-dhcp.cox.net>
	<20051015192720.GA11364@tumblerings.org>
	<7v8xwummtm.fsf@assigned-by-dhcp.cox.net>
	<20051103003423.GH1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 20:08:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY6sm-0004tI-5X
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 20:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVKDTFp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 14:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVKDTFp
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 14:05:45 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:65160 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750834AbVKDTFo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 14:05:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104190459.YUIG776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 14:04:59 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051103003423.GH1431@pasky.or.cz> (Petr Baudis's message of
	"Thu, 3 Nov 2005 01:34:23 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11153>

Petr Baudis <pasky@suse.cz> writes:

> I wanted to make tree_timewarp do three-way merge, but didn't figure a
> good way to do it. First, what do I want - a two-way merge between two
> trees, which will however respect (not die on) local changes in the
> working tree.

I remember that we used to have --emu23 flag to read-tree.  It
was yanked out when we did multi-merge-base conversion, because
nobody was using it, but I wonder if that is close to what you
are looking for.

$ git whatchanged -S--emu23 read-tree.c

tells me that 32192e6622d78347448cfc0572827d6e64e0de28 commit
completed it and ee6566e8d70da682ac4926dd8a67ac821b2c1743 commit
removed it.
