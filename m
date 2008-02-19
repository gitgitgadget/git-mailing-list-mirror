From: Jeff King <peff@peff.net>
Subject: Re: git push [rejected] question
Date: Tue, 19 Feb 2008 10:25:49 -0500
Message-ID: <20080219152549.GC24499@sigill.intra.peff.net>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com> <20080219043353.GA23239@sigill.intra.peff.net> <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com> <20080219150826.GA24499@sigill.intra.peff.net> <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jason Garber <jgarber@ionzoft.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 16:26:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRUMU-0008I2-NM
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 16:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbYBSPZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 10:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbYBSPZw
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 10:25:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1520 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003AbYBSPZv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 10:25:51 -0500
Received: (qmail 21734 invoked by uid 111); 19 Feb 2008 15:25:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 19 Feb 2008 10:25:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 10:25:49 -0500
Content-Disposition: inline
In-Reply-To: <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74417>

On Tue, Feb 19, 2008 at 10:18:09AM -0500, Jay Soffian wrote:

> I'd like to nominate you to rewrite all of the git documentation from
> scratch. :-) Your explanations are extremely clear.

Doh! This is why nobody writes clear explanations: it gets you nominated
for more work. ;)

> > > It seems like the default should be to push just the current branch
> > > ... this would correspond to what a user of git pull expects (even
> > > though the converse of git-push is really git-fetch, for a new user,
> > > that might not be entirely clear).
> >
> > I agree with you, but others do not
> 
> Sounds like an opportunity for a config option.

Again I agree, though I think there is some resistance to that (see the
thread I mentioned). Junio's opinion seems to be "why can't they just
use 'git push <remote> HEAD'?" (and he suggested a 'git push HEAD'
shorthand syntax, as well).

But then, nobody has put forth a patch, so I think if you wanted to
argue it, the best way would be to do so (though I think it would be
rejected, it would give those who wanted to try it something to play
with).

-Peff
