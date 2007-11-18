From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] send-pack: track errors for each ref
Date: Sat, 17 Nov 2007 19:15:10 -0500
Message-ID: <20071118001509.GC4000@sigill.intra.peff.net>
References: <20071117125323.GA23125@sigill.intra.peff.net> <20071117125426.GA23186@sigill.intra.peff.net> <7v6400twzp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 01:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItXow-0004RM-PM
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 01:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbXKRAPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 19:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbXKRAPO
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 19:15:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4429 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298AbXKRAPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 19:15:13 -0500
Received: (qmail 6755 invoked by uid 111); 18 Nov 2007 00:15:11 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 19:15:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 19:15:10 -0500
Content-Disposition: inline
In-Reply-To: <7v6400twzp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65324>

On Sat, Nov 17, 2007 at 12:53:14PM -0800, Junio C Hamano wrote:

> > +		strcpy(quickref, status_abbrev(ref->old_sha1));
> > +		if (ref->nonfastforward) {
> > +			strcat(quickref, "...");
> > +			type = '+';
> > +			msg = " (forced update)";
> 
> ... you do not need the " (" and ")" here.

Oops, good catch.

> All merged to 'next'.  Thanks.

I see you fixed up the off-by-one buffer, too. Thanks.

-Peff
