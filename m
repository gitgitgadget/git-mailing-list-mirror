From: Jeff King <peff@peff.net>
Subject: Re: Incorrect v1.7.10.4 tag on github?
Date: Mon, 2 Jul 2012 16:08:15 -0400
Message-ID: <20120702200815.GA3179@sigill.intra.peff.net>
References: <77A5E1CD-836A-4747-9E62-42C25C0D8B7D@sfu.ca>
 <20120615182534.GB14843@sigill.intra.peff.net>
 <7vvcis9ylx.fsf@alter.siamese.dyndns.org>
 <CAPBPrnspD3uC6_wd7nqMUVgHSt4Frwy8UaYL6fU73kJKX6=XWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Graham Ballantyne <grahamb@sfu.ca>, git@vger.kernel.org
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 22:08:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slmv3-0004wa-3c
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 22:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab2GBUIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 16:08:19 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51766
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754Ab2GBUIS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 16:08:18 -0400
Received: (qmail 11981 invoked by uid 107); 2 Jul 2012 20:08:25 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jul 2012 16:08:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2012 16:08:15 -0400
Content-Disposition: inline
In-Reply-To: <CAPBPrnspD3uC6_wd7nqMUVgHSt4Frwy8UaYL6fU73kJKX6=XWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200859>

On Mon, Jul 02, 2012 at 03:52:31PM -0400, Dan Johnson wrote:

> > It builds correctly if you download the tarball from the official
> > location in the [ANNOUNCE] message.  This is because the build
> > procedure for the official tarball does a bit more than just running
> > "git archive-tar", which is what gitweb download interface does
> > (namely, it adds the correct "version" file).
> 
> I just noticed that the download buttons (for tarballs) on gitscm.com
> all point to the github tag list ( https://github.com/git/git/tags )
> instead of the location pointed to by your [ANNOUNCE] message (
> http://code.google.com/p/git-core/downloads/list )

Ick. Yeah, I would think it would definitely want to point to Junio's
built tarballs, because they contain the built 'configure' script.
Otherwise, the downloader would need to have autoconf installed if they
wanted to use configure.

> If you do something special as part of releasing these tarballs, is
> this something that should be corrected? I can look at the source and
> do a pull request for gitscm.com a little later, if needed.

I suspect that the tarballs link on git-scm.com should at the very least
point to:

  http://code.google.com/p/git-core/downloads/list

That list is a little overwhelming because it contains the html and
manpage tarballs, too. It might make sense to provide a cut-down list
(e.g., only source tarballs, and only the latest for each minor version,
and omit -rc candidates for already-released versions). But that would
be a lot more involved.

-Peff
