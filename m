From: Jeff King <peff@peff.net>
Subject: Re: Advice on choosing git
Date: Thu, 13 May 2010 07:51:58 -0400
Message-ID: <20100513115158.GB10963@coredump.intra.peff.net>
References: <4BEA4B46.6010009@smartmediacorp.com>
 <201005130018.o4D0I7iI079145@kzsu.stanford.edu>
 <vpqvdasgh8d.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joe Brenner <doom@kzsu.stanford.edu>,
	Noah Silverman <noah@smartmediacorp.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 13 13:52:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCWxW-0008Tq-SF
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 13:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758119Ab0EMLwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 07:52:04 -0400
Received: from peff.net ([208.65.91.99]:51724 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082Ab0EMLwB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 07:52:01 -0400
Received: (qmail 17106 invoked by uid 107); 13 May 2010 11:52:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 13 May 2010 07:52:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 May 2010 07:51:58 -0400
Content-Disposition: inline
In-Reply-To: <vpqvdasgh8d.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146993>

On Thu, May 13, 2010 at 01:42:58PM +0200, Matthieu Moy wrote:

> Joe Brenner <doom@kzsu.stanford.edu> writes:
> 
> > You won't get any benefit out of things like "git diff" either.  The
> > diffs we have (these days at least) don't work well on anything but plain
> > text.
> 
> Not totally true. textconv filter is just great when working when
> word-processors (with the filter being odt2txt or antiword).

I agree. Whoever wrote the textconv code was a genius. ;)

But I did want to note that textconv is just _one_ way of seeing the
data. You can also have git invoke custom diff and merge handlers. I
haven't tried it, but I suspect you may be able to drive the interactive
graphical versioning found in many word processors. I thought somebody
had done some work on this, but I can't seem to dig up a link.

-Peff
