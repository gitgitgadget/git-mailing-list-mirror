From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Sun, 11 Nov 2007 03:13:05 -0500
Message-ID: <20071111081305.GA27798@sigill.intra.peff.net>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net> <4734EA4E.8070405@lsrfire.ath.cx> <20071110004635.GA14992@sigill.intra.peff.net> <47359221.7090707@lsrfire.ath.cx> <20071110203435.GB20592@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:13:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir7we-0001GC-Vz
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbXKKINK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752745AbXKKINJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:13:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1106 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbXKKINI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:13:08 -0500
Received: (qmail 29974 invoked by uid 111); 11 Nov 2007 08:13:07 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 11 Nov 2007 03:13:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2007 03:13:05 -0500
Content-Disposition: inline
In-Reply-To: <20071110203435.GB20592@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64423>

On Sat, Nov 10, 2007 at 03:34:35PM -0500, Jeff King wrote:

> Your solution leaves me partly disgusted at the hackishness, and partly
> delighted at the cleverness. I think the way you have coded it is quite
> clear, though, so I don't think anyone is likely to get confused reading
> it. I haven't read through it carefully yet, but a tentative Ack from
> me.

OK, I had a chance to read through your patches more carefully. Assuming
that the strbuf offset technique is acceptable (and I think it is worth
the increased speed and simplicity), they look great to me. So:

Acked-by: Jeff King <peff@peff.net>

-Peff
