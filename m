From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Define $PERL_PATH in test-lib.sh
Date: Wed, 11 Nov 2009 03:43:16 -0500
Message-ID: <20091111084316.GA1799@sigill.intra.peff.net>
References: <1257850011-7544-1-git-send-email-book@cpan.org>
 <4AF95C0D.90605@viscovery.net>
 <20091110133427.GC8896@plop>
 <7v7hty6so9.fsf@alter.siamese.dyndns.org>
 <20091111084014.GE8896@plop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 09:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N88nT-0007aM-Pn
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 09:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbZKKInN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 03:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbZKKInM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 03:43:12 -0500
Received: from peff.net ([208.65.91.99]:37505 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbZKKInM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 03:43:12 -0500
Received: (qmail 11162 invoked by uid 107); 11 Nov 2009 08:47:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 11 Nov 2009 03:47:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Nov 2009 03:43:16 -0500
Content-Disposition: inline
In-Reply-To: <20091111084014.GE8896@plop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132622>

On Wed, Nov 11, 2009 at 09:40:14AM +0100, Philippe Bruhat (BooK) wrote:

> > Hmm, but that means two separate definitions in ./Makefile and
> > t/test-lib.sh must be kept in sync forever, and there is not even a
> > comment next to the line that requires such care in your patch to help
> > people who might want to change these lines in the future.
> 
> Is there a way to obtain whatever value was computed in the Makefile,
> or should I just add a comment in all-caps saying "keep this in sync
> with the default value in the top level Makefile"? (and a more detailed
> commit message)

Yes. Did you miss the second half of my other message?

  http://article.gmane.org/gmane.comp.version-control.git/132561

-Peff
