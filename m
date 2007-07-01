From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document git-stash
Date: Sun, 1 Jul 2007 23:57:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707012355150.4438@racer.site>
References: <Pine.LNX.4.64.0706301853400.4438@racer.site>
 <200707010533.l615XiH6006728@mi1.bluebottle.com> <20070701080757.GA6093@coredump.intra.peff.net>
 <7vlkdz4wp3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 00:57:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I58ME-0005HJ-Mn
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 00:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbXGAW52 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 18:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbXGAW52
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 18:57:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:52957 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751732AbXGAW51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 18:57:27 -0400
Received: (qmail invoked by alias); 01 Jul 2007 22:57:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 02 Jul 2007 00:57:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KvDQ8+HQKIPNKYHv/y9zS266iq4p7DTFtTsY7JE
	h7WDmUnOG8SIpU
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlkdz4wp3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51328>

Hi,

On Sun, 1 Jul 2007, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> +(no subcommand)::
> >> +
> >> +	Save your local modifications to a new 'stash', and run `git-reset
> >> +	--hard` to revert them.
> >
> > For orthogonality's sake, should this be 'git-stash save', aliased to
> > just 'git-stash'? It would make this heading a little more intuitive,
> > and the very first paragraph (describing all of the modes) a little more
> > clear.
> 
> I would further suggest that we _require_ 'git stash save' to
> create a new one and perhaps make the non-subcommand case run
> 'git stash list'.  While I was trying the code out I
> accidentally created a new stash when I did not mean to, which
> pushed the stash I wanted to apply down in the list every time I
> made such a mistake.

Well, the normal thing you want to do if you say "git stash" is best 
described by "Git, stash!".

However, unstash would by a nice feature. Not easy, but nice. Not easy, 
because we would be actively outsmarting the reflog machinery we use for 
the stash.

Ciao,
Dscho
