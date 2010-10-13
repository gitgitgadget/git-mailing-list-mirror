From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Hidden refs
Date: Wed, 13 Oct 2010 13:46:48 -0400
Message-ID: <20101013174647.GB13752@sigill.intra.peff.net>
References: <4CB5CEA3.8020702@xiplink.com>
 <20101013173555.GA13188@sigill.intra.peff.net>
 <7vvd56m1ke.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 19:46:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65PL-0007Wr-Vw
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab0JMRq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 13:46:26 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38426 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782Ab0JMRq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:46:26 -0400
Received: (qmail 493 invoked by uid 111); 13 Oct 2010 17:46:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.167)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 13 Oct 2010 17:46:25 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 13:46:48 -0400
Content-Disposition: inline
In-Reply-To: <7vvd56m1ke.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158950>

On Wed, Oct 13, 2010 at 10:42:41AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I believe "." at the front of a directory component is explicitly
> > forbidden by check_ref_format. I don't recall whether there was a
> > specific rationale, or whether it was simply a can of worms we didn't
> > want to explore.
> 
> Is "log foo...bar" a symmetric difference between foo and bar, or is it an
> assymmetric one from foo and .bar?

Thanks, I was sure there was a simple example of how it would make
things ambiguous, but for some reason I couldn't think of one.

-Peff
