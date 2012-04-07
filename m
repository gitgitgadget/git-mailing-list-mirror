From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Sat, 7 Apr 2012 03:51:50 -0400
Message-ID: <20120407075150.GA18168@sigill.intra.peff.net>
References: <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <vpqty12h995.fsf@bauges.imag.fr>
 <20120405131301.GB10293@sigill.intra.peff.net>
 <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
 <4F7FF19B.1060407@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Apr 07 09:52:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGQRC-0006pG-5p
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 09:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab2DGHvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 03:51:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53217
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab2DGHvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 03:51:53 -0400
Received: (qmail 20870 invoked by uid 107); 7 Apr 2012 07:51:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Apr 2012 03:51:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Apr 2012 03:51:50 -0400
Content-Disposition: inline
In-Reply-To: <4F7FF19B.1060407@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194941>

On Sat, Apr 07, 2012 at 09:49:47AM +0200, Michael Haggerty wrote:

> Exactly.  Choosing between "current vs upstream" is a false dichotomy.
> 
> Let's create a new "push.default" option (call it "beginner" for the
> sake of discussion) that is intended for use *only* for people who
> haven't explicitly chosen another alternative.  Let the "beginner"
> option do the obvious thing when it is uncontroversial and
> undangerous, and let it output a beginner-level help message in any
> scenarios where the right thing to do is not obvious.  The help
> message should basically recommend that the user run "git config
> push.default VALUE" and explain the meaning of the possible VALUEs.
> 
> If "push.default" is not set, then have it default to "beginner" mode.

I would be fine with that (I've suggested it elsewhere in the thread,
though I think I stole the idea originally from you. Speaking of going
in circles. :) ).

-Peff
