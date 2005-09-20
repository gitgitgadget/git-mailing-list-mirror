From: Junio C Hamano <junkio@cox.net>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 23:30:18 -0700
Message-ID: <7vzmq86ykl.fsf@assigned-by-dhcp.cox.net>
References: <20050919134838.GC2903@pasky.or.cz>
	<7vll1trqiq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509190924280.9106@g5.osdl.org>
	<7vd5n5q9xu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 08:30:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHbe4-0006l1-Oy
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 08:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbVITGaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 02:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbVITGaW
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 02:30:22 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:11663 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932738AbVITGaV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 02:30:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920063019.CEKD18416.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Sep 2005 02:30:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vd5n5q9xu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 19 Sep 2005 09:49:49 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8982>

Junio C Hamano <junkio@cox.net> writes:

> Does not appear to be.  So I'd vote for us doing the "cut at
> first comma, substitute & with toupper(login[0])+login[1..]".

I've done this in the proposed updates branch.
