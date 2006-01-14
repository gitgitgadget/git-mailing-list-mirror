From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-seek should not complain if run twice
Date: Sun, 15 Jan 2006 00:30:38 +0100
Message-ID: <20060114233037.GA28365@pasky.or.cz>
References: <1135054536.3815.14.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 15 00:29:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExuqA-0006aR-R2
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 00:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWANX3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 18:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWANX3m
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 18:29:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:64146 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750716AbWANX3m (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 18:29:42 -0500
Received: (qmail 8788 invoked by uid 2001); 15 Jan 2006 00:30:38 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1135054536.3815.14.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14688>

Dear diary, on Tue, Dec 20, 2005 at 05:55:36AM CET, I got a letter
where Pavel Roskin <proski@gnu.org> said that...
> cg-seek complains if run without arguments in a non-seeked repository:
> 
> rm: cannot remove `.git/refs/heads/cg-seek-point': No such file or directory
> rm: cannot remove `.git/head-name': No such file or directory
> 
> In fact, it's OK for those files not to exist, so they should be removed
> silently.
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>

It seems cleaner to just make cg-seek fail with a sensible error message
if it's already unseeked.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
