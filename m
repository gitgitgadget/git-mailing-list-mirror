From: Jeff King <peff@peff.net>
Subject: Re: Git in GSoC 2014
Date: Wed, 26 Feb 2014 06:04:33 -0500
Message-ID: <20140226110433.GF25711@sigill.intra.peff.net>
References: <20140225154158.GA9038@sigill.intra.peff.net>
 <530CCFB0.5050406@alum.mit.edu>
 <20140226102350.GB25711@sigill.intra.peff.net>
 <530DC4D1.4060301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:04:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIcIE-00071J-Nx
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbaBZLEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 06:04:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:57277 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752596AbaBZLEf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 06:04:35 -0500
Received: (qmail 10488 invoked by uid 102); 26 Feb 2014 11:04:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Feb 2014 05:04:35 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Feb 2014 06:04:33 -0500
Content-Disposition: inline
In-Reply-To: <530DC4D1.4060301@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242717>

On Wed, Feb 26, 2014 at 11:41:21AM +0100, Michael Haggerty wrote:

> > Yes, though I think it makes sense to put them on a separate page. We
> > should probably write up some notes for students, too: how to get in
> > touch with us, what do we expect of them in the pre-proposal period,
> > what would we expect in terms of communication and day-to-day workflow
> > during the summer, etc.
> 
> Since time is short, I already started on this.  I wrote a first draft
> of an introduction for the students.  I also started looking for
> microprojects.  I started going through our source files alphabetically,
> and have already found six suggestions by "bundle.c", so I don't think
> there will be a problem finding enough tiny things to do.

Thanks, the intro text looks great.

We probably need some intro text to go on the ideas page (that is what
Google links to for prospective students) that points them to the
microproject page.

> See my branch on GitHub [1] or read the appended text below.

I've merged and pushed out your branch (I'll work on getting push access
for people, as there's no real reason for me to be an integration
bottleneck with this stuff).

> I've been looking for *really* tiny projects.  Feedback is welcome about
> whether they are too trivial to be meaningful in distinguishing
> promising students from no-hopers.  My feeling is that there is so much
> process involved in submitting a patch that it will take even a
> well-prepared student quite a while to make a change, no matter how trivial.

I really like the level of the projects below. It should be more about
the process than the code, and I think you nailed that. I especially
like the ones that require some digging in history.

The bug list I mentioned before is probably too heavyweight in that
sense (they're more like 4-6 hour projects for somebody who isn't
familiar with the code, plus submission headaches on top of that).

> Also, how many suggested microprojects do you think we need (i.e., when
> can I stop :-) )?

I think it depends on how quickly people do them. We can always add more
if they run low (though 6 does not provide a huge buffer, so we may want
a few more).

> 6.  Change `bundle.c:add_to_ref_list()` to use `ALLOC_GROW()`.

This is the only one that seemed like it might be _too_ trivial to me.
The memcpy/hashcpy one is similarly trivial, but I like the add-on of
"look for other places". I guess we could do that here, too.

-Peff
