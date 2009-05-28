From: Jeff King <peff@peff.net>
Subject: Re: Quick way to clone exactly one branch
Date: Thu, 28 May 2009 16:32:00 -0400
Message-ID: <20090528203200.GA14576@coredump.intra.peff.net>
References: <32541b130905201345h6daa84e8hb937e1e46456b3c5@mail.gmail.com> <20090528201503.GL13499@coredump.intra.peff.net> <m3ljohas9x.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 22:32:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9mH8-0003Op-SP
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 22:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759820AbZE1UcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 16:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760388AbZE1UcI
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 16:32:08 -0400
Received: from peff.net ([208.65.91.99]:56464 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857AbZE1UcH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 16:32:07 -0400
Received: (qmail 23023 invoked by uid 107); 28 May 2009 20:32:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 16:32:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 16:32:00 -0400
Content-Disposition: inline
In-Reply-To: <m3ljohas9x.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120225>

On Thu, May 28, 2009 at 01:26:05PM -0700, Jakub Narebski wrote:

> > No, AFAIK there isn't a simpler way to do it. But it is something people
> > have asked about before, so I think it would be a nice addition.
> > 
> > You can't even use "git remote" because it doesn't allow you to tweak
> > the refspecs you add. [...]
> 
> It doesn't? Strange, I thought that is what '-t <branch>' option
> for "git remote add" for ;-))))

Oh, indeed. For some reason I thought that was about setting up tracking
for branches. So yes, Avery would be much better off in his example with

    git remote add -t master origin git://whatever

But it would still be even nicer to have "clone -t master".

-Peff
