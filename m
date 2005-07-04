From: Petr Baudis <pasky@suse.cz>
Subject: Re: expensive local git clone
Date: Mon, 4 Jul 2005 22:42:35 +0200
Message-ID: <20050704204235.GE21128@pasky.ji.cz>
References: <20050704.125744.59481768.davem@davemloft.net> <Pine.LNX.4.58.0507041327580.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David S. Miller" <davem@davemloft.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 22:42:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpXm6-0002SD-43
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 22:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVGDUmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 16:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVGDUmi
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 16:42:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37295 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261652AbVGDUmg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 16:42:36 -0400
Received: (qmail 12714 invoked by uid 2001); 4 Jul 2005 20:42:35 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507041327580.3570@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Jul 04, 2005 at 10:39:09PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> That said, the pack-file thing I'm working on won't be perfect either, and
> the main advantage is that it should work over ssh. The fastest way to do
> a clone is really to do a recursive hardlinked tree, so you may well want
> to just do
> 
> 	#!/bin/sh
> 	mkdir "$2" && cp -rl "$1/.git" "$2/.git"
> 
> and it should be about a million times faster and equally effective.
> 
> Untested, of course.

I wouldn't do that on anything but .git/objects. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
