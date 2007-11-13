From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 3/3] send-pack: assign remote errors to each ref
Date: Tue, 13 Nov 2007 05:29:58 -0500
Message-ID: <20071113102958.GD2905@sigill.intra.peff.net>
References: <20071113102500.GA2767@sigill.intra.peff.net> <20071113102900.GC2905@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 11:30:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irt29-0007bp-TE
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 11:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbXKMKaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 05:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbXKMKaA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 05:30:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3700 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbXKMK37 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 05:29:59 -0500
Received: (qmail 19382 invoked by uid 111); 13 Nov 2007 10:29:58 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 05:29:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 05:29:58 -0500
Content-Disposition: inline
In-Reply-To: <20071113102900.GC2905@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64787>

On Tue, Nov 13, 2007 at 05:29:00AM -0500, Jeff King wrote:

> +		ref->error = xstrdup(msg);

Another problem with this patch: this is a leak.

-Peff
