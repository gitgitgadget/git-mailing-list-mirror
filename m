From: Jeff King <peff@peff.net>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 02:34:28 -0400
Message-ID: <20071020063428.GC30388@coredump.intra.peff.net>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org> <1192859758.13347.148.camel@g4mdd.entnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Ari Entlich <lmage11@twcny.rr.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 08:34:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij7v1-0006OY-U0
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757712AbXJTGeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757934AbXJTGeb
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:34:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2304 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757030AbXJTGea (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:34:30 -0400
Received: (qmail 18989 invoked by uid 111); 20 Oct 2007 06:34:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 20 Oct 2007 02:34:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Oct 2007 02:34:28 -0400
Content-Disposition: inline
In-Reply-To: <1192859758.13347.148.camel@g4mdd.entnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61793>

On Sat, Oct 20, 2007 at 01:55:58AM -0400, Ari Entlich wrote:

> Might it be possible to simply get the struct cache_entry for the file
> which we want to rename, change its name property (would this involve
> xreallocing it?), and change the ce_namelen field of ce_flags?

The sort order of entries in the cache is important, so you would have
to move the entry, as well.

-Peff
