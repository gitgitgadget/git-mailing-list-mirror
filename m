From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t6019: avoid refname collision on case-insensitive
 systems
Date: Thu, 15 Sep 2011 11:53:08 -0400
Message-ID: <20110915155308.GA19667@sigill.intra.peff.net>
References: <02451a2849fc8f1cab7983b6c8c629ebb6a1aaa9.1316075573.git.trast@student.ethz.ch>
 <7vzki5pzvi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 17:53:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4EFX-0007LX-Ey
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 17:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934119Ab1IOPxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 11:53:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34620
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934048Ab1IOPxK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 11:53:10 -0400
Received: (qmail 22597 invoked by uid 107); 15 Sep 2011 15:54:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Sep 2011 11:54:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2011 11:53:08 -0400
Content-Disposition: inline
In-Reply-To: <7vzki5pzvi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181476>

On Thu, Sep 15, 2011 at 08:52:01AM -0700, Junio C Hamano wrote:

> > This fixes the tests on OS X.  Together with Peff's fix to the poll
> > issue, it now tests clean again.
> 
> Hmm, I must have misplaced Peff's poll fix. Care to point me in the right
> direction?

You have it already; it's part of the new http-auth commits I sent
yesterday (patch 2/5).

-Peff
