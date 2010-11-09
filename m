From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Tue, 9 Nov 2010 11:10:18 -0500
Message-ID: <20101109161015.GB24975@sigill.intra.peff.net>
References: <20101109083023.783fad9b@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>, kevin@sb.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Tue Nov 09 17:09:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFqlD-0003jE-Ra
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 17:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab0KIQJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 11:09:23 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49704 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab0KIQJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 11:09:22 -0500
Received: (qmail 7819 invoked by uid 111); 9 Nov 2010 16:09:21 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Nov 2010 16:09:21 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Nov 2010 11:10:18 -0500
Content-Disposition: inline
In-Reply-To: <20101109083023.783fad9b@chalon.bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161057>

On Tue, Nov 09, 2010 at 08:30:23AM +0100, Yann Dirson wrote:

> Jeff wrote:
> > It seems to me the natural way to do that would be to use our existing
> > generic "start at this ref and follow some chain" syntax, which is
> > ref^{foo}. For example: origin/pu^{:Merge 'kb/blame-author-email'}.
> 
> We may want to keep the "/" mnemonic (which seems no to conflict
> withcurrent use either), rather than the ":" part, with something like
> origin/pu^{/Merge 'kb/blame-author-email'}, and keep ":" for future use.

Yeah, sorry, the ':' thing was just a think-o on my part. It should
definitely be "/".

> > We also have ref@{upstream}. The analogue here would be
> > origin/pu@{:Merge 'kb/blame-author-email'}.
> 
> That's somewhat different, it looks like the foo@{...} only applies to
> references with name "foo", and not to arbitrary revisions.  Allowing a
> search to start from any commit seems more useful here.

Yeah, agreed.

-Peff
