From: Petr Baudis <pasky@suse.cz>
Subject: Re: merge-one-file: use common as base, instead of emptiness.
Date: Thu, 10 Nov 2005 21:35:17 +0100
Message-ID: <20051110203517.GY30496@pasky.or.cz>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108095600.GA1431@pasky.or.cz> <7v64r16ro9.fsf_-_@assigned-by-dhcp.cox.net> <20051110194317.GV30496@pasky.or.cz> <7vk6fgxn28.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 21:36:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaJ8l-0002hI-RA
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 21:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVKJUfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 15:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVKJUfV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 15:35:21 -0500
Received: from w241.dkm.cz ([62.24.88.241]:34527 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932081AbVKJUfU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 15:35:20 -0500
Received: (qmail 32410 invoked by uid 2001); 10 Nov 2005 21:35:17 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6fgxn28.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11523>

Dear diary, on Thu, Nov 10, 2005 at 09:30:55PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > But obviously now the trouble is opposite, when the files are completely
> > unrelated, since now you likely get large conflicting areas interleaved
> > with some scarce common lines... And this might get to be a big PITA to
> > resolve as well.
> 
> Yeah, you can always count lines in $orig and $src2 after
> two-file merge runs, and if it appears we do not have enough
> common section just empty the $orig before running merge.

Reasonable solution, I like that. Let's say 50%, like for the renames
detection?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
