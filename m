From: Petr Baudis <pasky@suse.cz>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 18:45:36 +0100
Message-ID: <20060119174536.GF28365@pasky.or.cz>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com> <cda58cb80601170932o6f955469y@mail.gmail.com> <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net> <43CF739F.2030204@op5.se> <cda58cb80601190531q238a8f40r@mail.gmail.com> <43CF97AF.9060300@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 18:45:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezdpc-0007cD-8I
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 18:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWASRoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 12:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWASRoQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 12:44:16 -0500
Received: from w241.dkm.cz ([62.24.88.241]:61927 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750826AbWASRoP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 12:44:15 -0500
Received: (qmail 13128 invoked by uid 2001); 19 Jan 2006 18:45:36 +0100
To: Andreas Ericsson <ae@op5.se>, torvalds@osdl.org
Content-Disposition: inline
In-Reply-To: <43CF97AF.9060300@op5.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14918>

Dear diary, on Thu, Jan 19, 2006 at 02:44:15PM CET, I got a letter
where Andreas Ericsson <ae@op5.se> said that...
> Ach, no. The current kernel repo only has history since April 17 (around 
> 155 MB of objects, with less than optimal packing), when it started 
> using git for versioning. The kernel repo also sees a lot of very rapid 
> development.
> 
> The full kernel tree, with history since 1991 or some such, is about 3.2 
> GB.

There is some "accurate" history only from the moment the kernel got
tracked in BK, and it is certainly far less.

The question is, what is the "official" kernel history repository?
There is at least

	http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

with a 251M pack and

	http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/old-2.6-bkcvs.git

with a 165M pack - IIRC the latter is obsoleted by the former and
perhaps should be blasted to prevent confusion?

Getting a little offtopic here... Linus, would it be deemed useful to
have the script I've pasted in <20060119130519.GB28365@pasky.or.cz>
(earlier in this thread) in the kernel's scripts/ directory, pointing at
the canonical history repository?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
