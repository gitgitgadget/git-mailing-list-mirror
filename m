From: Jeff King <peff@peff.net>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Fri, 11 Feb 2011 14:45:41 -0500
Message-ID: <20110211194541.GA32023@sigill.intra.peff.net>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
 <AANLkTikrVPCr92XHirn1u=73eM--T190V-7nbE6fo8ng@mail.gmail.com>
 <201102111240.29746.johan@herland.net>
 <20110211190326.GB29203@sigill.intra.peff.net>
 <7v4o8a1i6k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, skillzero@gmail.com,
	git@vger.kernel.org, John Wiegley <johnw@boostpro.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 20:45:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnyw9-0000kP-NY
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 20:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758016Ab1BKTpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 14:45:44 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60446 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757264Ab1BKTpn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 14:45:43 -0500
Received: (qmail 27510 invoked by uid 111); 11 Feb 2011 19:45:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 11 Feb 2011 19:45:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Feb 2011 14:45:41 -0500
Content-Disposition: inline
In-Reply-To: <7v4o8a1i6k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166571>

On Fri, Feb 11, 2011 at 11:32:03AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Exactly. One other possible solution to this problem would be to somehow
> > make patch-ids handle fuzzy situations better. I doubt it is possible to
> > do that without introducing a lot of false positives, though.
> 
> We need to remember that we would want to tolerate _no_ false positive.

Yeah, I agree with everything you say here. My original message should
have been s/a lot of// in the last line.

-Peff
