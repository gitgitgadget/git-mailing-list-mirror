From: Jeff King <peff@peff.net>
Subject: Re: Bad Man Page URLs
Date: Fri, 6 Apr 2012 01:46:37 -0400
Message-ID: <20120406054637.GA25301@sigill.intra.peff.net>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net>
 <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"David E. Wheeler" <david@justatheory.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 07:46:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG20V-0006OB-P6
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 07:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978Ab2DFFqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 01:46:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49660
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937Ab2DFFql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 01:46:41 -0400
Received: (qmail 31912 invoked by uid 107); 6 Apr 2012 05:46:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 01:46:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 01:46:37 -0400
Content-Disposition: inline
In-Reply-To: <20120406042215.GA3938@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194847>

On Thu, Apr 05, 2012 at 11:22:15PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > So I think technically the docbook part of the toolchain would be the
> > right place to fix this. But it may be easier to hack around it at the
> > asciidoc level.
> 
> Isn't this what MAN_BASE_URL in Documentation/Makefile is for?  I
> don't think a lower level fix is needed.

Thanks for a dose of sanity. Having been here so long, I sometimes think
that if something exists in git, I would already know about it. But
sometimes that is not true. :)

Junio, what do you think of building the git-manpages-* tarballs (and
the git-manpages repo) with MAN_BASE_URL set to "http://some-official-place/"?
As of now, they mention "file:///home/junio/...".

We could need to have an official place, of course. I'd rather not use
http://schacon.github.com/git/docs because these links will be embedded
in release tarballs. Maybe it is time to make http://git-scm.com/docs
happen.

-Peff
