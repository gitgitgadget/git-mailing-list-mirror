From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] cg-Xlib: make showdate show timezone
Date: Sun, 12 Jun 2005 13:52:59 +0200
Message-ID: <20050612115259.GD6620@pasky.ji.cz>
References: <42AC1F49.9010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 12 13:48:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhQx6-0007lS-PU
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 13:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVFLLxE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 07:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVFLLxE
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 07:53:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47035 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262305AbVFLLxB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2005 07:53:01 -0400
Received: (qmail 31441 invoked by uid 2001); 12 Jun 2005 11:52:59 -0000
To: Dan Holmsand <holmsand@gmail.com>
Content-Disposition: inline
In-Reply-To: <42AC1F49.9010808@gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jun 12, 2005 at 01:40:57PM CEST, I got a letter
where Dan Holmsand <holmsand@gmail.com> told me that...
> This makes timezones show up again in showdate's default
> format. Hopefully, this also makes showdate a little more
> portable.
> 
> It also speeds things up a little, by avoiding an extra fork.
> 
> Signed-off-by: Dan Holmsand <holmsand@gmail.com>

Thanks, applied. But what's the point of calling date with LANG=C? If
the user wants his locale to get used, why prevent him?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
