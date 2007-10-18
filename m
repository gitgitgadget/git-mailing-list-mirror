From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] t5516: test update of local refs on push
Date: Thu, 18 Oct 2007 02:59:28 -0400
Message-ID: <20071018065928.GJ14735@spearce.org>
References: <20071018045358.GB14735@spearce.org> <20071018061746.GA29531@coredump.intra.peff.net> <20071018062136.GB11938@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Perry Wagle <wagle@cs.indiana.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 08:59:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiPME-0008Ih-Od
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 08:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbXJRG7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 02:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755825AbXJRG7i
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 02:59:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53795 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbXJRG7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 02:59:36 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiPLq-0003Ys-4C; Thu, 18 Oct 2007 02:59:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1EB4A20FBAE; Thu, 18 Oct 2007 02:59:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071018062136.GB11938@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61496>

Jeff King <peff@peff.net> wrote:
> On Thu, Oct 18, 2007 at 02:17:46AM -0400, Jeff King wrote:
> > The first test (updating local refs) should succeed, but the
> > second one (not updating on error) currently fails.
> 
> Oops, this should of course be labeled as 1/2.
> 
> For the fix, I didn't need anything from 'next', after all, and 2/2 also
> works fine there (it was almost literally a code move).

Yay. I like it when I'm proven wrong.  Especially by a short patch.
:)

This will be in next tonight.  Give it a few days, then probably
graduate up to master.

-- 
Shawn.
