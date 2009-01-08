From: Jeff King <peff@peff.net>
Subject: Re: Comments on Presentation Notes Request.
Date: Thu, 8 Jan 2009 04:56:03 -0500
Message-ID: <20090108095603.GA16136@coredump.intra.peff.net>
References: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com> <20090107063629.GB22616@coredump.intra.peff.net> <alpine.LNX.1.00.0901071654530.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Visher <tim.visher@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 10:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKrdo-0001on-Ka
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 10:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbZAHJ4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 04:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbZAHJ4I
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 04:56:08 -0500
Received: from peff.net ([208.65.91.99]:55673 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569AbZAHJ4G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 04:56:06 -0500
Received: (qmail 6021 invoked by uid 107); 8 Jan 2009 09:56:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Jan 2009 04:56:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Jan 2009 04:56:03 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0901071654530.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104911>

On Wed, Jan 07, 2009 at 05:30:04PM -0500, Daniel Barkalow wrote:

> > So yes, you are much more likely to salvage useful (if not all) data
> > from developer repositories in the event of a crash. But I still think
> > it's crazy not to have a backup strategy for your DVCS repo.
> 
> I think it's very important to have a backup strategy, but it's nice that 
> the developers can get work done while the server is still down.

I think everything you said in your email was correct, and I agree with
it, but I just wanted to clarify one thing about what I said.

I really _do_ think you are better off in a disaster or backup situation
with a DVCS. Both this past year and 2007, Junio dropped off the face of
the git planet for a few weeks, and everyone seamlessly switched to
Shawn as maintainer. So I think of the DVCS model almost more as "high
availablity": even if you model your workflow around a central server,
it's easy to route around the failure.

It's just that I don't think these features totally _replace_ backups as
a concept. And I feel like that notion creeps up now and again in the
centralized versus distributed holy wars.

So I think we agree; I just wasn't sure if I gave the wrong impression
from my first email.

-Peff
