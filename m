From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 18:16:47 -0400
Message-ID: <20130410221647.GB6930@sigill.intra.peff.net>
References: <20130410202456.GF24177@sigill.intra.peff.net>
 <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net>
 <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com>
 <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
 <20130410212911.GE27070@google.com>
 <CALkWK0m=iDw+N0zcfEEt1jzFD4wOOzLgyBWNyc=HZ+xLe5SBLw@mail.gmail.com>
 <20130410215658.GC6215@sigill.intra.peff.net>
 <CALkWK0=xzXu4_sh+7k0u-bb-=GNVSR9hq58QJsHiBZKRzfgh_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 00:17:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ3K7-00060M-6D
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 00:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763325Ab3DJWQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 18:16:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39352 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab3DJWQy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 18:16:54 -0400
Received: (qmail 8822 invoked by uid 107); 10 Apr 2013 22:18:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 18:18:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 18:16:47 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=xzXu4_sh+7k0u-bb-=GNVSR9hq58QJsHiBZKRzfgh_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220787>

On Thu, Apr 11, 2013 at 03:36:10AM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > It's not that it's not potentially useful. It's that it may be
> > surprising and annoying to users who did not want that.
> 
> ... but this is a new syntax, and doesn't break any existing
> expectations.  Why are you imagining what users will expect with a git
> push -- master next; that hasn't been invented yet?

Didn't I already say that I expected a different behavior than you are
proposing from "git push -- v1.2.3 master"? 

Yes, it is possible to lay out all of the rules in the manpage so that
the user can predict what will happen. But users do not always know or
remember all of those rules, especially if it "just works" most of the
time (e.g., they usually push two branches, but this time push a tag).
If a command is easy to screw up, people will screw it up, and get
surprised and annoyed when it happens. We can say "well, you should have
read the manpage", but it is much nicer if we can come up with a command
that is harder to screw up.

-Peff
