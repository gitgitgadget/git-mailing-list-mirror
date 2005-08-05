From: Petr Baudis <pasky@ucw.cz>
Subject: Template files location
Date: Fri, 5 Aug 2005 11:43:24 +0200
Message-ID: <20050805094324.GF29216@pasky.ji.cz>
References: <42DC4537.2080103@orionmulti.com> <20050805024222.GE7762@shell0.pdx.osdl.net> <42F2E571.6040207@orionmulti.com> <7voe8dow4w.fsf@assigned-by-dhcp.cox.net> <20050805042332.GG7762@shell0.pdx.osdl.net> <7vd5otov7s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 11:47:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0yml-0002ja-Bd
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 11:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVHEJps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 05:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVHEJnu
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 05:43:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45828 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262932AbVHEJn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 05:43:29 -0400
Received: (qmail 31197 invoked by uid 2001); 5 Aug 2005 09:43:24 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5otov7s.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Aug 05, 2005 at 06:37:11AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> We install files in $(HOME)/etc/git-core/templates/ directory.
> 
> In the standard binary distribution scheme, it should probably
> go to either /usr/share or /etc; the former if the distribution
> prefers static boilerplate files in /usr/share, latter if we
> consider them site-specific conffiles.  I just discussed this
> privately with a Debian person on the list today, and we are in
> favor of installing it under /usr/share/git-core/templates,
> because we do not expect the contents of the standard templates
> directory will not be a per-site customization [*1*].
> 
> In any case, this means that the make drivers like spec.in and
> debian/rules would need to override some make variables when
> they invoke the main Makefile.

Any reason why that's not the default destination then?

Or you can try /etc/git-core/ and fall back to /usr/share/git-core :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
