From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] do not use GIT_TRACE_PACKET=3 in tests
Date: Wed, 20 Mar 2013 16:58:36 -0400
Message-ID: <20130320205836.GA1373@sigill.intra.peff.net>
References: <20130320172640.GC10752@sigill.intra.peff.net>
 <20130320174347.GA28548@sigill.intra.peff.net>
 <CAPig+cQhG-oE5n-RjxhHqGoPzTZbLGagU+9gxzrJhaOcUAtffQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 21:59:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIQ6I-0007k7-9B
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 21:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125Ab3CTU6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 16:58:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60526 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866Ab3CTU6m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 16:58:42 -0400
Received: (qmail 12887 invoked by uid 107); 20 Mar 2013 21:00:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 17:00:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 16:58:36 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQhG-oE5n-RjxhHqGoPzTZbLGagU+9gxzrJhaOcUAtffQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218682>

On Wed, Mar 20, 2013 at 04:29:40PM -0400, Eric Sunshine wrote:

> On Wed, Mar 20, 2013 at 1:43 PM, Jeff King <peff@peff.net> wrote:
> > Some test scripts use the GIT_TRACE mechanism to dump
> > debugging information to descriptor 3 (and point it to a
> > file using the shell). On Windows, however, bash is unable
> > to set up descriptor 3. We do not write our trace to the
> > file, and worse, we may interfere with other operations
> > happening on descriptor 3, causing tests to fail or other
> > even behave inconsistently.
> 
> s/other even/even/

Urgh, I should probably add another proofreading pass to my commit
messages. Thanks.

-Peff
