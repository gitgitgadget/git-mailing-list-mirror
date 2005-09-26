From: Junio C Hamano <junkio@cox.net>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 15:38:23 -0700
Message-ID: <7vy85j8nfk.fsf@assigned-by-dhcp.cox.net>
References: <20050925163201.GA29198@tumblerings.org>
	<4d4586301dca616f42880612fae01492@cream.org>
	<20050926133204.GB21019@pasky.or.cz>
	<Pine.LNX.4.58.0509260801430.3308@g5.osdl.org>
	<dh98gk$6rp$1@sea.gmane.org>
	<Pine.LNX.4.58.0509261038460.3308@g5.osdl.org>
	<Pine.LNX.4.63.0509261808530.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, walt <wa1ter@myrealbox.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 00:39:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK1cC-0003S3-FP
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 00:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVIZWi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 18:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVIZWi0
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 18:38:26 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14994 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932383AbVIZWiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 18:38:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926223823.CVNU29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 18:38:23 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509261808530.23242@iabervon.org> (Daniel
	Barkalow's message of "Mon, 26 Sep 2005 18:13:43 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9352>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I should actually implement that now that it's easy; you just skip the 
> "for_each_ref(mark_complete);" on line 217 of fetch.c, and it'll make sure 
> that it has everything.
>
> (I'll make a patch tonight if nobody beats me to it.)

Thanks.
