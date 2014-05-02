From: Jeff King <peff@peff.net>
Subject: Re: Pull is Mostly Evil
Date: Fri, 2 May 2014 18:36:13 -0400
Message-ID: <20140502223612.GA11374@sigill.intra.peff.net>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5363edc954f8e_70ef0f30c24@nysa.notmuch>
 <20140502214817.GA10801@sigill.intra.peff.net>
 <536414352fa24_1976139f2f0f9@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:36:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgM43-0005eK-FC
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbaEBWgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:36:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:43911 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751648AbaEBWgP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 18:36:15 -0400
Received: (qmail 28842 invoked by uid 102); 2 May 2014 22:36:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 May 2014 17:36:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 May 2014 18:36:13 -0400
Content-Disposition: inline
In-Reply-To: <536414352fa24_1976139f2f0f9@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248000>

On Fri, May 02, 2014 at 04:55:01PM -0500, Felipe Contreras wrote:

> They can do:
> 
> % git pull origin master
> 
> That shouldn't revese the bases.

Then they have to remember to do that every time, no? That seems a
little error-prone versus setting a config option.

> > Such users are going to run "git pull origin master" or just "git pull"
> > to get that merge.
> 
> I'd say the vast majority of users running "git pull" want the parents
> reversed, the minority that doesn't can switch to "git pull origin
> master" (or add a configuration).

I'm not sure I agree, but I don't think either of us has actual data.

> Most likely the consensus and the proposals will be ignored and nothing
> will change as usual, but that's a different thing.

Is it truly necessary to make sniping comments like this at the end of
each email? It _is_ being discussed right now, and these comments do
nothing except irritate your readers. Please stop.

-Peff
