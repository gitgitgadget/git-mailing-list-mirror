From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 4/4] inexact rename detection eye candy
Date: Sun, 20 Feb 2011 05:37:03 -0500
Message-ID: <20110220103703.GA1527@sigill.intra.peff.net>
References: <20110219101936.GB20577@sigill.intra.peff.net>
 <20110219102533.GD22508@sigill.intra.peff.net>
 <AANLkTik=pd3vVMERz=H3sp835Ft8OvrOzBE4PUS7vrO7@mail.gmail.com>
 <20110220094803.GA988@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 20 11:37:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr6fA-000538-TX
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 11:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259Ab1BTKhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 05:37:07 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34057 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236Ab1BTKhG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 05:37:06 -0500
Received: (qmail 16838 invoked by uid 111); 20 Feb 2011 10:37:05 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 20 Feb 2011 10:37:05 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Feb 2011 05:37:03 -0500
Content-Disposition: inline
In-Reply-To: <20110220094803.GA988@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167416>

On Sun, Feb 20, 2011 at 04:48:04AM -0500, Jeff King wrote:

> (Actually that is not quite accurate, as we may skip some calls for
> destinations already found, but it's not worth the effort to figure
> out how many calls we'll actually make ahead of time).

Hmm. Actually, we do calculate the exact amount of work a few lines
above. So we could be more accurate. I'm still not sure it really
matters.

-Peff
