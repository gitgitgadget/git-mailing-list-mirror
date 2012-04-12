From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Thu, 12 Apr 2012 03:11:51 -0400
Message-ID: <20120412071150.GB31122@sigill.intra.peff.net>
References: <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <vpqty12h995.fsf@bauges.imag.fr>
 <20120405131301.GB10293@sigill.intra.peff.net>
 <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
 <4F7FF19B.1060407@alum.mit.edu>
 <20120407075150.GA18168@sigill.intra.peff.net>
 <4F7FFD7A.80104@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 09:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIECD-0008RD-TV
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 09:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762078Ab2DLHLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 03:11:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58374
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757468Ab2DLHLx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 03:11:53 -0400
Received: (qmail 24115 invoked by uid 107); 12 Apr 2012 07:11:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 03:11:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 03:11:51 -0400
Content-Disposition: inline
In-Reply-To: <4F7FFD7A.80104@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195306>

On Sat, Apr 07, 2012 at 09:40:26AM +0100, Andrew Sayers wrote:

> On a slight aside, should we add @{downstream} to describe the opposite
> of @{upstream}?  Seeing that around the place would give intermediate
> users a clue about why pull and push aren't as related as they think,
> and would be useful here and there in code (e.g. __git_ps1 could show a
> better bash prompt with GIT_PS1_SHOWUPSTREAM).

Maybe. I don't really see how it is useful, but maybe you want to flesh
our your proposal with some examples? I do not use __git_ps1, so I'm not
sure what you want to improve there.

-Peff
