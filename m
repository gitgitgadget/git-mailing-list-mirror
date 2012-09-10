From: Jeff King <peff@peff.net>
Subject: Re: Using doxygen (or something similar) to generate API docs [was
 [PATCH 4/4] Add a function string_list_longest_prefix()]
Date: Mon, 10 Sep 2012 17:56:33 -0400
Message-ID: <20120910215633.GB1537@sigill.intra.peff.net>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
 <1347169990-9279-5-git-send-email-mhagger@alum.mit.edu>
 <7vbohfser4.fsf@alter.siamese.dyndns.org>
 <504DBA62.3080001@alum.mit.edu>
 <7v1ui9q21a.fsf@alter.siamese.dyndns.org>
 <20120910163310.GE9435@sigill.intra.peff.net>
 <504E27D7.8010505@op5.se>
 <504E3DA8.7040906@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:56:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBByL-0000Ea-W9
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757262Ab2IJV4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:56:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40168 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756493Ab2IJV4h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 17:56:37 -0400
Received: (qmail 2281 invoked by uid 107); 10 Sep 2012 21:56:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 17:56:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 17:56:33 -0400
Content-Disposition: inline
In-Reply-To: <504E3DA8.7040906@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205198>

On Mon, Sep 10, 2012 at 09:21:12PM +0200, Michael Haggerty wrote:

> I'm renaming this thread so that the bikeshedding can get over ASAP.

Thanks. :)

> >>    http://tomdoc.org/
> >>
> >> Looks much nicer to me than most doxygen I've seen. But again, it's been
> >> a while, so maybe doxygen is nicer than I remember.
> 
> I don't have a personal preference for what system is used.  I mentioned
> doxygen only because it seems to be a well-known example.
> 
> From a glance at the URL you mentioned, it looks like TomDoc is only
> applicable to Ruby code.

Yeah, sorry, I should have been more clear; tomdoc is not an option
because it doesn't do C. But what I like about it is the more
natural markup syntax. I was wondering if there were other similar
solutions. Looks like "NaturalDocs" is one:

  http://www.naturaldocs.org/documenting.html

On the other hand, doxygen is well-known among open source folks, which
counts for something.  And from what I've read, recent versions support
Markdown, but I'm not sure of the details. So maybe it is a lot better
than I remember.

> > Doxygen has a the very nifty feature of being able to generate
> > callgraphs though. We use it extensively at $dayjob, so if you need a
> > hand building something sensible out of git's headers, I'd be happy
> > to help.

It has been over a decade since I seriously used doxygen for anything,
and then it was a medium-sized project. So take my opinion with a grain
of salt. But I remember the callgraph feature being one of those things
that _sounded_ really cool, but in practice was not all that useful.

> My plate is full.  If you are able to work on this, it would be awesome.
>  As far as I'm concerned, you are the new literate documentation czar :-)

Lucky me? :)

I think I'll leave it for the moment, and next time I start to add some
api-level documentation I'll take a look at doxygen-ating them and see
how I like it. And I'd invite anyone else to do the same (in doxygen, or
whatever system you like -- the best way to evaluate a tool like this is
to see how your real work would look).

-Peff
