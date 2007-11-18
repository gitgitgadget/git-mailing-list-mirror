From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] send-pack: assign remote errors to each ref
Date: Sat, 17 Nov 2007 19:03:07 -0500
Message-ID: <20071118000306.GA4000@sigill.intra.peff.net>
References: <20071117125323.GA23125@sigill.intra.peff.net> <20071117125602.GC23186@sigill.intra.peff.net> <Pine.LNX.4.64.0711171258000.12193@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Nov 18 01:03:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItXdO-0000zc-A0
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 01:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbXKRADO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 19:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754787AbXKRADO
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 19:03:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3247 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754121AbXKRADN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 19:03:13 -0500
Received: (qmail 6707 invoked by uid 111); 18 Nov 2007 00:03:09 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 19:03:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 19:03:07 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711171258000.12193@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65322>

On Sat, Nov 17, 2007 at 01:05:29PM -0500, Daniel Barkalow wrote:

> Maybe this should take both the full list and the hint and do both passes 
> internally? IMHO, the logic in receive_status() looks like it might be 
> setting the error twice or not at all, unless you read very carefully.

Not unreasonable, though I started in that direction and it ended up
being less readable (which isn't to say that it's not possible). But it
looks like Junio has merged to next, so I think it is best to leave it
as-is.

-Peff
