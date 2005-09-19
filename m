From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fixing --help, usage for *-id
Date: Mon, 19 Sep 2005 23:40:54 +0200
Message-ID: <20050919214054.GF18320@pasky.or.cz>
References: <1127165381.26772.16.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 23:42:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHTO5-0005vv-N1
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 23:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbVISVk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 17:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVISVk7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 17:40:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53958 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932657AbVISVk5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 17:40:57 -0400
Received: (qmail 23970 invoked by uid 2001); 19 Sep 2005 23:40:54 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1127165381.26772.16.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8913>

Dear diary, on Mon, Sep 19, 2005 at 11:29:41PM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello!

Hello,

> Removal of cg-Xlib inclusion in *-id scripts broke "--help" switch.
> When cg-Xlib is sourced indirectly through cg-Xnormid, the help text is
> treated like an ID, and its last word is dropped.

do we really need --help in *-id? They are some kind of scripts
half-internal and half for the user - their _primary_ use is from the
other scripts, but they are standalone since they can be useful for the
end user as well in various situations. I can roughly remember cg-Xlib
inclusion in those scripts being significantly visible on the running
times of the users.

> Lack of USAGE string in the *-id scripts breaks the documentation
> generation because empty synopsis causes invalid XML.  Thus the USAGE
> strings should be provided.

Thanks, this was already taken care of by Martin Atukunda.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
