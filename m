From: Jeff King <peff@peff.net>
Subject: Re: `./configure --XXdir=` ignored?
Date: Thu, 26 Feb 2009 10:15:35 -0500
Message-ID: <20090226151535.GA17402@coredump.intra.peff.net>
References: <c115fd3c0902260648g3cc9bfeap58823e53a9dc72e6@mail.gmail.com> <20090226150013.GA9785@coredump.intra.peff.net> <c115fd3c0902260709i21efa98am1e8b55462e1a5d66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 16:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lchz0-0006hs-RD
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 16:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbZBZPPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 10:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230AbZBZPPj
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 10:15:39 -0500
Received: from peff.net ([208.65.91.99]:56706 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbZBZPPi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 10:15:38 -0500
Received: (qmail 5538 invoked by uid 107); 26 Feb 2009 15:16:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Feb 2009 10:16:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2009 10:15:35 -0500
Content-Disposition: inline
In-Reply-To: <c115fd3c0902260709i21efa98am1e8b55462e1a5d66@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111572>

On Thu, Feb 26, 2009 at 10:09:57AM -0500, Tim Visher wrote:

> On Thu, Feb 26, 2009 at 10:00 AM, Jeff King <peff@peff.net> wrote:
> 
> > The configure support is notoriously incomplete
> 
> Would it be easier for me to just build the documentation and then
> install it by hand then?  Is that even possible?

No, there's Makefile support:

  make htmldir=/path/to/wherever install-html

but the autoconf stuff wasn't hooking into it properly (which is what
the patch I sent should do).

What I meant by "incomplete" is that most people just use the Makefile
directly without autoconf, so we never notice when bugs like this are
hiding. Thus the bugs tend to hang around for a while until somebody
submits a patch (which I was hoping you would do after getting it to
work).

-Peff
