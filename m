From: Petr Baudis <pasky@suse.cz>
Subject: Re: Notes for CVS Converts
Date: Wed, 21 Sep 2005 16:04:04 +0200
Message-ID: <20050921140403.GB17981@pasky.or.cz>
References: <1125515315.13577.53.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 16:05:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI5Cy-0000sG-LO
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 16:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVIUOEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 10:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbVIUOEL
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 10:04:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60071 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750961AbVIUOEJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 10:04:09 -0400
Received: (qmail 20392 invoked by uid 2001); 21 Sep 2005 16:04:05 +0200
To: Jon Loeliger <jdl@freescale.com>
Content-Disposition: inline
In-Reply-To: <1125515315.13577.53.camel@cashmere.sps.mot.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9045>

Dear diary, on Wed, Aug 31, 2005 at 09:08:36PM CEST, I got a letter
where Jon Loeliger <jdl@freescale.com> told me that...
> Guys,
> 
> I was recently bitten by a cg-rm behavior where
> it silently Did The Wrong Thing, IMO.  I think
> that other CVS Converts might stumble across the
> same pitfall, so it might warrant a comment in
> the documentation, perhaps in the "Notes For CVS
> Users" section.

Thanks for this, I changed the default to not deleting the files.

> However, in my case I had already moved/removed the
> original files.  The "find" didn't find them and the
> cache update didn't happen.  And no output was generated
> either.  But I thought nothing of it; after all, "rm"
> doesn't produce output when it works successfully.

There was a bug like that, but I believe it was already fixed in the
release available by the time you were writing this mail.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
