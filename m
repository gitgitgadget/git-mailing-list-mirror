From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Tue, 8 Dec 2009 04:35:16 -0500
Message-ID: <20091208093515.GA32655@sigill.intra.peff.net>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
 <4B192701.4000308@drmicha.warpmail.net>
 <vpqfx7qocwl.fsf@bauges.imag.fr>
 <7vws12r5v2.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302>
 <20091205062708.6117@nanako3.lavabit.com>
 <7vd42t6f9i.fsf@alter.siamese.dyndns.org>
 <20091208121314.6117@nanako3.lavabit.com>
 <7viqchhl7h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 10:35:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHwTh-0007Mu-C2
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 10:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbZLHJfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 04:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbZLHJfP
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 04:35:15 -0500
Received: from peff.net ([208.65.91.99]:45532 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbZLHJfN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 04:35:13 -0500
Received: (qmail 9930 invoked by uid 107); 8 Dec 2009 09:39:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 08 Dec 2009 04:39:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Dec 2009 04:35:16 -0500
Content-Disposition: inline
In-Reply-To: <7viqchhl7h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134849>

On Tue, Dec 08, 2009 at 01:24:50AM -0800, Junio C Hamano wrote:

> I hate bikeshedding but somehow
> 
>     git commit -m "fixup! commit with this message"
> 
> feels much more natural than having to write
> 
>     git commit -m "!fixup commit with this message".

Also:

  $ bash
  $ echo "!fixup commit"
  bash: !fixup: event not found
  $ echo "fixup! commit"
  fixup! commit

-Peff
