From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Improve can_hardlink diagnostics, remove suggest_hardlink
Date: Mon, 12 Sep 2005 02:14:50 +0200
Message-ID: <20050912001450.GD15630@pasky.or.cz>
References: <1124814238.11038.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 02:15:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEbyJ-0006CF-62
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 02:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbVILAOw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 20:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVILAOw
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 20:14:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61157 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751030AbVILAOw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 20:14:52 -0400
Received: (qmail 22230 invoked by uid 2001); 12 Sep 2005 02:14:50 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1124814238.11038.6.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8348>

Dear diary, on Tue, Aug 23, 2005 at 06:23:58PM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello!

Hello,

> suggest_hardlink is write-only in cg-pull - remove it.  can_hardlink
> should not be shown to the user as is (it's either "l" or empty) - we
> should output something meaningful instead.

actually, the infamous "l" output was just a leftover debugging print I
forgot to remove. ;-) Well, I guess it doesn't hurt if the user is
notified whether hardlinking is done or not.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
