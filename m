From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Thu, 10 Jul 2008 03:24:20 -0400
Message-ID: <20080710072420.GA5167@sigill.intra.peff.net>
References: <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709300039430.28395@racer.site> <7v4phdja01.fsf@gitster.siamese.dyndns.org> <7v4p6zmx0l.fsf@gitster.siamese.dyndns.org> <20080709055150.GA28482@glandium.org> <7vlk0blgg0.fsf@gitster.siamese.dyndns.org> <20080709075345.GA22022@glandium.org> <7vhcazlbch.fsf@gitster.siamese.dyndns.org> <20080709085651.GA23453@glandium.org> <alpine.DEB.1.00.0807091341230.5277@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	jean.guyader@linkea.org, git@vger.kernel.org,
	Jean Guyader <jean.guyader@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 09:25:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGqXD-0007Su-7Y
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 09:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbYGJHYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 03:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbYGJHYd
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 03:24:33 -0400
Received: from peff.net ([208.65.91.99]:1185 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbYGJHYd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 03:24:33 -0400
Received: (qmail 18166 invoked by uid 111); 10 Jul 2008 07:24:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 10 Jul 2008 03:24:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2008 03:24:20 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807091341230.5277@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87949>

On Wed, Jul 09, 2008 at 01:43:07PM +0200, Johannes Schindelin wrote:

> > Note that http://user:pass@server/path/ /should/ work (but that would 
> > need validation), though not a good idea on command line.
> 
> Well, now that the programs using URLs are all builtins, we can actually 
> do something about it.  We can edit out the "user[:pass]@" part out of 
> argv, which usually means that "ps" will not see it anymore.

Wouldn't there still be a race condition for publicly broadcasting your
password via ps?

-Peff
