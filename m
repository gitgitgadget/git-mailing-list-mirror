From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda
 conditions
Date: Sun, 8 Sep 2013 19:45:19 -0400
Message-ID: <20130908234519.GA11860@sigill.intra.peff.net>
References: <20130904171356.GD2582@serenity.lan>
 <xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
 <20130904183559.GA3465@sigill.intra.peff.net>
 <CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
 <20130908040615.GA14019@sigill.intra.peff.net>
 <CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
 <20130908042649.GC14019@sigill.intra.peff.net>
 <CAMP44s1uasvGmCMkMF2N0eTMgOdksG0HqeidXK+159HAi4jkpA@mail.gmail.com>
 <20130908050227.GG14019@sigill.intra.peff.net>
 <CAMP44s1HXeQ1pgCeY=RsDcx4H--YHBfzmoQ4rjJ37t5N30pq5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 01:45:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIofW-0005zj-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 01:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862Ab3IHXpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 19:45:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:49641 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab3IHXpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 19:45:22 -0400
Received: (qmail 21231 invoked by uid 102); 8 Sep 2013 23:45:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 18:45:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 19:45:19 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1HXeQ1pgCeY=RsDcx4H--YHBfzmoQ4rjJ37t5N30pq5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234285>

On Sun, Sep 08, 2013 at 06:25:45PM -0500, Felipe Contreras wrote:

> > And I do not think it is a problem. The point of the function is not to
> > abstract away the idea of comparison. The point is to give a hook for
> > people on systems without "diff -u" to run the test suite.
> 
> The point according to whom? I say it's the other way around.

The point according to 82ebb0b (add test_cmp function for test scripts,
2008-03-12). I wish I had simply called it test_diff back then, and then
this conversation could have never occurred.

> Either way the fact that others are doing it differently doesn't mean
> that's the best way, that would be argumentum ad populum, and mothers
> are keen to remind us that if other kids are jumping the bridge, that
> doesn't mean we should too.

Did I once say "my way of thinking about it is the best way"? No. I said
"I think it is a matter of preference". I mentioned other systems using
a particular ordering to show that the set of people who prefer it the
other way is non-zero.

Feel free to respond, but I have no interest in discussing this any
further with you. This thread has become a giant time sink, and I have
nothing else to say on the matter that I have not already said.

-Peff
