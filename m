From: Jeff King <peff@peff.net>
Subject: Re: RFD: tables in documentation
Date: Tue, 25 May 2010 05:46:21 -0400
Message-ID: <20100525094621.GA984@coredump.intra.peff.net>
References: <4BDC74F3.2020206@drmicha.warpmail.net>
 <20100502050622.GF14776@coredump.intra.peff.net>
 <4BDD7E96.2050603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 25 11:46:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGqiW-0001hb-0k
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422Ab0EYJq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:46:27 -0400
Received: from peff.net ([208.65.91.99]:52878 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755172Ab0EYJq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:46:26 -0400
Received: (qmail 18793 invoked by uid 107); 25 May 2010 09:46:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 May 2010 05:46:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 May 2010 05:46:21 -0400
Content-Disposition: inline
In-Reply-To: <4BDD7E96.2050603@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147704>

[This is an old message, but I'm going through some old threads on my
todo, and I owed you a response.]

On Sun, May 02, 2010 at 03:31:02PM +0200, Michael J Gruber wrote:

> > Conceptually I am in favor of semantic markup where possible. I find the
> > resulting manpage a little harder to read, though. Is it possible for us
> > to style it a bit more (e.g., such a simple table looks better, IMHO,
> > without ascii-art borders).
> 
> I really don't know (about styling docbook's tables). We can easily
> switch off the outer borders in AsciiDoc.

I do think the border-less table that you presented later in the thread
looks good, modulo the row-span issue.

And:

> > Did you put the source up anywhere? I didn't see it, but it would be
> > interesting to see how painful it is to write.
> 
> http://repo.or.cz/w/git/mjg.git/shortlog/refs/heads/doc-use-tables

I think the source remains pretty readable.

So assuming you can solve the row-span problem, I think it is a
positive change.

> The docbook part of the toolchain makes me sick whenever I have to look
> at it. I really wish AsciiDoc could output roff straight away. I find it

Yes, I have also wished for that many times.

-Peff
