From: Shawn Pearce <spearce@spearce.org>
Subject: Re: author/commit counts
Date: Fri, 22 Dec 2006 21:37:20 -0500
Message-ID: <20061223023719.GA8734@spearce.org>
References: <20061222181030.d733deb3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 03:37:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxwlM-0005D8-Qk
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 03:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWLWChZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 21:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWLWChZ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 21:37:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58255 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbWLWChY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 21:37:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gxwl4-0001HZ-RS; Fri, 22 Dec 2006 21:37:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3D12D20FB65; Fri, 22 Dec 2006 21:37:20 -0500 (EST)
To: Randy Dunlap <rdunlap@xenotime.net>
Content-Disposition: inline
In-Reply-To: <20061222181030.d733deb3.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35253>

Randy Dunlap <rdunlap@xenotime.net> wrote:
> Someone asked me a few days ago about their patches being merged yet
> (e.g., how to see their commits in a git tree).
> Someone else asked (in general) about commit or author counts.

I often do `git log --author=Shawn next@{1}..next` to see what
commits of mine Junio has recently merged into git.git since my
last fetch.  Since I'm the only Shawn (with that spelling) that
contributes to git.git this works rather well to show my work.  ;-)
 
> I pointed the first person to "git log" and/or gitweb.
> For the second, there are probably lots of scripts out there
> but I didn't find them.  Where are they?

Here's another variant showing the top 20 committers to git.git,
no Perl involved:

  $ git log | grep ^Author | cut -d\< -f1 | sort \
  	| uniq -c | sort -n -r | head -20
  3728 Author: Junio C Hamano 
   842 Author: Linus Torvalds 
   250 Author: Johannes Schindelin 
   217 Author: Jakub Narebski 
   194 Author: Eric Wong 
   166 Author: Petr Baudis 
   150 Author: Paul Mackerras 
   147 Author: Kay Sievers 
    88 Author: Nicolas Pitre 
    77 Author: Rene Scharfe 
    67 Author: Shawn Pearce 
    57 Author: Martin Langhoff 
    53 Author: Fredrik Kuivinen 
    52 Author: Nick Hengeveld 
    52 Author: Matthias Urlichs 
    49 Author: Daniel Barkalow 
    47 Author: Ryan Anderson 
    46 Author: Shawn O. Pearce 
    45 Author: Sergey Vlasov 
    45 Author: Luben Tuikov 

The only issue I have with that is I seem to have two attributions
in git.git: 'Shawn Pearce' and 'Shawn O. Pearce'.  Technically I'm
in the top 10 by commit volume but its not immediately clear because
of the two attributions being used.  Really my only issue here is
why sometimes my middle initial gets used and other times it doesn't.

You can also see the very clear gap between Junio and the rest of the
world.  There's very little dispute about who really codes Git.  :-)

I'm personally suprised at Pasky's ranking: 166 commits!  I did
not realize he had contributed so frequently to git.git itself.

-- 
Shawn.
