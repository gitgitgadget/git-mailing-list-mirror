From: Jeff King <peff@peff.net>
Subject: Re: Using really empty start prefixes for git-format-patch numbered
 patches?
Date: Mon, 30 May 2011 16:23:02 -0400
Message-ID: <20110530202302.GA29811@sigill.intra.peff.net>
References: <BANLkTikVQWN2kZ4gc8kd-kJWZhLXgkvTAA@mail.gmail.com>
 <20110530141905.GA31490@sigill.intra.peff.net>
 <7voc2km1xh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Delanoy <frederic.delanoy@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 22:23:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR8zZ-0006Ds-FA
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 22:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124Ab1E3UXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 16:23:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46587
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab1E3UXF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 16:23:05 -0400
Received: (qmail 19577 invoked by uid 107); 30 May 2011 20:23:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 May 2011 16:23:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 May 2011 16:23:02 -0400
Content-Disposition: inline
In-Reply-To: <7voc2km1xh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174775>

On Mon, May 30, 2011 at 12:19:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't think there is currently a way to do what you want short of
> > post-processing the output of format-patch. You can use "-k" to preserve
> > the subject, but then you don't get the "1/2" that you want.
> 
> You would unconditionally get "[" and "]" that you may or may not want and
> there is no way to change it to "(1/2)" or "1 of 2: "; unless we shoot for
> a completely flexible solution, we need to draw a line somewhere.

Hmm, yeah, I guess we could go farther pretty simply with:

  git format-patch --subject='[PATCH %n/%m] %s'

but I admit I don't really care enough to work on it. :)

> Will queue; thanks.

Thanks.

-Peff
