From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs
Date: Wed, 16 Apr 2008 00:47:26 -0400
Message-ID: <20080416044726.GA831@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <20080413093102.GC12107@mithlond.arda.local> <20080416034823.GA11727@sigill.intra.peff.net> <7vabjuv2c2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:51:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlzZ7-00056d-KA
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 06:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbYDPEr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 00:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbYDPEr3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 00:47:29 -0400
Received: from [208.65.91.99] ([208.65.91.99]:1297 "EHLO peff.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbYDPEr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 00:47:28 -0400
Received: (qmail 12467 invoked by uid 111); 16 Apr 2008 04:47:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 16 Apr 2008 00:47:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Apr 2008 00:47:26 -0400
Content-Disposition: inline
In-Reply-To: <7vabjuv2c2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79670>

On Tue, Apr 15, 2008 at 09:41:17PM -0700, Junio C Hamano wrote:

> What you would say on the second command is not literally "<branch2>" but
> something like "work-in-progress", or "crap".  Even an AI would not be
> able to guess if you wanted to create a branch on the other side, or
> wanted to put a lightweight tag to let people know where you are (possibly
> with the intention of removing it once you are done), and git is not an AI.

Of course it can't guess all cases. But right now you have the option
of:

  1. specifying the full destination manually
  2. having git complain, and then doing (1)

I think changing (2) to "having git make a reasonable guess" is a better
behavior. And I think it is a reasonable guess to use the _same_ type,
just as we do with "git push <branch>".

-Peff
