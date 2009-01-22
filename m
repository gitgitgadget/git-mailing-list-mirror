From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Wed, 21 Jan 2009 19:00:26 -0500
Message-ID: <20090122000026.GB9668@sigill.intra.peff.net>
References: <20090117153846.GB27071@coredump.intra.peff.net> <200901182137.16562.markus.heidelberg@web.de> <20090120040448.GA30714@sigill.intra.peff.net> <200901212335.24727.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 01:02:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPn1a-0005YX-I8
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 01:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbZAVAAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 19:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbZAVAAa
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 19:00:30 -0500
Received: from peff.net ([208.65.91.99]:37298 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbZAVAA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 19:00:29 -0500
Received: (qmail 22642 invoked by uid 107); 22 Jan 2009 00:00:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 21 Jan 2009 19:00:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 19:00:26 -0500
Content-Disposition: inline
In-Reply-To: <200901212335.24727.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106706>

On Wed, Jan 21, 2009 at 11:35:24PM +0100, Markus Heidelberg wrote:

> > properly initialized (or finalized).
> > 
> > So I think it makes more sense to record each config value, and then
> > check a _function_ that does the right thing. I.e., you end up with
> > something like:
> >
> > [example code snipped]
> 
> That would probably be better.

Do you want to work on it, or should it go into the "yeah, right, one
day" section of my todo list?

-Peff
