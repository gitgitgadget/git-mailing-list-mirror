From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-diff fixed to work with BSD xargs
Date: Tue, 20 Sep 2005 21:39:56 +0200
Message-ID: <20050920193956.GE28621@pasky.or.cz>
References: <11253960093915-git-send-email-martin@catalyst.net.nz> <7v7je3ld53.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 21:40:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHnyH-0000JD-3n
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 21:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVITTj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 15:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbVITTj6
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 15:39:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29382 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965099AbVITTj5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 15:39:57 -0400
Received: (qmail 5908 invoked by uid 2001); 20 Sep 2005 21:39:56 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7je3ld53.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9019>

Dear diary, on Tue, Aug 30, 2005 at 04:20:40PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> But the code you are fixing looks to me like it is already
> somewhat obsolete, even if it is still working.  The munging of
> user-given paths into $filter temporary file was necessary only
> because older git-diff-* family did not work from anywhere but
> the top-level directory; they do, thanks to Linus' enhancements,
> these days.
> 
> I think it is time to start updating Cogito to take advantage of
> the modern core.  I do not do Porcelains, but here is my stab at
> it.

Thanks for the patch - it'd be actually very nice to get rid of the
complexity. But more than that, I want to be consistent - so do all the
GIT core commands work in subdirectories by now, or only a subset of
them? I'd hate to have half of the scripts stay in the subdirectory
and half use the Cogito's old relpath logic, so it's either everything
or anything from my POV.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
