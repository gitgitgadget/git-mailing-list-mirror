From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Thu, 01 Dec 2005 02:14:19 -0800
Message-ID: <7vd5khjf9g.fsf@assigned-by-dhcp.cox.net>
References: <20051128234256.1508.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Dec 01 11:18:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhlUQ-0007pv-Q6
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 11:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVLAKOs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 05:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVLAKOk
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 05:14:40 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39846 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932112AbVLAKOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 05:14:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201101249.UJVV17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 05:12:49 -0500
To: linux@horizon.com
In-Reply-To: <20051128234256.1508.qmail@science.horizon.com>
	(linux@horizon.com's message of "28 Nov 2005 18:42:56 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13048>

linux@horizon.com writes:

> Anyway, if it's portable enough, it's faster.  Ah... I just found discussion
> of this in late September, but it's not clear what the resolution was.
> http://marc.theaimsgroup.com/?t=112746188000003

Although updating our shell scripts to this century is lower on
my priority scale, ideally I'd want to see things work with
dash, not because I do not like bash/ksh, but because it seems
the smallest minimally POSIXy shell.

Speaking of shell gotchas, I do not know what the resolution was
on the problem Merlyn was having the other day in "lost again on
syntax change - local repository?" thread, which seemed that the
failure described in <868xv86dam.fsf@blue.stonehenge.com> was
his bash mishandling an if..then..elif..else..fi chain, which
was sort of unexpected for me.  I was curious but do not
remember seeing the conclusion.  Pasky, what happened to that
thread?
