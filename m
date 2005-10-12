From: Petr Baudis <pasky@suse.cz>
Subject: Re: Problems cloning
Date: Wed, 12 Oct 2005 10:19:08 +0200
Message-ID: <20051012081908.GK30889@pasky.or.cz>
References: <20051009141547.GA8609@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kay.sievers@suse.de, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 12 10:20:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPbpg-0007BT-M3
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 10:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVJLITM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 04:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVJLITM
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 04:19:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43181 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751350AbVJLITL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 04:19:11 -0400
Received: (qmail 14904 invoked by uid 2001); 12 Oct 2005 10:19:08 +0200
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Content-Disposition: inline
In-Reply-To: <20051009141547.GA8609@schottelius.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10014>

Dear diary, on Sun, Oct 09, 2005 at 04:15:47PM CEST, I got a letter
where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> told me that...
> Cloning gitweb from kernel.org fails:
> 
> ----------------------------------------------------------------------
> [16:10] hydrogenium:build% cg-clone http://www.kernel.org/pub/scm/git/gitweb.git 
> defaulting to local storage area
> 16:10:35 URL:http://www.kernel.org/pub/scm/git/gitweb.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
> progress: 84 objects, 295012 bytes
> Getting pack list
> Getting alternates list
> error: Unable to find d263a6bd453df849c9f9211f1966c830c3cf913a under http://www.kernel.org/pub/scm/git/gitweb.git/
> 
> Cannot obtain needed commit d263a6bd453df849c9f9211f1966c830c3cf913a
> while processing commit f5dfb3f6a6655d4d60fdd0aaeef7b5b14226147f.
> cg-fetch: objects fetch failed
> cg-clone: fetch failed
> ----------------------------------------------------------------------
> 
> Info:
> 
> ----------------------------------------------------------------------
> [16:01] hydrogenium:cinit% cg --version
> cogito-0.15.1 (cfeac5893d97b830ac31b9d41951c30f80967410)
> 
> [16:13] hydrogenium:cinit% git --version
> git version 0.99.7d
> ----------------------------------------------------------------------

It seems that the gitweb repository is broken wrt. fetching over HTTP,
since it does not have the "dumb server info" containing the list of
packs. Someone needs to run git-update-server-info over there.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
