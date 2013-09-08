From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda
 conditions
Date: Sun, 8 Sep 2013 00:06:16 -0400
Message-ID: <20130908040615.GA14019@sigill.intra.peff.net>
References: <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
 <20130903111006.GJ29840@goldbirke>
 <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
 <20130903150855.GK29840@goldbirke>
 <20130903170419.GA29921@google.com>
 <xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
 <20130904171356.GD2582@serenity.lan>
 <xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
 <20130904183559.GA3465@sigill.intra.peff.net>
 <CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 06:06:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIWGi-0004cA-Cn
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 06:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090Ab3IHEGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 00:06:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:41922 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab3IHEGU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 00:06:20 -0400
Received: (qmail 29620 invoked by uid 102); 8 Sep 2013 04:06:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Sep 2013 23:06:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 00:06:16 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234171>

On Sat, Sep 07, 2013 at 10:11:49PM -0500, Felipe Contreras wrote:

> > Though I prefer the current, I can certainly live and adapt to a changed
> > standard, and I do not mind doing so if there is a good reason. But I've
> > yet to see any argument beyond "it is not what I like". Which to me
> > argues for the status quo as the path of least resistance.
> 
> Didn't Junio already provided reasoning?

If the reasoning is "cmp(actual, expect) makes more sense to humans"
then I do not think it is universal. Otherwise why would so many
existing test frameworks do it the other way? And that is why I said it
seems more like an issue of personal preference than a universal truth.

Was there some objective argument made that I missed?

> Here's more; human semantics:
> 
> Computer, compare A with B
> cmp(A, B)
> 
> Why would I write?
> 
> cmp(B, A)
> 
> Could you even construct an English sentence that starts with B, and then A?

"Computer, given that we expect B, how does A differ?". Or "Computer, we
expect B; does A match it?"

Or any number of variations. I'm sure you will say "but those seem
awkward and unlike how I think about it". But that was my point; it
seems to be a matter of preference.

-Peff
