From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 18:13:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509261808530.23242@iabervon.org>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org>
 <20050926133204.GB21019@pasky.or.cz> <Pine.LNX.4.58.0509260801430.3308@g5.osdl.org>
 <dh98gk$6rp$1@sea.gmane.org> <Pine.LNX.4.58.0509261038460.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Sep 27 00:10:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK1AN-0002xb-NN
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 00:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVIZWJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 18:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVIZWJP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 18:09:15 -0400
Received: from iabervon.org ([66.92.72.58]:20498 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932349AbVIZWJO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 18:09:14 -0400
Received: (qmail 2694 invoked by uid 1000); 26 Sep 2005 18:13:43 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Sep 2005 18:13:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509261038460.3308@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9344>

On Mon, 26 Sep 2005, Linus Torvalds wrote:

> A "git-http-fetch --recover HEAD <url>" _should_ fix it, but I don't think 
> that works right now. It's documented, but it doesn't do anything. Junio?

I should actually implement that now that it's easy; you just skip the 
"for_each_ref(mark_complete);" on line 217 of fetch.c, and it'll make sure 
that it has everything.

(I'll make a patch tonight if nobody beats me to it.)

	-Daniel
*This .sig left intentionally blank*
