From: Jeff King <peff@peff.net>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 15:01:59 -0400
Message-ID: <20080819190159.GB17943@coredump.intra.peff.net>
References: <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7vtzdiklbw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181839390.19665@iabervon.org> <7vy72tit90.fsf@gitster.siamese.dyndns.org> <20080819175220.GA10142@coredump.intra.peff.net> <alpine.LNX.1.00.0808191407160.19665@iabervon.org> <20080819184525.GA17691@coredump.intra.peff.net> <alpine.LNX.1.00.0808191448530.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWUR-00025b-EG
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbYHSTCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756176AbYHSTCD
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:02:03 -0400
Received: from peff.net ([208.65.91.99]:2006 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032AbYHSTCB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:02:01 -0400
Received: (qmail 4247 invoked by uid 111); 19 Aug 2008 19:02:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Aug 2008 15:02:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2008 15:01:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0808191448530.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92905>

On Tue, Aug 19, 2008 at 02:57:04PM -0400, Daniel Barkalow wrote:

> Humans being recipients of emails, or humans being the users who typed the 
> command? Unless you're cut-and-pasting out of a pager (which never works 

I meant the recipients of the emails.

> well for me if it's long enough to include diff headers, context, and some 
> change), recipients of emails would get what scripts get. (I personnaly do 
> that as "git diff > temp.patch" and read temp.patch into my mailer; this 
> doesn't trigger starting a pager, and wouldn't trigger the default to be 
> informative prefixes.)

OK, I didn't read your mail carefully enough. Yes, I do the same thing,
so the "do this only if pager" rule would meet my requirement. OTOH, I
don't know if that would satisfy the people who want this feature (but I
will let them speak for themselves).

> Yeah, that's why I think that format-patch should work on content that you 
> haven't committed, generating something you can dump right into an email 
> (with the --- and diffstat that you'd get if you actually did commit and 
> use format-patch now).

It's not clear to me:

  - how you would tell format-patch that's what you wanted to dump

  - what parts would be included. There's no commit message or author.
    We could guess at the author as if you were about to commit this.

  - how this would be any real improvement over "git diff --stat -p". In
    fact, I like the fact that I get _just_ the diff, which I then
    paste. The headers would just be clutter I would have to delete.

-Peff
