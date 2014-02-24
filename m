From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] tag: support --sort=<spec>
Date: Mon, 24 Feb 2014 18:33:03 -0500
Message-ID: <20140224233303.GA27689@sigill.intra.peff.net>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
 <1393039762-4843-1-git-send-email-pclouds@gmail.com>
 <20140222080404.GB1576@sigill.intra.peff.net>
 <xmqqy510bh2g.fsf@gitster.dls.corp.google.com>
 <CACsJy8CRe4MmkTnuChOi2SHG52tx_LZ+51vWXN9ooGmcRUN7bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 00:33:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI51L-0006jo-Me
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 00:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbaBXXdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 18:33:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:56375 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752446AbaBXXdG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 18:33:06 -0500
Received: (qmail 30214 invoked by uid 102); 24 Feb 2014 23:33:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 17:33:05 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 18:33:03 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CRe4MmkTnuChOi2SHG52tx_LZ+51vWXN9ooGmcRUN7bQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242654>

On Tue, Feb 25, 2014 at 06:30:35AM +0700, Duy Nguyen wrote:

> >>> +[ "$(uname -o)" = "GNU/Linux" ] && test_set_prereq GNULINUX
> >>> +
> >>
> >> can pick up the value from GIT-BUILD-OPTIONS as a prerequisite (see the
> >> way we handle NO_PERL for an example). Though if we can just grab the
> >> glibc version as a fallback, we can do away with that completely.
> >
> > ;-)  I like that.
> >
> 
> Jeff, I'm still waiting if you agree to go with this syntax or put
> version before refname before rerolling (either with build time option
> like this, or implement the compat function myself).

Sorry. I didn't respond because I was trying to think of something to
say besides "no, I still like mine better". I admit that it's mostly a
gut feeling, and I don't have any argument beyond what I've already
made (your "it's like a typecast" does make some sense, but I think that
is a convoluted way of thinking about it).

-Peff
