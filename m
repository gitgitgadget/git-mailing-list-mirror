From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Fri, 22 Mar 2013 10:59:36 -0400
Message-ID: <20130322145936.GD3083@sigill.intra.peff.net>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-4-git-send-email-artagnon@gmail.com>
 <20130322144454.GA3083@sigill.intra.peff.net>
 <7vmwtv8p1c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 16:00:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3S4-0000YO-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 16:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933730Ab3CVO7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 10:59:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35769 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933673Ab3CVO7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 10:59:44 -0400
Received: (qmail 1353 invoked by uid 107); 22 Mar 2013 15:01:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 11:01:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 10:59:36 -0400
Content-Disposition: inline
In-Reply-To: <7vmwtv8p1c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218810>

On Fri, Mar 22, 2013 at 07:52:47AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think this is OK, and I do not mind if it gets applied. But what I was
> > hinting at in my earlier mail was that we might want to do this (I have
> > it as a separate patch on top of your 3/6 here, but it would make more
> > sense squashed in):
> 
> I would prefer to see a preparatory patch to teach mk_test/mk_empty
> to _always_ take the new name (i.e. the result of your patch) and
> then do whatever new things on top.

I think that is what my patch does (it is meant to come at the point of
3/6, and then the rest would need to be rebased to just use "mk_test"
instead of "mk_test_with_name").

> By the way, I am planning to _not_ look at new stuff today. I'd
> rather see known recent regressions addressed (and unknown ones
> discovered and squashed) before we move forward, and I would
> appreciate if regular contributors did the same.

Yeah, I have several to look at (the "subdir/" in gitattributes is the
biggest one, I think).

-Peff
