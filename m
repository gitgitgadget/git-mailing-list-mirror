From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 15:40:50 +0100
Message-ID: <20090115144050.GD10045@leksak.fem-net>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <496F3C99.1040800@drmicha.warpmail.net> <20090115135518.GB10045@leksak.fem-net> <496F44AC.2060607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:42:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTQb-0001E1-M5
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765626AbZAOOk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762058AbZAOOk4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:40:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:48668 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762098AbZAOOkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:40:55 -0500
Received: (qmail invoked by alias); 15 Jan 2009 14:40:53 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp024) with SMTP; 15 Jan 2009 15:40:53 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19hj3o7GBNhZ/2QkNlz5QJAwjcUDhUdIqvLoYHqFV
	nBgc0QhCFWBBTq
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNTOs-00059V-Am; Thu, 15 Jan 2009 15:40:50 +0100
Content-Disposition: inline
In-Reply-To: <496F44AC.2060607@drmicha.warpmail.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105821>

Michael J Gruber wrote:
> BTW: How does the sequencer based rebase do in this case,

This was the first thing I checked :-)
I had to rework the rebase -i -p code for sequencer a bit, but this
case was not something I had thought about (although it may not be
too seldom), so I'm glad it comes up now.

The result is that it eats the commits a3 and a4. (But at least it does
the same with and without --onto master.) :-)
I think it's not too hard to fix.

> and what's the general status?

I'm currently highly motivated to get it done soon and I hope that it
gets into pu or next before the end of January.

Depending on how productive I am over the weekend and depending on how
many further bugs (often hidden in such special cases) I find, it
could be sent to the list next week.

> If it's about to be integrated we can do without the
> present script...

I think it will take some time and some discussions on the list until
it will be integrated.  I remember, for example, Dscho, who has, since
it had first come up, always been opposed to the mark-reset /
mark-reset-merge scheme (in rebase -i -p, at least).
Other users said "Wow, this is much more flexible." ...
and this is perhaps only one thing that can lead to some bigger
discussion.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
