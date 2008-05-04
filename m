From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diff: make "too many files" rename warning optional
Date: Sun, 4 May 2008 15:20:15 -0400
Message-ID: <20080504192015.GA13029@sigill.intra.peff.net>
References: <20080430172136.GA22601@sigill.intra.peff.net> <20080430172553.GC23747@sigill.intra.peff.net> <7vy76rrkry.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 21:21:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsjlg-0007b9-2o
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 21:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbYEDTUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 15:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754779AbYEDTUP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 15:20:15 -0400
Received: from peff.net ([208.65.91.99]:4576 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbYEDTUO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 15:20:14 -0400
Received: (qmail 26636 invoked by uid 111); 4 May 2008 19:20:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 May 2008 15:20:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 May 2008 15:20:15 -0400
Content-Disposition: inline
In-Reply-To: <7vy76rrkry.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81192>

On Sat, May 03, 2008 at 05:10:57PM -0700, Junio C Hamano wrote:

> > This neglects the case where the user specifically does a diff asking
> > for renames, but we turn it off. Maybe when "-M" is specified on the
> > commandline to git-diff, we should set this option as well.
> 
> That sounds sensible.  Like this?

I would have ack'd this, except it seems that the message produces some
problems with gitk, which explicitly calls diff-tree with -C (see the
message elsewhere in this thread from Ramsay Jones).

-Peff
