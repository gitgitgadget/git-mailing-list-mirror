From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito: cg-tag creates a tag object only if -s is specified
Date: Tue, 27 Sep 2005 01:54:16 +0200
Message-ID: <20050926235416.GH26340@pasky.or.cz>
References: <433885E1.8010800@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:54:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK2ni-0007IJ-Ej
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 01:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVIZXyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 19:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVIZXyX
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 19:54:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30126 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750808AbVIZXyX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 19:54:23 -0400
Received: (qmail 2822 invoked by uid 2001); 27 Sep 2005 01:54:16 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <433885E1.8010800@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9354>

Dear diary, on Tue, Sep 27, 2005 at 01:36:01AM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> cg-tag only creates a tag object if -s (sign) is specified.  This not 
> only doesn't work properly with a fair number of tools (e.g. gitk), but 
> it also means that any description the user has entered via the -d 
> option is silently discarded!
> 
> Please create a tag object for all tags, even if it is not signed.

Yes, makes sense. In the past it seemed like a nice idea to only create
it when we have to, but it has way too many downsides and if you still
have a plausible reason not to want the tag objects, you're special
enough to fallback to the lowlevel tools.

cg-tag now always creates tag objects.

Thanks for the feedback,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
