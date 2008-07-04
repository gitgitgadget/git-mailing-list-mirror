From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: git sequencer prototype
Date: Sat, 5 Jul 2008 00:23:53 +0200
Message-ID: <20080704222353.GC28515@leksak.fem-net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <20080704210052.GA6984@steel.home> <7vwsk1ti6y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 00:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEtiC-00021L-1q
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 00:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbYGDWYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 18:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbYGDWYG
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 18:24:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:58312 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751525AbYGDWYF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 18:24:05 -0400
Received: (qmail invoked by alias); 04 Jul 2008 22:24:02 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp002) with SMTP; 05 Jul 2008 00:24:02 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/sQColSeDstLiwaQoHJCpcBEUhEoVXXYyJktz1uo
	nYhZ8NcdBLcMHG
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KEth3-0000ux-5n; Sat, 05 Jul 2008 00:23:53 +0200
Content-Disposition: inline
In-Reply-To: <7vwsk1ti6y.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87422>

Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
> > BTW, how about renaming it in something short: git seq. There is
> > already a seq(1) in GNU coreutils, which does roughly the same (prints
> > a sequence of numbers), why not reuse the name?
> 
> Is it advantageous to use shorter but less descriptive name for this
> command?

I also think descriptive names are nice for git even if the user should
type that, since tab completion exists.
When I've started with git, I loved the fact that I could use tab
completion to learn new git commands and that often the name was
descriptive enough to get an imagination of what the tool could do (and
then read the manpage to verify...)

> It will be a backend to am/rebase and not something the users
> will type from the command line, won't it?

Usually, but for special cases it is also nicely usable by the user
and the --status and --edit subcommands are intended to be used by the
user, too.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
