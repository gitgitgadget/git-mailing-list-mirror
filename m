From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sun, 10 Jul 2005 00:15:48 -0700
Message-ID: <7v4qb3uo63.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<12c511ca05070716526954edd@mail.gmail.com>
	<Pine.LNX.4.58.0507071658460.25104@g5.osdl.org>
	<12c511ca050707170964a2cc92@mail.gmail.com>
	<Pine.LNX.4.58.0507071720330.25104@g5.osdl.org>
	<20050709225818.A31045@flint.arm.linux.org.uk>
	<20050709232955.B31045@flint.arm.linux.org.uk>
	<7vpstrv8z6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507092158290.17536@g5.osdl.org>
	<Pine.LNX.4.58.0507092211470.17536@g5.osdl.org>
	<20050710075548.A11765@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Tony Luck <tony.luck@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 09:16:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrW2q-0003ge-6d
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 09:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVGJHPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 03:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVGJHPw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 03:15:52 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61176 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261864AbVGJHPu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 03:15:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050710071548.FWWY8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 10 Jul 2005 03:15:48 -0400
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050710075548.A11765@flint.arm.linux.org.uk> (Russell King's message of "Sun, 10 Jul 2005 07:55:48 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "RK" == Russell King <rmk@arm.linux.org.uk> writes:

RK> I would if I could, but my workflow involves having an untouched local
RK> copy of your tree and several trees for each area.

RK> This involves updates using relative paths, and as has already been
RK> found elsewhere, this (with cogito 0.12) doesn't work with packed
RK> objects yet.

As a workaround until Cogito gets updated, would it help to have
the environment variable GIT_ALTERNATE_OBJECT_DIRECTORIES
pointing at the untouched copy of Linus tree's .git/objects/
directory?  All your other trees would find the objects in your
copied-Linus tree (including packed one) available to them
already and hopefully pull breakage does not even have to touch
those objects.
