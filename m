From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cogito bugfixes and cleanups, mainly Debian things
Date: Mon, 12 Sep 2005 12:21:52 +0200
Message-ID: <20050912102152.GB22118@pasky.or.cz>
References: <11250540944027-git-send-email-tv@debian.org> <11250540952285-git-send-email-tv@debian.org> <20050912003156.GF15630@pasky.or.cz> <43252E5C.5090207@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 12:22:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EElRn-00007U-TV
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 12:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVILKV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 06:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVILKV5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 06:21:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33769 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750715AbVILKV4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 06:21:56 -0400
Received: (qmail 25109 invoked by uid 2001); 12 Sep 2005 12:21:52 +0200
To: Tommi Virtanen <tv@debian.org>
Content-Disposition: inline
In-Reply-To: <43252E5C.5090207@debian.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8375>

Dear diary, on Mon, Sep 12, 2005 at 09:29:32AM CEST, I got a letter
where Tommi Virtanen <tv@debian.org> told me that...
> Petr Baudis wrote:
> >>As long as the cg-cancel name is around, provide docs for it too.
> > cg-cancel is a compatibility alias only, so adding docs for it would
> > only encourage its further use, which is precisely what I don't want.
> 
> Maybe then it should have documentation that basically states
> "cg-cancel is deprecated, please use cg-reset".

Well, I don't know if it's worth the trouble - what would be more useful
would be printing a warning when cg-reset is called as cg-cancel - we
should remember to do that if we ever alias something else. But I'll
just remove cg-cancel by now, it's been two releases.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
