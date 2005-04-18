From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Add + Status patches
Date: Mon, 18 Apr 2005 22:48:14 +0200
Message-ID: <20050418204814.GF5554@pasky.ji.cz>
References: <42641AE4.9050700@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 22:44:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNd6X-0004iU-Er
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 22:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDRUsU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 16:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVDRUsU
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 16:48:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62125 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261170AbVDRUsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 16:48:16 -0400
Received: (qmail 24321 invoked by uid 2001); 18 Apr 2005 20:48:14 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <42641AE4.9050700@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 10:39:00PM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> Hi Petr

Hi,

> Thankyou for the help earlier - problem resolved.
> 
> I have a trivial patch (attached).
> 
> It allows:
> find src -type f | git add -
> 
> and fixes git status not reporting added files properly (on my debian 
> system it only reported the first file in .git/add-queue)

Thanks. Could you please send the patches signed off and either with
content-disposition: inline or in the mail body?

I think it would be cleaner to do the testing for the dash in the for
loop, so that I can do git add foo bar -.  Also, don't forget to update
git add's documentation at the top. For the usage string, I'd probably
prefer (-|FILE)...

thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
