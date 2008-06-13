From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add test-tr: poor-man tr
Date: Fri, 13 Jun 2008 14:00:41 -0400
Message-ID: <20080613180041.GA8921@sigill.intra.peff.net>
References: <20080611182501.GA3344@steel.home> <20080611225448.GC19474@sigill.intra.peff.net> <20080612060152.GA3798@steel.home> <20080612062309.GA31816@sigill.intra.peff.net> <20080612203245.GB8057@steel.home> <20080613060215.GB26768@sigill.intra.peff.net> <20080613172634.GB5671@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 20:01:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Dal-0000ma-OC
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbYFMSAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYFMSAp
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:00:45 -0400
Received: from peff.net ([208.65.91.99]:3463 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbYFMSAo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:00:44 -0400
Received: (qmail 10488 invoked by uid 111); 13 Jun 2008 18:00:43 -0000
Received: from lawn-128-61-17-201.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.17.201)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 14:00:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 14:00:41 -0400
Content-Disposition: inline
In-Reply-To: <20080613172634.GB5671@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84906>

On Fri, Jun 13, 2008 at 07:26:34PM +0200, Alex Riesen wrote:

> > Does ActiveState respect the PERLIO environment variable? I haven't
> > played with it much, but my understanding is that setting
> > PERLIO=:unix:perlio should give you sane behavior (the default on
> > Windows should be PERLIO=:unix:crlf).
> 
> I didn't know about it (and managed to miss it when I looked to
> workaround the problem. I even looked into the manpage documenting
> environment variables!)
> 
> Yes, it works. It has side effects (the scripts of some build
> processes will be affected), but that's already something...

I was thinking that we could set it inside test-lib.sh to get consistent
behavior. It should just be a no-op on sane systems.

-Peff
