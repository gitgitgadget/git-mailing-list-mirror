From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: fix --max-count when used together with -S or -G
Date: Thu, 10 Mar 2011 17:39:34 -0500
Message-ID: <20110310223934.GF15828@sigill.intra.peff.net>
References: <7vvczte7tw.fsf@alter.siamese.dyndns.org>
 <1299703935-639-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110309213824.GA4400@sigill.intra.peff.net>
 <7vk4g87wvf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:39:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxoWD-0001xv-Io
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 23:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab1CJWjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 17:39:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39891
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab1CJWje (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 17:39:34 -0500
Received: (qmail 31902 invoked by uid 107); 10 Mar 2011 22:40:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 17:40:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 17:39:34 -0500
Content-Disposition: inline
In-Reply-To: <7vk4g87wvf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168861>

On Wed, Mar 09, 2011 at 02:27:32PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. Is this papering over a bigger problem,...
> 
> It is not very obvious to me if redefining the semantics of filtering done
> by diff (the current definition is it is purely an output phase thing) is
> necessarily a good thing. I agree that the interaction between the output
> phase filtering and pruning done by the revision walker machinery is a
> fine topic to discuss.
> 
> But Matthieu's patch is not papering over anything but is a real fix
> within the context of the current architecture.

I consider the current state to be "buggy but we live with it" and not
an architectural decision. But that is simply a matter of perspective. :)

Certainly Matthieu's patch fixes a real problem, and it does not make it
any harder to address the other problems in the future, so I think there
is no reason not to apply it.

-Peff
