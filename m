From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Thu, 10 Jul 2008 04:47:28 -0400
Message-ID: <20080710084728.GA6199@sigill.intra.peff.net>
References: <7v4phdja01.fsf@gitster.siamese.dyndns.org> <7v4p6zmx0l.fsf@gitster.siamese.dyndns.org> <20080709055150.GA28482@glandium.org> <7vlk0blgg0.fsf@gitster.siamese.dyndns.org> <20080709075345.GA22022@glandium.org> <7vhcazlbch.fsf@gitster.siamese.dyndns.org> <20080709085651.GA23453@glandium.org> <alpine.DEB.1.00.0807091341230.5277@eeepc-johanness> <20080710072420.GA5167@sigill.intra.peff.net> <7vk5fuqjn8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, jean.guyader@linkea.org,
	git@vger.kernel.org, Jean Guyader <jean.guyader@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 10:48:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGrpV-0003nU-Gs
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 10:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbYGJIrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 04:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbYGJIrm
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 04:47:42 -0400
Received: from peff.net ([208.65.91.99]:1110 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232AbYGJIrl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 04:47:41 -0400
Received: (qmail 18682 invoked by uid 111); 10 Jul 2008 08:47:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 10 Jul 2008 04:47:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2008 04:47:28 -0400
Content-Disposition: inline
In-Reply-To: <7vk5fuqjn8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87960>

On Thu, Jul 10, 2008 at 12:32:27AM -0700, Junio C Hamano wrote:

> > Wouldn't there still be a race condition for publicly broadcasting your
> > password via ps?
> 
> In addition, I think on some Unices overwriting argv[0] does not have the
> effect Dscho is aiming for.

I thought so, too, but I couldn't find any mention of it online.  For
curiosity's sake, do you happen to know offhand any platform where this
doesn't work (of course, Dscho is really proposing overwriting argv[i],
but I don't know if that makes a difference to the portability)?

-Peff
