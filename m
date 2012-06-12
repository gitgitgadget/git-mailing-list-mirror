From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Tue, 12 Jun 2012 10:59:37 -0400
Message-ID: <20120612145937.GA9200@sigill.intra.peff.net>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org>
 <7v1ull7j9k.fsf@alter.siamese.dyndns.org>
 <20120612123454.GA25407@sigill.intra.peff.net>
 <7v4nqg4lzb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: vfr@lyx.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 16:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeSZL-0005jw-No
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab2FLO7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 10:59:40 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51054
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab2FLO7j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 10:59:39 -0400
Received: (qmail 20771 invoked by uid 107); 12 Jun 2012 14:59:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 10:59:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 10:59:37 -0400
Content-Disposition: inline
In-Reply-To: <7v4nqg4lzb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199799>

On Tue, Jun 12, 2012 at 07:56:56AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> I personally do not mind if we do this consistently, but I am not
> >> sure your $PERL_PATH that is not quoted is the right way to invoke
> >> it; look for PERL_PATH in t/ to see the existing uses.
> >
> > My biggest concern is placing an extra portability burden on
> > test-writers (who will inevitably forget, and won't notice because what
> > they are doing is only broken on obscure systems). Is there a way we can
> > hide this behind a perl() shell function or something?
> 
> I am hoping that writing 'perl' without any adornment will hopefully
> stand out like a sore thumb if all perl invocations in existing code
> are spelled '"$PERL_PATH"'.  We forbid "! git cmd" and tell people
> to write "test_must_fail git cmd" instead, and I think it has worked
> reasonably well.

I am not confident, but I guess we will see. :)

-Peff
