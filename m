From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Tue, 1 Mar 2011 17:00:53 -0500
Message-ID: <20110301220053.GB23945@sigill.intra.peff.net>
References: <20110225133056.GA1026@sigill.intra.peff.net>
 <1298665854.27129.25.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Mar 01 23:00:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuXce-0003rx-Fq
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 23:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068Ab1CAWAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 17:00:43 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51082 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755640Ab1CAWAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 17:00:43 -0500
Received: (qmail 10848 invoked by uid 111); 1 Mar 2011 22:00:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 22:00:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 17:00:53 -0500
Content-Disposition: inline
In-Reply-To: <1298665854.27129.25.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168262>

On Fri, Feb 25, 2011 at 03:30:54PM -0500, Drew Northup wrote:

> > So your commit template looks like:
> > 
> >   subject
> > 
> >   commit message body
> >   ---
> >   notes data
> > 
> >   # usual template stuff
> > 
> > I'm curious what people think. Do others find this useful? Does it seem
> > harmful?
> > 
> 
> I'm in agreement with the others that it doesn't seem like a bad idea,
> and likely a good one. Just one thing, can you add an end-of-note
> delimiter (the same thing perhaps)? I didn't spend a long time looking
> at the code, but I can imagine more than a few ways for this to go wrong
> without one.

We could add one pretty easily, but I'm not sure what you would be
delimiting it from. Can you describe a case where it would be useful?

-Peff
