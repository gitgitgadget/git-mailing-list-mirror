From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/3] tracking per-ref errors on push
Date: Tue, 13 Nov 2007 06:34:37 -0500
Message-ID: <20071113113437.GB15845@sigill.intra.peff.net>
References: <20071113102500.GA2767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 12:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iru2i-0001H7-Cv
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 12:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbXKMLel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 06:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbXKMLel
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 06:34:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4848 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513AbXKMLek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 06:34:40 -0500
Received: (qmail 19684 invoked by uid 111); 13 Nov 2007 11:34:39 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 06:34:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 06:34:37 -0500
Content-Disposition: inline
In-Reply-To: <20071113102500.GA2767@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64793>

On Tue, Nov 13, 2007 at 05:25:01AM -0500, Jeff King wrote:

>   - It looks like the push mirror code just made it into next, which
>     is going to require a conflict-heavy rebase on my part.

This turned out not to be too bad. A rebased series (with the extra
patch I just posted) follows, and it passes the test suite (though I
still think more tests are in order).

-Peff
