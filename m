From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Make git-update-cache --force-remove regular
Date: Mon, 6 Jun 2005 01:26:20 +0200
Message-ID: <20050605232620.GU17462@pasky.ji.cz>
References: <20050531165243.GD7013@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 01:23:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df4SM-0007jN-5b
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 01:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVFEX00 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 19:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVFEX00
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 19:26:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30371 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261631AbVFEX0W (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 19:26:22 -0400
Received: (qmail 8654 invoked by uid 2001); 5 Jun 2005 23:26:20 -0000
To: torvalds@osdl.org
Content-Disposition: inline
In-Reply-To: <20050531165243.GD7013@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 31, 2005 at 06:52:43PM CEST, I got a letter
where Petr Baudis <pasky@ucw.cz> told me that...
> Make the --force-remove flag behave same as --add, --remove and
> --replace. This means I can do
> 
> 	git-update-cache --force-remove -- file1.c file2.c
> 
> which is probably saner and also makes it easier to use in cg-rm.
> 
> Signed-off-by: Petr Baudis <pasky@ucw.cz>

Can this go in, please? Currently it's the only delta between your and
my git tree, so I'd like to get it merged so that Cogito works with
stock git again.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
