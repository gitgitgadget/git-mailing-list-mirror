From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Tue, 12 Jun 2012 08:34:54 -0400
Message-ID: <20120612123454.GA25407@sigill.intra.peff.net>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org>
 <7v1ull7j9k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: vfr@lyx.org, git@vger.kernel.org, gitster@pobox.om
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 14:35:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeQJT-0000Ga-Pk
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 14:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab2FLMfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 08:35:00 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50953
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152Ab2FLMe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 08:34:58 -0400
Received: (qmail 18655 invoked by uid 107); 12 Jun 2012 12:34:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 08:34:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 08:34:54 -0400
Content-Disposition: inline
In-Reply-To: <7v1ull7j9k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199780>

On Mon, Jun 11, 2012 at 12:15:03PM -0700, Junio C Hamano wrote:

> There was already this discussion:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/132560/focus=132561
> 
> which basically dismissed effort along this line with "If the perl
> in your PATH is so broken that it can't be used for simple helpers,
> then you should fix your PATH."

That sounds like something I would say. :)

> I personally do not mind if we do this consistently, but I am not
> sure your $PERL_PATH that is not quoted is the right way to invoke
> it; look for PERL_PATH in t/ to see the existing uses.

My biggest concern is placing an extra portability burden on
test-writers (who will inevitably forget, and won't notice because what
they are doing is only broken on obscure systems). Is there a way we can
hide this behind a perl() shell function or something?

-Peff
