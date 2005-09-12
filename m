From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] Merge driver
Date: Mon, 12 Sep 2005 14:16:48 -0700
Message-ID: <7vmzmi9ebj.fsf@assigned-by-dhcp.cox.net>
References: <7v1x407min.fsf@assigned-by-dhcp.cox.net>
	<431F34FF.5050301@citi.umich.edu>
	<7vvf1cz64l.fsf@assigned-by-dhcp.cox.net>
	<4320536D.2010706@citi.umich.edu>
	<7v7jdrwlih.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
	<43207FE6.2030108@citi.umich.edu>
	<Pine.LNX.4.58.0509081131070.5940@g5.osdl.org>
	<432089D8.4060507@citi.umich.edu>
	<7v3boen0rb.fsf_-_@assigned-by-dhcp.cox.net>
	<20050912210813.GA6644@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, cel@citi.umich.edu,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 23:18:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEvfa-0000zA-4r
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 23:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVILVQv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 17:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVILVQv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 17:16:51 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15817 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932250AbVILVQu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 17:16:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912211650.KKFO20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 17:16:50 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050912210813.GA6644@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Mon, 12 Sep 2005 23:08:13 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8430>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> git-read-tree A
> git-update-cache --refresh
> git-read-tree -u -m T A B
>
> We need the second step because otherwise git-read-tree will complain
> that the cache isn't uptodate. But we _know_ that the contents are
> uptodate, so the second step is unnecessary and just eats time.

If we _know_ it should match, isn't there a way to tell the
first "git-read-tree A" not to mess with the dirtiness, like,
ah, one-way merge?
