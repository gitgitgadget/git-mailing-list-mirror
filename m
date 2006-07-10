From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] Avoid C++ comments, use C comments instead
Date: Tue, 11 Jul 2006 01:42:34 +0200
Message-ID: <20060710234234.GA26528@dspnet.fr.eu.org>
References: <20060710065751.22902.43316.stgit@dv.roinet.com> <7vzmfhdhrf.fsf@assigned-by-dhcp.cox.net> <20060710094653.GA52962@dspnet.fr.eu.org> <Pine.LNX.4.63.0607101306030.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060710114117.GA62514@dspnet.fr.eu.org> <44B2A709.8020500@serice.net> <20060710202412.GA8189@dspnet.fr.eu.org> <Pine.LNX.4.63.0607110049470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Serice <paul@serice.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 01:42:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G05Oi-0002kS-81
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 01:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965332AbWGJXmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 19:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965333AbWGJXmg
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 19:42:36 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:21263 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S965332AbWGJXmf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 19:42:35 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 8FF43A3653; Tue, 11 Jul 2006 01:42:34 +0200 (CEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607110049470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23669>

On Tue, Jul 11, 2006 at 12:55:59AM +0200, Johannes Schindelin wrote:
> Judging by what you say, one could get the impression you'd have not much 
> sympathy for people being stuck with non-C99 compilers.

More and more these people are stuck with such a compiler because they
want to be.


> Just look at it: if the OS vendor just does not _care_, and you blame the 
> vendor for not providing something newer, the vendor does not _care_ about 
> your complaint either. But the user does.

Well, I'm not talking about git here, but I'm not really interested in
making my code harder to maintain just to provide more value for said
vendor.


> However, there is a more important point to be made. If you are complying 
> with an older standard, you get more users. More users = more bug testers.

On such systems, what you tend to find is bugs of the system, or
simply different, and sometimes somewhat nonsensical, implementations
of some compromise-happy standards like POSIX.


> And there were quite a few occasions where I found bugs by trying to run 
> on a different platform, which was less forgiving than Linux. These are 
> bugs you have a harder time to spot on Linux, _because_ Linux is so nice. 
> But they will surface. And they will be a PITA to find.

And how many bugs or "features" of the platform did you have to code
around before finding a genuine bug?


> Anyway, it is best practice for a reason to program portably. (Well, at 
> least if you are not living in Redmont.)

If "programming portably" meant catering to the oldest standards, then
you shouldn't even use prototypes or ansi-style function declarations.
After all, some people may be stuck with the old sun (or was it hp?)
compiler that was k&r only.  And limit the filenames to 14 characters.
Also, you shouldn't require gtk, python, perl, fire or the wheel.

  OG.
