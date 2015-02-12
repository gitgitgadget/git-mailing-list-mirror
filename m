From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] migrate api-strbuf.txt into strbuf.h
Date: Thu, 12 Feb 2015 18:05:14 -0500
Message-ID: <20150212230513.GA21222@peff.net>
References: <20150116090225.GA30797@peff.net>
 <xmqqh9uqpwe9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:05:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM2p1-0008Hu-Vh
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 00:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbbBLXFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 18:05:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:48447 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751267AbbBLXFR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 18:05:17 -0500
Received: (qmail 7723 invoked by uid 102); 12 Feb 2015 23:05:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Feb 2015 17:05:16 -0600
Received: (qmail 29015 invoked by uid 107); 12 Feb 2015 23:05:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Feb 2015 18:05:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Feb 2015 18:05:14 -0500
Content-Disposition: inline
In-Reply-To: <xmqqh9uqpwe9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263783>

On Thu, Feb 12, 2015 at 03:01:18PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This is a re-roll of this series:
> >
> >   http://thread.gmane.org/gmane.comp.version-control.git/260922/focus=261374
> >
> > from early December to move the strbuf documentation into the header
> > file.
> >
> > And of course the elephant in the room is the other dozen or more
> > api-*.txt files. I'd propose to do this strbuf.h series (and possible
> > follow-ons mentioned above) and stop there for a bit. That will let us
> > form a more coherent opinion on whether we like this system in practice,
> > how it ages as functions are changed and added, etc. That might affect
> > how or if we end up converting other files.
> >
> > It does leave us in an inconsistent state (some documentation is in
> > Documentation/technical, and some is in the headers), but I think that
> > is largely where we're at today. IMHO this is a strict improvement
> > because at least the logical chunk of "strbuf" is now in a single place.
> 
> Is there a general concensus on the direction?
> 
> I am inclined to merge this to 'next', if there is a general
> understanding that we will try to make the headers _the_ single
> source of truth of the API by (1) not adding to api-*.txt without
> describing new things in the headers and (2) moving things from
> api-*.txt to corresponding headers when clarifying, fixing or
> updating the API.

I'm fine with that (unsurprisingly), but I would like to hear an "OK"
from Jonathan before going ahead.

-Peff
