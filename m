From: Jeff King <peff@peff.net>
Subject: Re: Probable bug in file run-command.c function
 clear_child_for_cleanup
Date: Mon, 10 Sep 2012 16:01:10 -0400
Message-ID: <20120910200110.GA32437@sigill.intra.peff.net>
References: <504CAB66.1050003@optimisefitness.com>
 <20120910134406.GA7496@sigill.intra.peff.net>
 <CABPQNSaufY9vUAFp9VL2i=6bNmO5_2+anzX6+omfq+UgP03kXg@mail.gmail.com>
 <20120910141027.GA8284@sigill.intra.peff.net>
 <7v8vchodgc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	David Gould <david@optimisefitness.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBAAe-0005IW-58
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551Ab2IJUBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:01:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39976 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784Ab2IJUBO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:01:14 -0400
Received: (qmail 32492 invoked by uid 107); 10 Sep 2012 20:01:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 16:01:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 16:01:10 -0400
Content-Disposition: inline
In-Reply-To: <7v8vchodgc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205169>

On Mon, Sep 10, 2012 at 01:00:35PM -0700, Junio C Hamano wrote:

> >> And to conclude my bikeshedding for the day: Shouldn't "last" ideally
> >> be called something like "prev" instead? It's the previously visited
> >> element, not the last element in the list.
> >
> > It is the "last" element visited (just as "last week" is not the end of
> > the world), but yes, it is ambiguous, and "prev" is not. Either is fine
> > by me.
> 
> OK, so who's gonna do the honors?

I was hoping to give David a chance to submit his first-ever patch to
git.

-Peff
