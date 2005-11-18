From: Junio C Hamano <junkio@cox.net>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 09:16:23 -0800
Message-ID: <7vwtj5lvvc.fsf@assigned-by-dhcp.cox.net>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
	<7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net>
	<20051118075117.GK31613@kiste.smurf.noris.de>
	<7vbr0imlha.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511180812200.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 18:55:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdAS7-0008ME-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 18:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbVKRRQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 12:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVKRRQ0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 12:16:26 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37007 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030210AbVKRRQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 12:16:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118171559.QGEM3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 12:15:59 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511180812200.13959@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 18 Nov 2005 08:14:01 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12243>

Linus Torvalds <torvalds@osdl.org> writes:

> Umm.. Why not just say "if the line after the 'diff' line doesn't start 
> with '@@ ', then it's a binary diff"?

Thanks, that makes sense.
