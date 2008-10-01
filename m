From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Wed, 1 Oct 2008 11:25:46 -0400
Message-ID: <20081001152546.GB4962@coredump.intra.peff.net>
References: <20080921104238.GA9217@sigill.intra.peff.net> <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl> <20080929224430.GA11545@sigill.intra.peff.net> <48E1C39F.4070906@op5.se> <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com> <20080930070938.GA14757@sigill.intra.peff.net> <48E1F87D.2010906@op5.se> <20081001031400.GA24513@coredump.intra.peff.net> <48E3312E.4090601@op5.se> <20081001151011.GA21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, Wincent Colaiuta <win@wincent.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:28:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3bi-0001AX-Ps
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbYJAPZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbYJAPZw
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:25:52 -0400
Received: from peff.net ([208.65.91.99]:4194 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337AbYJAPZs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:25:48 -0400
Received: (qmail 19348 invoked by uid 111); 1 Oct 2008 15:25:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 01 Oct 2008 11:25:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2008 11:25:46 -0400
Content-Disposition: inline
In-Reply-To: <20081001151011.GA21310@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97236>

On Wed, Oct 01, 2008 at 08:10:11AM -0700, Shawn O. Pearce wrote:

> Actually I rather like the patch you submitted yesterday:
> 
>         normal case
>         Created abc9056 (i386: Snib the sprock) on i386
> 
>         detached head
>         Created DETACHED commit abc9056 (i386: Snib the sprock)
> 
>         initial commit
>         Created root-commit abc9056 (i386: Snib the sprock) on i386
> 
> The detached HEAD and root-commit cases are clearly denoted at the
> very start of the line, where your eyes are likely to start scanning
> from first before you say "Doh, its just line noise because Git wants
> a pat on the back for doing what I asked".  Thus you are likely
> to notice something out of the ordinary (commit on detached HEAD)
> pretty quick.

I agree with your assumption that people scan the line from left to
right, and that the most important stuff should come first. So that
format covers _those_ cases, but not the case of "oops, I committed on
a different branch than I intended." So I think it really makes sense
to keep the branch name on the left side, and the commit subject last.

> Right now I'm happy with your patch in next.  I don't like taking
> the paint brush away from folks, but I also don't want to be applying
> a ton of commit message reformatting patches over the next week.  ;-)

Welcome to maintainership. ;P

-Peff
