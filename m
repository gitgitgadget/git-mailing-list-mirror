From: Junio C Hamano <junkio@cox.net>
Subject: Re: t6021-merge-criss-cross.sh fails on some systems
Date: Sun, 11 Dec 2005 00:07:38 -0800
Message-ID: <7v64pwoy45.fsf@assigned-by-dhcp.cox.net>
References: <20051210.144235.125914760.davem@davemloft.net>
	<20051211003353.GA27207@c165.ib.student.liu.se>
	<20051210.235818.90276521.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 09:07:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElMFD-0005DI-6W
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 09:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVLKIHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 03:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVLKIHk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 03:07:40 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:34964 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751338AbVLKIHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 03:07:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211080603.DBPV17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Dec 2005 03:06:03 -0500
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051210.235818.90276521.davem@davemloft.net> (David S. Miller's
	message of "Sat, 10 Dec 2005 23:58:18 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13488>

"David S. Miller" <davem@davemloft.net> writes:

> ... but a lot of us are doing:
>
> git pull && make && make test && make install

Fair enough.

Next such round would fail at "make test" stage with t0000;
otherwise please let me know
