From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 3 Sep 2008 15:41:56 -0400
Message-ID: <20080903194156.GA31756@coredump.intra.peff.net>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <200809022339.20123.johan@herland.net> <20080902214428.GA20355@sigill.intra.peff.net> <200809030945.08619.johan@herland.net> <20080903131507.GC12936@coredump.intra.peff.net> <20080903133446.GA6967@coredump.intra.peff.net> <alpine.LNX.1.00.0809031234560.19665@iabervon.org> <20080903180726.GA16454@coredump.intra.peff.net> <7vljy9auoq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KayGD-0006YJ-N0
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 21:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbYICTl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 15:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbYICTl7
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 15:41:59 -0400
Received: from peff.net ([208.65.91.99]:2777 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbYICTl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 15:41:58 -0400
Received: (qmail 31118 invoked by uid 111); 3 Sep 2008 19:41:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Sep 2008 15:41:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 15:41:56 -0400
Content-Disposition: inline
In-Reply-To: <7vljy9auoq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94845>

On Wed, Sep 03, 2008 at 12:36:05PM -0700, Junio C Hamano wrote:

> It was a good idea to keep the scripted ones in contrib/examples so that
> they are readily accessible to find out what we used to do ;-).

Who's to say I didn't do:

  deleted=$(git log -1 --pretty=format:%H --diff-filter=D -- git-checkout.sh)
  git show ${deleted}^:git-checkout.sh

? :P

-Peff

PS Actually, I was about to look it up in the history when I remembered
that we put it into contrib. :)
