From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document git-stash
Date: Mon, 2 Jul 2007 11:33:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707021129540.4438@racer.site>
References: <Pine.LNX.4.64.0706301853400.4438@racer.site>
 <200707010533.l615XiH6006728@mi1.bluebottle.com> <20070701080757.GA6093@coredump.intra.peff.net>
 <7vlkdz4wp3.fsf@assigned-by-dhcp.cox.net> <20070702041046.GB17384@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 02 12:33:26 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5JDh-0004Io-Lz
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 12:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbXGBKdS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 06:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbXGBKdS
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 06:33:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:60463 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751963AbXGBKdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 06:33:18 -0400
Received: (qmail invoked by alias); 02 Jul 2007 10:33:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 02 Jul 2007 12:33:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199cjgIO6h9utRpmEdDmtfNhvAYeRwhkCgoWwSPJo
	0NOG0Ha8Kpwwks
X-X-Sender: gene099@racer.site
In-Reply-To: <20070702041046.GB17384@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51349>

Hi,

On Mon, 2 Jul 2007, Jeff King wrote:

> On Sun, Jul 01, 2007 at 02:54:00PM -0700, Junio C Hamano wrote:
> 
> > I would further suggest that we _require_ 'git stash save' to create a 
> > new one and perhaps make the non-subcommand case run 'git stash list'.  
> > While I was trying the code out I accidentally created a new stash 
> > when I did not mean to, which pushed the stash I wanted to apply down 
> > in the list every time I made such a mistake.
> 
> I think that makes sense...it's somehow cleaner to me if the 
> non-subcommand case doesn't make any changes (maybe just because I like 
> to explore commands by running them).

I disagree entirely.

The _only_ default subcommand for git-stash, which makes _any_ sense, is 
"save". I have run my own version of it several times, and it _literally_ 
was in those circumstances "hack, hack, hack, aargh, stash that, I'll need 
it later". "git cherry-pick stash" and "git reflog show stash" were needed 
far less.

I am utterly uninterested in the stash list.

Ciao,
Dscho
