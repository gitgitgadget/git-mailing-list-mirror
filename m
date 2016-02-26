From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] git: submodule honor -c credential.* from command
 line
Date: Fri, 26 Feb 2016 01:07:43 -0500
Message-ID: <20160226060743.GB24517@sigill.intra.peff.net>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
 <1456426632-23257-2-git-send-email-jacob.e.keller@intel.com>
 <20160226015510.GA5347@flurp.local>
 <CA+P7+xqyTUh60BOmY03JHE6HyVqY7iidVkUf3ji95_s3uE32cg@mail.gmail.com>
 <CAPig+cRM_1JLfBiOqo+-EdKbXp--4VUbddKN_zpSCSLK8PT09w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 07:07:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZBZA-0002w5-6s
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 07:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbcBZGHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 01:07:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:49823 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750829AbcBZGHr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 01:07:47 -0500
Received: (qmail 22237 invoked by uid 102); 26 Feb 2016 06:07:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 01:07:46 -0500
Received: (qmail 31568 invoked by uid 107); 26 Feb 2016 06:07:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 01:07:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 01:07:43 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cRM_1JLfBiOqo+-EdKbXp--4VUbddKN_zpSCSLK8PT09w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287537>

On Thu, Feb 25, 2016 at 09:26:14PM -0500, Eric Sunshine wrote:

> On Thu, Feb 25, 2016 at 9:19 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> > On Thu, Feb 25, 2016 at 5:55 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >> Not worth a re-roll, but these quote sequences are brain-melting.
> >> Easier would have been to double-quote the second argument of
> >> test_expect_success() and then do either:
> >
> > They are. I fiddled with things till I got it working. I wasn't sure
> > if double quotes would cause a problem or not, since most other tests
> > seemed to avoid it.
> 
> You normally want variable interpolations within the test to happen
> when the test is actually run rather than when it is defined, which is
> why single quotes are normally used. But this test doesn't use any
> variable interpolations, so double quotes won't hurt it.

Of the two you suggested, I think I like the here-doc better, as it does
not leave any question to a reader that there is other interpolation
going on.

-Peff
