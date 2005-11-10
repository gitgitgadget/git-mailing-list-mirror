From: Petr Baudis <pasky@suse.cz>
Subject: Re: git binary directory?
Date: Thu, 10 Nov 2005 10:49:31 +0100
Message-ID: <20051110094931.GO30496@pasky.or.cz>
References: <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511052013550.3316@g5.osdl.org> <7vy84249re.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511060816390.3316@g5.osdl.org> <7v7jbly1lh.fsf@assigned-by-dhcp.cox.net> <20051106221952.GP1431@pasky.or.cz> <7virv5wc86.fsf@assigned-by-dhcp.cox.net> <20051107004346.GR1431@pasky.or.cz> <Pine.LNX.4.64.0511061653380.3316@g5.osdl.org> <7vvez4s6zv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 10:50:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea94B-0002Pa-At
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 10:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVKJJtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 04:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVKJJtg
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 04:49:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:61144 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750732AbVKJJtf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 04:49:35 -0500
Received: (qmail 13079 invoked by uid 2001); 10 Nov 2005 10:49:31 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvez4s6zv.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11474>

Dear diary, on Mon, Nov 07, 2005 at 06:27:48PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> It looks like that both you and Pasky are not so enthusiastic
> about moving thing out of /usr/bin/, so let's keep things the
> way they are for 1.0 release and rethink when we do 2.0 (or
> whatever comes after 1.0).

Well, just to clarify - I'm personally not opposed to it, as long as it
gets done in some timeframe where it won't drastically break backwards
compatibility (that is, not in 1.0.1 or such, but e.g. at some right
moment before 1.0 or at the start of the next development series
whenever that happens), and as long as I get a way to get the path
of the git commands by a single fork().

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
