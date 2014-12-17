From: Jeff King <peff@peff.net>
Subject: Re: Improving git branch
Date: Wed, 17 Dec 2014 16:01:48 -0500
Message-ID: <20141217210148.GA26551@peff.net>
References: <CAHQ6N+qBUcBcG8RC6Co+k_GmJDXCynmyfZmvTjz4bQyH1wG3DA@mail.gmail.com>
 <549168DD.1080906@drmicha.warpmail.net>
 <xmqqvbla80bm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 22:01:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1LjH-0003Nb-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 22:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbaLQVBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 16:01:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:54036 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751078AbaLQVBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 16:01:50 -0500
Received: (qmail 31793 invoked by uid 102); 17 Dec 2014 21:01:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Dec 2014 15:01:50 -0600
Received: (qmail 2084 invoked by uid 107); 17 Dec 2014 21:01:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Dec 2014 16:01:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Dec 2014 16:01:48 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvbla80bm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261497>

On Wed, Dec 17, 2014 at 12:53:49PM -0800, Junio C Hamano wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > Rather than extending "git branch" any further[*], I suggest a bolder
> > strategy:
> >
> > - unify/merge for-each-ref and pretty formats (and code) as far as possible
> > - leverage that for the list modes of branch and tag
> >
> > That would allow everyone to get their favourite listing, just like for
> > logs. Otherwise it would be very difficult to agree on *the* proper
> > format for an extended branch or tag list.
> >
> > Michael
> >
> >
> > [*] I know I'm a sinner, too.
> 
> Actually this is not a "bolder" strategy, but the unification has
> been discussed and agreed to be the longer-term direction for quite
> a while, I think.  Didn't Peff have this in his "things to do when
> absolutely bored" box?

Yes. It is not even in my "absolutely bored" box, but rather the "I
would like to work on this but somehow other crap keeps coming up" box.

The last blocker I ran into was that we need to unify the "--contains"
implementation for "git tag" and "git branch". If anybody wants to push
this forward, I think that is the best place to start. I can dig up
references if anybody is interested.

-Peff
