From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: print progress
Date: Thu, 3 Nov 2011 17:18:19 -0400
Message-ID: <20111103211819.GA17341@sigill.intra.peff.net>
References: <20111103033325.GA10230@sigill.intra.peff.net>
 <1320310234-11243-1-git-send-email-pclouds@gmail.com>
 <20111103193826.GB19483@sigill.intra.peff.net>
 <7vd3d9f0u8.fsf@alter.siamese.dyndns.org>
 <20111103195147.GA21318@sigill.intra.peff.net>
 <7v8vnxeyrp.fsf@alter.siamese.dyndns.org>
 <20111103202954.GC19483@sigill.intra.peff.net>
 <7vwrbhdixe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 22:18:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM4g9-0000ep-49
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 22:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab1KCVSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 17:18:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33042
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321Ab1KCVSY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 17:18:24 -0400
Received: (qmail 28149 invoked by uid 107); 3 Nov 2011 21:24:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Nov 2011 17:24:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2011 17:18:19 -0400
Content-Disposition: inline
In-Reply-To: <7vwrbhdixe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184748>

On Thu, Nov 03, 2011 at 01:56:13PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So you would agree that we are better summing the objects for all packs
> > and showing one big progress bar?
> 
> If it can be done without sacrificing the clarity of the code, compared to
> the "we will do new and smaller ones first so in practice it does not
> matter" approach taken by the patch in question, I would not mind it, but
> to be honest, I do not deeply care either way.

I looked briefly at doing this. It's a little annoying with the
verify_packs code, because you have to pass around the "how far are we
into the progress" counter separately. But I confess I don't care that
much either way, either. With the two minor fixups I sent in my original
review, I think Duy's patch would be OK by me.

-Peff
