From: Petr Baudis <pasky@suse.cz>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Fri, 11 Nov 2005 14:12:00 +0100
Message-ID: <20051111131200.GS30496@pasky.or.cz>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com> <20051111075257.GA4765@c165.ib.student.liu.se> <20051111114511.GQ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 14:14:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaYhR-0000ej-0d
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 14:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVKKNMD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 08:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVKKNMD
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 08:12:03 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32197 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750723AbVKKNMC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 08:12:02 -0500
Received: (qmail 2252 invoked by uid 2001); 11 Nov 2005 14:12:00 +0100
To: Fredrik Kuivinen <freku045@student.liu.se>
Content-Disposition: inline
In-Reply-To: <20051111114511.GQ30496@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11594>

Dear diary, on Fri, Nov 11, 2005 at 12:45:11PM CET, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> I guess I really don't want to do that, but instead choose one of the
> bases. Hmm. Well, I suppose it's as good as anything to leave this
> decision on the user. Kind of:
> 
> 	if [ $(wc -l merge-bases) -ge 1 ]; then
> 		echo "Multiple merge bases, please select one by the -b parameter:" >&2
> 		cat merge-bases
> 		echo -n "The most conservative base (but likely a lot of conflicts):" >&2
> 		while true; do
> 			git-merge-base --all $(cat merge-bases) >merge-bases~
> 			mv merge-bases~ merge-bases
> 			[ $(wc -l merge-bases) -eq 1 ] && break
> 		done
> 		cat merge-bases
> 		exit 1
> 	fi

I just did something in this style. Since I'm unable to get the
repository, could someone please test it?

I'll try to come up with some automated testcase later.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
