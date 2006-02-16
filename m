From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix for rpm creation
Date: Thu, 16 Feb 2006 16:43:20 +0100
Message-ID: <20060216154320.GT31278@pasky.or.cz>
References: <20060216135100.GR31278@pasky.or.cz> <200602161633.44399.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 16:42:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9lH2-0000Q3-I3
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 16:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWBPPmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 10:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWBPPmZ
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 10:42:25 -0500
Received: from w241.dkm.cz ([62.24.88.241]:55438 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932300AbWBPPmZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 10:42:25 -0500
Received: (qmail 12618 invoked by uid 2001); 16 Feb 2006 16:43:20 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200602161633.44399.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16307>

Dear diary, on Thu, Feb 16, 2006 at 04:33:44PM CET, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> 
> Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
> 
> ---
> This fixes "make rpm", which currently gives at the very end:
> ...
> Checking for unpackaged file(s): /usr/lib/rpm/check-files /var/tmp/cogito-0.17rc2.GIT-1-root-weidendo
> error: Installed (but unpackaged) file(s) found:
>    /usr/share/cogito/default-exclude

Thanks, applied.

> Another thing:
> "cg-switch origin" currently refuses to switch to the branch.
> Wouldn't it be better to handle this like "cg-seek origin"?

Well, it depends on what you expect this to actually do. If you really
want to just seek to whichever is the current origin commit, that's very
different from what cg-switch does - you want cg-seek and cg-switch
doing the same thing when it does something totally different from the
user POV otherwise would be very confusing.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
