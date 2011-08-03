From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] gitattributes: Clarify discussion of attribute macros
Date: Wed, 3 Aug 2011 16:40:33 -0600
Message-ID: <20110803224032.GA31153@sigill.intra.peff.net>
References: <1312378890-31703-1-git-send-email-mhagger@alum.mit.edu>
 <1312378890-31703-2-git-send-email-mhagger@alum.mit.edu>
 <20110803194632.GB23848@sigill.intra.peff.net>
 <7v1ux2b2d8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 00:40:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qok7E-0001Xa-Og
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 00:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab1HCWkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 18:40:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33456
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755744Ab1HCWkf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 18:40:35 -0400
Received: (qmail 11492 invoked by uid 107); 3 Aug 2011 22:41:09 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 18:41:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 16:40:33 -0600
Content-Disposition: inline
In-Reply-To: <7v1ux2b2d8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178643>

On Wed, Aug 03, 2011 at 02:40:19PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't know if that was intentional, or if the behavior is simply
> > accidental and the original code was simply never meant to have
> > "-binary" called at all.
> 
> The latter. You were never expected to say -macro at all.

OK. Maybe we should flag an error, then? Or if not, then make the
documentation more clear that it's not allowed (or even say the current
behavior is reasonable, and document it).

-Peff
