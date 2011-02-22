From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] merge: improve inexact rename limit warning
Date: Tue, 22 Feb 2011 10:39:09 -0500
Message-ID: <20110222153909.GB27178@sigill.intra.peff.net>
References: <20110219101936.GB20577@sigill.intra.peff.net>
 <20110219102051.GA22508@sigill.intra.peff.net>
 <7vzkppgdz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 16:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PruKx-0000UA-H2
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 16:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab1BVPjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 10:39:23 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33675 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546Ab1BVPjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 10:39:12 -0500
Received: (qmail 2135 invoked by uid 111); 22 Feb 2011 15:39:11 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 22 Feb 2011 15:39:11 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Feb 2011 10:39:09 -0500
Content-Disposition: inline
In-Reply-To: <7vzkppgdz9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167556>

On Mon, Feb 21, 2011 at 03:33:14PM -0800, Junio C Hamano wrote:

> > Instead, let's have diffcore pass back the information about
> > how big the rename limit would needed to have been, and then
> > the caller can provide a more appropriate message (and at a
> > more appropriate time).
> [...]
> This conflicts with 2840824 (diffcore-rename: fall back to -C when -C -C
> busts the rename limit, 2011-01-06) on 'pu', unfortunately.

Do you want to do the merge, or do you want me to rebase on top of
2840824?

-Peff
