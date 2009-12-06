From: Jeff King <peff@peff.net>
Subject: Re: clang static analyzer
Date: Sun, 6 Dec 2009 11:04:36 -0500
Message-ID: <20091206160436.GA7140@coredump.intra.peff.net>
References: <33ABC714-2BCC-4910-BCAE-D331AAF2A724@dbservice.com>
 <20091206145744.GA6725@coredump.intra.peff.net>
 <alpine.LFD.2.00.0912061032380.31174@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tomas Carnecky <tom@dbservice.com>, git list <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 17:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHJbH-0000Ei-Eg
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 17:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbZLFQEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 11:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754868AbZLFQEc
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 11:04:32 -0500
Received: from peff.net ([208.65.91.99]:37225 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860AbZLFQEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 11:04:31 -0500
Received: (qmail 30576 invoked by uid 107); 6 Dec 2009 16:09:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Dec 2009 11:09:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Dec 2009 11:04:36 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912061032380.31174@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134668>

On Sun, Dec 06, 2009 at 10:39:56AM -0500, Nicolas Pitre wrote:

> >   2. If it is a false positive, see what it would take to silence clang
> >      and submit a patch.  I don't think we are opposed to annotations
> >      that help analysis tools as long as those annotations aren't too
> >      intrusive or make the code less readable.
> 
> I'm a bit skeptical here.  Going down that route might mean that we'll 
> eventually have to add all sort of crap to accommodate everyone's 
> preferred static analysis tool of the day.  Would be far nicer to try to 
> make those tools more intelligent instead, or at least make them 
> understand an out-of-line annotation format that does not clutter the 
> code itself.

To be clear, I am a bit skeptical, too. I would really prefer an
out-of-line annotation if one is available. But I am trying to encourage
the OP to actually make a patch for one instance so we can see just what
it would look like. Then we actually have a data point to discuss.

-Peff
