From: Sean <seanlkml@sympatico.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 16:53:41 -0400
Message-ID: <BAYC1-PASMTP0628ED9CBD2F53119374EEAE0F0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172351.17377.jnareb@gmail.com>
	<4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
	<20061018155704.b94b441d.seanlkml@sympatico.ca>
	<20061018204618.GW20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 22:53:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaIQ7-0001Od-Qt
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 22:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWJRUxo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWJRUxo
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 16:53:44 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:44208 "EHLO
	BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751517AbWJRUxn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 16:53:43 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 18 Oct 2006 13:56:52 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GaHTx-0002Y2-82; Wed, 18 Oct 2006 15:53:41 -0400
To: Petr Baudis <pasky@suse.cz>
Message-Id: <20061018165341.bcece11f.seanlkml@sympatico.ca>
In-Reply-To: <20061018204618.GW20017@pasky.or.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Oct 2006 20:56:52.0718 (UTC) FILETIME=[F03050E0:01C6F2F7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Oct 2006 22:46:18 +0200
Petr Baudis <pasky@suse.cz> wrote:

> They could be written, but certainly not "just as easily". I'm more used
> to coding Cogito, I find it much more convenient than hacking git's
> shell scripts (those two may be interconnected ;), and there's plenty of
> infrastructure in Cogito missing in Git - Cogito has more flexible
> arguments parsing, documentation bundled with code, I could just
> cut'n'paste the code to handle -m arguments and message editor (and most
> of it is libified anyway) so I got that basically for free, and I think
> Cogito beats Git hands down in code readability.

Hmmm, if I get some time over the weekend i'll take a look at porting
them to Git.  But maybe some of the items you mentioned above deserve
to become part of Git proper?  It would definitely be nice to see
something like what you just did put into the hands of more users than
just those using Cogito, and its unfortunate that the current state
of Git code kept you from going that route.

> It would be of course technically possible, yes. But somewhat more work,
> this is just a quick hack.

No doubt, there would be some slightly thorny issues to deal with.  It
might even end up too fragile to be worthwhile.

Sean
