From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] check-ignore: allow incremental streaming of
 queries via --stdin
Date: Thu, 11 Apr 2013 16:40:19 -0400
Message-ID: <20130411204019.GA7588@sigill.intra.peff.net>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
 <1365681913-7059-4-git-send-email-git@adamspiers.org>
 <20130411191132.GC3177@sigill.intra.peff.net>
 <20130411203141.GB21091@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 22:40:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQOIS-00074u-3G
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 22:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097Ab3DKUka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 16:40:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40931 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754931Ab3DKUk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 16:40:27 -0400
Received: (qmail 19506 invoked by uid 107); 11 Apr 2013 20:42:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 16:42:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 16:40:19 -0400
Content-Disposition: inline
In-Reply-To: <20130411203141.GB21091@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220926>

On Thu, Apr 11, 2013 at 09:31:41PM +0100, Adam Spiers wrote:

> The shell source is strong with this one ;-)
> 
> Congrats - I first tried with FIFOs (hence my other patch which moves
> the PIPE test prerequisite definition into the core framework - the
> original intention was to reuse it here) but failed to get it working.
> I'll re-roll using your approach.

Thanks. If it make you feel any better, it took about 20 minutes of
experimenting and at least three head-scratching "wait, that _should_
have worked" moments to get it right. :)

The rest of the series looked good to me, though I admit I did not think
too hard about the "--non-matching" patch, as it looked like you and
Junio had already given some thought to the output format, which is the
tricky part.

-Peff
