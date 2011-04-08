From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Fri, 8 Apr 2011 16:24:04 -0400
Message-ID: <20110408202404.GA16540@sigill.intra.peff.net>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:24:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8IE2-00016Q-Cz
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 22:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757840Ab1DHUYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 16:24:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48025
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757777Ab1DHUYH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 16:24:07 -0400
Received: (qmail 4724 invoked by uid 107); 8 Apr 2011 20:24:54 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 16:24:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 16:24:04 -0400
Content-Disposition: inline
In-Reply-To: <7vaag04k8m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171158>

On Fri, Apr 08, 2011 at 12:27:05PM -0700, Junio C Hamano wrote:

> > I have never been a fan of this reasoning. Sure, it is slightly harder
> > to help people when the system is configurable. But dropping
> > configurability comes at the cost of people who are using the system
> > day-to-day. And isn't making it pleasant to use every day more important
> > than the minority of times you are telling somebody else how to use it?
> 
> I probably should stated it differently.  I dropped it during this round
> because they are _not_ needed to help the transition, but it is a possible
> additional feature.

But in my earlier email, one of the users who is helped by this is one
who wants to silence the migration warning. So it is somewhat related to
the transition.

If we were in a world where "." and ":/" had always worked and there was
no variable, would I write a patch for the variable? Probably not,
especially because I think the full-tree behavior is what I would set it
to (and that is going to become the default).

But we don't live in that world. We are making a transition, and so it
may be worth it to help:

  1. People who want the new behavior _now_ without extra typing.

  2. Placate people who say "...but I liked the old behavior better".

I am in group (1). I don't know if people in group (2) need placating or
not, but I have grown to assume there will always be people to complain
about a change. :)

-Peff
