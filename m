From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] blame: Add option to show author email instead of
 name
Date: Thu, 21 Oct 2010 16:58:59 -0400
Message-ID: <20101021205859.GA29550@sigill.intra.peff.net>
References: <7vsk02ypj5.fsf@alter.siamese.dyndns.org>
 <1287535323-20347-1-git-send-email-kevin@sb.org>
 <20101021180525.GA11501@burratino>
 <79AB0864-E151-468E-9C86-EBCAD929938B@sb.org>
 <20101021203210.GA12685@burratino>
 <20101021205358.GA29377@sigill.intra.peff.net>
 <1D51CC29-0248-4C12-BD1B-4013434AEA03@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:58:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P92DN-0003aO-V2
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482Ab0JUU6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:58:17 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48642 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab0JUU6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 16:58:16 -0400
Received: (qmail 12439 invoked by uid 111); 21 Oct 2010 20:58:16 -0000
Received: from 129-79-255-184.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.184)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 21 Oct 2010 20:58:16 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Oct 2010 16:58:59 -0400
Content-Disposition: inline
In-Reply-To: <1D51CC29-0248-4C12-BD1B-4013434AEA03@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159569>

On Thu, Oct 21, 2010 at 01:54:22PM -0700, Kevin Ballard wrote:

> > Isn't that what it is already?
> > 
> >  $ grep blame builtin/annotate.c
> >  return cmd_blame(argc + 1, nargv, prefix);
> 
> IIRC, git-annotate is equivalent to `git blame -c`, which is why the
> tests for git-blame are so useless (they're all tests for `git blame
> -c`, which makes them identical to the tests for git-annotate).

Yeah, I believe that t8002 is totally redundant with t8001 these days. I
wonder if we should just drop t8001 entirely.

The other blame tests use the "native" format. It would be nice to have
some --porcelain and --incremental tests, too, but I expect it is too
boring for anyone to volunteer to work on. :)

-Peff
