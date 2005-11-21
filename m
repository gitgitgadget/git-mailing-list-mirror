From: Junio C Hamano <junkio@cox.net>
Subject: Re: auto-packing on kernel.org? please?
Date: Mon, 21 Nov 2005 13:35:37 -0800
Message-ID: <7vlkzhof9y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
	<20051121190151.GA2568@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
	<7v3blprcwk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511211211130.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 22:38:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJKR-0007jL-Dl
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVKUVfn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVKUVfm
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:35:42 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52945 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750895AbVKUVfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 16:35:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121213510.DGLZ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 16:35:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511211211130.13959@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 21 Nov 2005 12:38:31 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12488>

Linus Torvalds <torvalds@osdl.org> writes:

> ...just pipe stderr too. That, together with making git-pack-objects tell 
> what garbage it got, actually does the rigth thing:
>
> 	[torvalds@g5 git-clone]$ git repack -a -d
> 	fatal: expected sha1, got garbage:
> 	 error: Could not read 7f59dbbb8f8d479c1d31453eac06ec765436a780
>
> with this pretty simple patch.
>
> Whaddaya think?

Obviously the right thing to do ;-).  I like it.
