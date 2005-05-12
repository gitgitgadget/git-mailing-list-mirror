From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Thu, 12 May 2005 20:23:41 +0200
Message-ID: <20050512182340.GA324@pasky.ji.cz>
References: <20050512094406.GZ5914@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262110AbVELSYj@vger.kernel.org Thu May 12 20:21:47 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262110AbVELSYj@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWIIo-0001m9-7F
	for glk-linux-kernel@gmane.org; Thu, 12 May 2005 20:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVELSYj (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Thu, 12 May 2005 14:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVELSYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:24:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65239 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262102AbVELSXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:23:43 -0400
Received: (qmail 1017 invoked by uid 2001); 12 May 2005 18:23:41 -0000
To: Matt Mackall <mpm@selenic.com>
Content-Disposition: inline
In-Reply-To: <20050512094406.GZ5914@waste.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 11:44:06AM CEST, I got a letter
where Matt Mackall <mpm@selenic.com> told me that...
> Mercurial is more than 10 times as bandwidth efficient and
> considerably more I/O efficient. On the server side, rsync uses about
> twice as much CPU time as the Mercurial server and has about 10 times
> the I/O and pagecache footprint as well.
> 
> Mercurial is also much smarter than rsync at determining what
> outstanding changesets exist. Here's an empty pull as a demonstration:
> 
>  $ time hg merge hg://selenic.com/linux-hg/
>  retrieving changegroup
> 
>  real    0m0.363s
>  user    0m0.083s
>  sys     0m0.007s
> 
> That's a single http request and a one line response.

So, what about comparing it with something comparable, say git pull over
HTTP? :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
