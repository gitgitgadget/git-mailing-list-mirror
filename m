From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Wed, 20 Apr 2005 01:02:33 +0200
Message-ID: <20050419230233.GI9305@pasky.ji.cz>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <426583D5.2020308@mesatop.com> <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Cole <elenstev@mesatop.com>, Greg KH <greg@kroah.com>,
	Greg KH <gregkh@suse.de>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Wed Apr 20 00:58:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1g2-0000aO-Df
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVDSXCq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVDSXCq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:02:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43720 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261732AbVDSXCg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 19:02:36 -0400
Received: (qmail 3263 invoked by uid 2001); 19 Apr 2005 23:02:33 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 20, 2005 at 12:38:17AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Just say no to patches. 

FYI, I've - per Junio's suggestion - made git merge's fast-forward to
apply show-diff output as a patch instead. This is roughly equal to
doing the sanity check against local changes, except that it handles
them, while at it. (Tree merge refuses to work when there are local
changes.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
