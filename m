From: Petr Baudis <pasky@suse.cz>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 18:16:36 +0200
Message-ID: <20050919161636.GA18320@pasky.or.cz>
References: <20050919134838.GC2903@pasky.or.cz> <7vll1trqiq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 18:19:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHOK5-0005Yr-QO
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 18:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVISQQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 12:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVISQQj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 12:16:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64493 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932487AbVISQQi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 12:16:38 -0400
Received: (qmail 21051 invoked by uid 2001); 19 Sep 2005 18:16:36 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vll1trqiq.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8881>

Dear diary, on Mon, Sep 19, 2005 at 06:06:21PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> >   Well, I have to say that from the GECOS fields I saw, none use that
> > format, but a lot of them used the realname,phone,something,phone,...
> > format.
> 
> >   Opinions?
> 
> If the real world GECOS were either only plain and
> name,room,blah,... format as you say and assume I think a
> heuristics like you suggested would be better than the
> current heuristics of assuming everything is a name, but I
> haven't seen what "angry mob" actually has so cannot judge.

It uses the name,room,blah,... format.

> What do popular MUAs do to come up with the real-name fields?
> Don't they face the same problem, trying to using GECOS?

mutt:

  { "gecos_mask",       DT_RX,   R_NONE, UL &GecosMask, UL "^[^,]*" },

A regular expression used by mutt to parse the GECOS field of a password
entry when expanding the alias.  By default the regular expression is
set to "^[^,]*" which will return the string up to the first ","
encountered.  If the GECOS field contains a string like "lastname,
firstname" then you should set the gecos_mask=".*".

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
