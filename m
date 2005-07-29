From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 09:14:39 +0200
Message-ID: <20050729071438.GC24895@pasky.ji.cz>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de> <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728161815.GC17952@pasky.ji.cz> <pan.2005.07.28.21.13.35.458701@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 09:18:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyP88-0002sV-5n
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 09:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVG2HRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 03:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVG2HRE
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 03:17:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:24843 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262055AbVG2HOm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 03:14:42 -0400
Received: (qmail 27192 invoked by uid 2001); 29 Jul 2005 07:14:39 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <pan.2005.07.28.21.13.35.458701@smurf.noris.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 28, 2005 at 11:13:38PM CEST, I got a letter
where Matthias Urlichs <smurf@smurf.noris.de> told me that...
> Then, you'd kill porcelain writers who don't verify that the old head is
> a(n indirect) parent of the new one. ;-)

send-pack.c:

	if (!ref_newer(new_sha1, ref->old_sha1)) {
		error("remote '%s' isn't a strict parent of local", name);
		continue;
	}

"git-core: Making life nice for Porcelains."

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
