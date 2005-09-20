From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining cg-*-id
Date: Tue, 20 Sep 2005 02:26:31 +0200
Message-ID: <20050920002630.GA13537@pasky.or.cz>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz> <1127169021.26772.58.camel@dv> <20050919225838.GH18320@pasky.or.cz> <1127175590.31115.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 02:27:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHVy0-00085Z-DC
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVITA0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVITA0e
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:26:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:24476 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964798AbVITA0d (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 20:26:33 -0400
Received: (qmail 14423 invoked by uid 2001); 20 Sep 2005 02:26:31 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1127175590.31115.10.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8934>

Dear diary, on Tue, Sep 20, 2005 at 02:19:50AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> As for merging, I see that the existing *-id scripts are a mess.  For
> instance, cg-parent returns parents separated by spaces, but cg-diff
> used "head -1" on its output to get the first parent, i.e it assumes
> newline separated output.

Actually, cg-parent-id's documentation seems to be wrong. We always
return only the first parent. I've just updated the documentation for
now, even though in the future we might want to change this to reflect
the original documentation instead.

> Another thing that is broken is "cg-commit-id origin^" - apparently the
> "^" parsing is only designed for cg-parent-id.

That's a bug, IIRC it was originally meant to be general.

> I think I'll start a local branch for fixing this, and then I'll send
> separate patches.

Good idea.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
