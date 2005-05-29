From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] cg-log: make -r id:id show the given id instead of nothing
Date: Sun, 29 May 2005 14:19:10 +0200
Message-ID: <20050529121910.GG1036@pasky.ji.cz>
References: <20050520150400.GC27395@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 14:17:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcMj4-0006wv-Hi
	for gcvg-git@gmane.org; Sun, 29 May 2005 14:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVE2MTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 08:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVE2MTO
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 08:19:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28393 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261213AbVE2MTM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 08:19:12 -0400
Received: (qmail 21301 invoked by uid 2001); 29 May 2005 12:19:10 -0000
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20050520150400.GC27395@diku.dk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, May 20, 2005 at 05:04:00PM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> If cg-log is passed -r cogito-0.10 -r cogito-0.10 no log entries are
> shown. This patch make it show the log for the given ID.
> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

I don't like such a special case a lot. If you just want to make it
possible to show up just a single revision by cg-log, what about -R or
something, so that you don't need to write it twice?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
