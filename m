From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t0300: use write_script helper
Date: Sat, 4 Feb 2012 02:00:09 -0500
Message-ID: <20120204070009.GA22188@sigill.intra.peff.net>
References: <20120204062712.GA20076@sigill.intra.peff.net>
 <20120204063018.GB21559@sigill.intra.peff.net>
 <7vd39vjda9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 08:00:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtZbf-0008KT-Ii
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 08:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405Ab2BDHAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 02:00:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57332
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab2BDHAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 02:00:11 -0500
Received: (qmail 6922 invoked by uid 107); 4 Feb 2012 07:07:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Feb 2012 02:07:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Feb 2012 02:00:09 -0500
Content-Disposition: inline
In-Reply-To: <7vd39vjda9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189855>

On Fri, Feb 03, 2012 at 10:58:06PM -0800, Junio C Hamano wrote:

> > diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> > index 885af8f..0b46248 100755
> > --- a/t/t0300-credentials.sh
> > +++ b/t/t0300-credentials.sh
> > @@ -14,14 +14,13 @@ test_expect_success 'setup helper scripts' '
> >  	done
> >  	EOF
> >  
> > -	cat >git-credential-useless <<-\EOF &&
> > +	write_script git-credential-useless <<-\EOF &&
> >  	#!/bin/sh
> 
> An innocuous facepalm I'd be glad to remove myself ;-)

Heh, it took me a second to notice it, even after you mentioned it. And
it's even right there in the context. At least the line written by
write_script takes precedence. :)

Thanks.

-Peff
