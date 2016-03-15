From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone tests: rename t57* => t56*
Date: Tue, 15 Mar 2016 18:09:03 -0400
Message-ID: <20160315220903.GA30488@sigill.intra.peff.net>
References: <1458077150-15564-1-git-send-email-sbeller@google.com>
 <20160315215121.GA30011@sigill.intra.peff.net>
 <CAGZ79kZWMhL5kTHU8gdPvm=VqDb58H0ZkNyop=c=P6bLLY1JLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 23:09:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afx9M-00087n-V2
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 23:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932922AbcCOWJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 18:09:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:60188 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932195AbcCOWJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 18:09:07 -0400
Received: (qmail 14032 invoked by uid 102); 15 Mar 2016 22:09:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Mar 2016 18:09:05 -0400
Received: (qmail 7432 invoked by uid 107); 15 Mar 2016 22:09:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Mar 2016 18:09:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Mar 2016 18:09:03 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZWMhL5kTHU8gdPvm=VqDb58H0ZkNyop=c=P6bLLY1JLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288925>

On Tue, Mar 15, 2016 at 03:00:09PM -0700, Stefan Beller wrote:

> Talking about ordering, I have two use cases
> 
> 1) Before sending out patches: "git rebase -i -x make -x 'make test' <anchor>"
>   to catch myself for doing stupid things.
> 
> 2) When developing new code, I alternate between running an indivdual test
>   "cd t && GIT_TRACE=1 ./t7400... -d -i -x -v " and running prove for all tests
>   to have a good check if there are other niches I missed.

Yep, that is roughly my workflow, too (with the occasional "make test &&
make install" thrown in). :)

> So I do not really have strong preference for the right order, I even
> thought about omitting the paragraph from the commit message and
> wanted to put it into the notes below, but then I figured I want to
> record it as I was frustrated about the commit messages from 2006 as
> they don't answer simple questions like "Why did you use a different
> second digit?", so I figured if anyone digs up my commit eventually I
> want to record as much of my current reasoning even if it is minor to
> help a future developer?

I agree it is worth mentioning that you considered the order. I think
what you wrote was fine, though I probably would have said something
like:

  Moving t57* to higher digits in t56* preserves the existing ordering.
  That may or may not matter to anyone, but it does not hurt to keep it.

-Peff
