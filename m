From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-difftool: allow skipping file by typing 'n' at prompt
Date: Tue, 4 Oct 2011 13:49:37 -0400
Message-ID: <20111004174937.GA31671@sigill.intra.peff.net>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
 <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 19:49:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB97g-00008D-EJ
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 19:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933120Ab1JDRtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 13:49:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52259
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933050Ab1JDRtk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 13:49:40 -0400
Received: (qmail 10144 invoked by uid 107); 4 Oct 2011 17:54:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 13:54:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 13:49:37 -0400
Content-Disposition: inline
In-Reply-To: <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182781>

On Tue, Oct 04, 2011 at 08:25:07AM -0700, Junio C Hamano wrote:

> Sitaram Chamarty <sitaram@atc.tcs.com> writes:
> 
> > Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
> > ---
> >
> > I'm using what is pretty much a universal convention to
> > signify that the default choice is "y"; I hope documentation
> > for something so small is not needed but if it is, let me
> > know and I'll do that also.
> >
> > -			printf "Hit return to launch '%s': " \
> > +			printf "Launch '%s' [y]/n: " \
> 
> I think I've seen this done as: "do this? [Y/n]" elsewhere.
> 
> Not telling you what to do, but trying to feel what others may think.

Yes, that was my immediate thought, too (or even [Yn]).

-Peff
