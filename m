From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Mon, 13 Feb 2006 22:00:01 +0100
Message-ID: <20060213210001.GA31278@pasky.or.cz>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 13 22:00:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8knb-00062R-Sd
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 21:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWBMU7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 15:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWBMU7W
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 15:59:22 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9091 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964863AbWBMU7U (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 15:59:20 -0500
Received: (qmail 1977 invoked by uid 2001); 13 Feb 2006 22:00:01 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060210211740.GO31278@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16082>

  Hi,

Dear diary, on Fri, Feb 10, 2006 at 10:17:40PM CET, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> > I just posted the first public version of pg, a GIT porcelain for
> > managing patches.  Think StGIT, but better in some ways:
> 
>   it sounds interesting. I've been thinking about wrapping some patch
> queue tool in Cogito (post-1.0) and pg might be a better choice than
> StGIT.

  so I've used it a bit and I'm going back to StGIT, at least for now.
It is not really usable for me so far, since it is missing two crucial
things:

	* Patch description tracking. Patch description is almost as
	important as patch contents for me, and pg just doesn't track it
	for now.  It would be best if it just seeded the patch
	description by the first commit message and then allow you edit
	it at the refresh time.

	* Mail interface. StGIT can pre-fill the patch description with
	my signoff line, but more importantly when I write

		stg mail patchname

	it will mail the patch to the addresses I configured it to,
	prepend [PATCH] to the subject line and stuff.

  So, my patchqueue workflow is "I do some random third-party patches
for some software and want to manage, update, and submit them easily."
PG does not make it much easier now, unfortunately.

  Some common gripes for both StGIT and pg (well, I'm using some
ridiculously old StGIT version, so this may not apply anymore there):

	* stg new --force - seriously, what's the point?! I always to
	the change first and when it's any good, I want to create a
	patch for it.

	* I can't just get the patch in its "canonical ready-to-mail
	form" on stdout so that I could easily review it. Why is
	pg-export insisting to dump it to a file?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
