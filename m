From: Petr Baudis <pasky@suse.cz>
Subject: Re: bogus merges
Date: Mon, 12 Sep 2005 02:58:07 +0200
Message-ID: <20050912005807.GI15630@pasky.or.cz>
References: <59a6e58305090507387d412b3d@mail.gmail.com> <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org> <Pine.LNX.4.63.0509061409180.23242@iabervon.org> <20050911120140.A8236@flint.arm.linux.org.uk> <Pine.LNX.4.63.0509111256300.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	Wayne Scott <wsc9tt@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 02:59:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEceM-00043m-P6
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 02:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVILA6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 20:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVILA6K
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 20:58:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26502 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751110AbVILA6J (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 20:58:09 -0400
Received: (qmail 29638 invoked by uid 2001); 12 Sep 2005 02:58:07 +0200
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0509111256300.23242@iabervon.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8353>

Dear diary, on Sun, Sep 11, 2005 at 08:08:14PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> I think that the fundamental bug is that tree_timewrap() doesn't clear 
> .git/merging, which means that it can still think you're doing a merge 
> when you've started doing something else (such as doing further 
> development after updating to someone else's merge of your tree).

Oh, nice catch. Thanks, fixed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
