From: Jeff King <peff@peff.net>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Thu, 16 Aug 2012 12:21:42 -0400
Message-ID: <20120816162142.GC2853@sigill.intra.peff.net>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch>
 <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
 <7v628lbdcw.fsf@alter.siamese.dyndns.org>
 <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
 <87lihh8c7s.fsf@thomas.inf.ethz.ch>
 <7vr4r98ah5.fsf@alter.siamese.dyndns.org>
 <87sjbo63pl.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 16 18:21:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T22pT-0004y9-Q0
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 18:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276Ab2HPQVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 12:21:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39212 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030194Ab2HPQVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 12:21:45 -0400
Received: (qmail 18556 invoked by uid 107); 16 Aug 2012 16:21:55 -0000
Received: from 1153ahost247.starwoodbroadband.com (HELO sigill.intra.peff.net) (12.144.188.247)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Aug 2012 12:21:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2012 12:21:42 -0400
Content-Disposition: inline
In-Reply-To: <87sjbo63pl.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2012 at 08:59:02AM +0200, Thomas Rast wrote:

> I have never had a need for a fetch that doesn't update the remote
> namespace, nor heard anyone on IRC who has.  OTOH, I do have anecdotal
> evidence in support of "the current state is confusing": this thread, or
> the fact that Jan's IRC bot grew bot-quotes !fetch4/!pull4 that people
> use to warn users of 'git pull origin master' (it's apparently very
> common).
> 
> The 1.8.0 thread is here, and Peff even said he had a patch he uses in
> his tree:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/165720/focus=165758
> 
> There's even a newer thread suggesting the same:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/192252

Yeah, I have been running with that patch for ages, and it has never
been a problem for me. Of course, the problem cases are very specific
workflows that I do not happen to use. There are definitely regressions
for some workflows; the question is whether or not anybody is using
those workflows (and/or would be bothered to adapt to using the reflog
instead).

Also note that there are several test failures with the patch, but I
haven't investigated them (i.e., I don't know if the patch is buggy, if
it is breaking a test in a way that is different than the expected
regression, or if the test simply happens to depend on the current
behavior and should be fixed).

-Peff
