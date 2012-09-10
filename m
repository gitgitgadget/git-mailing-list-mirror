From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] Add a function string_list_longest_prefix()
Date: Mon, 10 Sep 2012 12:33:10 -0400
Message-ID: <20120910163310.GE9435@sigill.intra.peff.net>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
 <1347169990-9279-5-git-send-email-mhagger@alum.mit.edu>
 <7vbohfser4.fsf@alter.siamese.dyndns.org>
 <504DBA62.3080001@alum.mit.edu>
 <7v1ui9q21a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:33:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6vJ-0002yh-5x
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab2IJQdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:33:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39749 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab2IJQdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:33:13 -0400
Received: (qmail 29483 invoked by uid 107); 10 Sep 2012 16:33:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 12:33:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 12:33:10 -0400
Content-Disposition: inline
In-Reply-To: <7v1ui9q21a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205143>

On Mon, Sep 10, 2012 at 09:24:17AM -0700, Junio C Hamano wrote:

> > While we're on the subject, it seems to me that documenting APIs like
> > these in separate files under Documentation/technical rather than in the
> > header files themselves
> >
> > - makes the documentation for a particular function harder to find,
> >
> > - makes it easier for the documentation to get out of sync with the
> > actual collection of functions (e.g., the 5 undocumented functions
> > listed above).
> >
> > - makes it awkward for the documentation to refer to particular function
> > parameters by name.
> >
> > While it is nice to have a high-level prose description of an API, I am
> > often frustrated by the lack of "docstrings" in the header file where a
> > function is declared.  The high-level description of an API could be put
> > at the top of the header file.
> >
> > Also, better documentation in header files could enable the automatic
> > generation of API docs (e.g., via doxygen).
> 
> Yeah, perhaps you may want to look into doing an automated
> generation of Documentation/technical/api-*.txt files out of the
> headers.

I was just documenting something in technical/api-* the other day, and
had the same feeling. I'd be very happy if we moved to some kind of
literate-programming system. I have no idea which ones are good or bad,
though. I have used doxygen, but all I remember is it being painfully
baroque. I'd much rather have something simple and lightweight, with an
easy markup format. For example, this:

  http://tomdoc.org/

Looks much nicer to me than most doxygen I've seen. But again, it's been
a while, so maybe doxygen is nicer than I remember.

-Peff
