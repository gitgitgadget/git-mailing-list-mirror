From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Thu, 27 Feb 2014 06:27:34 -0500
Message-ID: <20140227112734.GC29668@sigill.intra.peff.net>
References: <52E1A99D.6010809@fb.com>
 <52E1AB78.1000504@fb.com>
 <20140124022822.GC4521@sigill.intra.peff.net>
 <52E1D39B.4050103@fb.com>
 <20140128060954.GA26401@sigill.intra.peff.net>
 <xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
 <20140224082459.GA32594@sigill.intra.peff.net>
 <xmqq1tys9vie.fsf@gitster.dls.corp.google.com>
 <20140226101353.GA25711@sigill.intra.peff.net>
 <xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 12:27:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIz7s-0000UZ-Oq
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 12:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbaB0L1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 06:27:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:57968 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750918AbaB0L1g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 06:27:36 -0500
Received: (qmail 18532 invoked by uid 102); 27 Feb 2014 11:27:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Feb 2014 05:27:36 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Feb 2014 06:27:34 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242807>

On Wed, Feb 26, 2014 at 12:30:36PM -0800, Junio C Hamano wrote:

> >> pack-kept-objects then?
> >
> > Hmm. That does address my point above, but somehow the word "kept" feels
> > awkward to me. I'm ambivalent between the two.
> 
> That word does make my backside somewhat itchy ;-)
> 
> Would it help to take a step back and think what the option really
> does?  Perhaps we should call it --pack-all-objects, which is short
> for --pack-all-objectsregardless-of-where-they-currently-are-stored,
> or something?  The word "all" gives a wrong connotation in a
> different way (e.g. "regardless of reachability" is a possible wrong
> interpretation), so that does not sound too good, either.

I do not think "all" is what we want to say. It only affects "kept"
objects, not any of the other exclusions (e.g., "-l").

> "--repack-kept-objects"?  "--include-kept-objects"?

Of all of them, I think --pack-kept-objects is probably the best. And I
think we are hitting diminishing returns in thinking too much more on
the name. :)

-Peff
