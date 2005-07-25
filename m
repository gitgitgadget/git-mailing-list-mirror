From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] debian/ binary package dependency fix. [u]
Date: Mon, 25 Jul 2005 09:27:09 -0700
Message-ID: <7vek9mrgv6.fsf@assigned-by-dhcp.cox.net>
References: <7vackbz9g5.fsf@assigned-by-dhcp.cox.net>
	<200507251052.37618.aj@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 18:28:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dx5nt-0003YP-LI
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 18:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVGYQ1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 12:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVGYQ1R
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 12:27:17 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:27529 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261345AbVGYQ1M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 12:27:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050725162707.HEMJ1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 12:27:07 -0400
To: "Andreas Jellinghaus [c]" <aj@dungeon.inka.de>
In-Reply-To: <200507251052.37618.aj@dungeon.inka.de> (Andreas Jellinghaus's message of "Mon, 25 Jul 2005 10:52:37 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"Andreas Jellinghaus [c]" <aj@dungeon.inka.de> writes:

> rsync should be Recommended: or Suggested: only,
> as git can be used local only as well, and then
> rsync is not needed, right?

I suspect we still use rsync even in some local cases (rsync
between two local directories).  At least we once used to and I
do not remeber touching that piece of code..
