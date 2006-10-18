From: Sean <seanlkml@sympatico.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 15:57:04 -0400
Message-ID: <BAYC1-PASMTP08F10B1B8BCDB04B2AD771AE0F0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172351.17377.jnareb@gmail.com>
	<4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 21:57:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaHXM-0006ih-0o
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 21:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWJRT5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 15:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWJRT5I
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 15:57:08 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:42184 "EHLO
	BAYC1-PASMTP08.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1030272AbWJRT5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 15:57:06 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP08.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 18 Oct 2006 13:05:43 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GaGbA-0002IS-Ec; Wed, 18 Oct 2006 14:57:04 -0400
To: Petr Baudis <pasky@suse.cz>
Message-Id: <20061018155704.b94b441d.seanlkml@sympatico.ca>
In-Reply-To: <20061018185225.GU20017@pasky.or.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Oct 2006 20:05:44.0343 (UTC) FILETIME=[CB4B7270:01C6F2F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Oct 2006 20:52:25 +0200
Petr Baudis <pasky@suse.cz> wrote:

> Took me exactly an hour from mkdir cogito-bundle to cg-push to
> kernel.org. :-)

Nicely done :-).

> cogito-bundle is an example on how to create third-party addons or
> plugins adding own commands to Cogito and using Cogito's infrastructure.
> It's not _that_ easy currently since you have to replicate large part of
> the build infrastructure locally; that could be fixed by installing some
> "library makefiles" and asciidoc toolkit to /usr/share or something, if
> there would be a real demand for such an addon API. cg-help and the cg
> wrapper will pick up the newly installed commands automagically. The
> only thing missing is updating cogito(7) to list the addon commands,
> which would take a bit more work.

Couldn't these just as easily have been written as git-bundle and
git-unbundle without needing any plugins or other cogito infrastructure?

> Though it's an example, it's actually supposed to be useful, by doing
> exactly what is outlined above - l - it lets you exchange commits over
> mail by so-called "bundles", similar to e.g. Bazaar bundles - basically,
> it is like push or fetch, but over email, and the commit ids are
> preserved when transferred in bundles (if you just send patches, the
> commit ids will end up different).

Not sure if it would be useful, but it shouldn't be too hard to have
same commit ids regenerated at receiving end with git patches.

> The provided cg-bundle and cg-unbundle commands are rather crude and
> don't support many things - they don't actually include a diff, only a
> diffstat, etc. The uuencoded bundle is inlined in the mail, which I
> suspect isn't very useful; perhaps it would be more practical to just
> attach it binarily. Feel free to send patches (or bundles ;).

Think you're right about making it an attachment instead.

Sean
