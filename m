From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Wed, 20 Apr 2005 00:39:45 +0200
Message-ID: <20050419223945.GG9305@pasky.ji.cz>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com> <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Wed Apr 20 00:37:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1KP-0006fs-62
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVDSWj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVDSWj6
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:39:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13256 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261708AbVDSWjs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:39:48 -0400
Received: (qmail 1127 invoked by uid 2001); 19 Apr 2005 22:39:45 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 10:20:47PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Pasky? Can you check my latest git stuff, notably read-tree.c and the 
> changes to git-pull-script?

I've made git merge to use read-tree -m, HTH.

I will probably not buy git-export, though. (That is, it is merged, but
I won't make git frontend for it.) My "git export" already does
something different, but more importantly, "git patch" of mine already
does effectively the same thing as you do, just for a single patch; so I
will probably just extend it to do it for an (a,b] range of patches.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
