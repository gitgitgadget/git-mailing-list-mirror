From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Fri, 16 May 2014 18:52:28 -0400
Message-ID: <20140516225228.GA3988@sigill.intra.peff.net>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 00:52:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlQzZ-0006BO-SX
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 00:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517AbaEPWwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 18:52:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:53457 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756498AbaEPWwa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 18:52:30 -0400
Received: (qmail 18483 invoked by uid 102); 16 May 2014 22:52:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 May 2014 17:52:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 May 2014 18:52:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249427>

On Fri, May 16, 2014 at 09:52:15AM -0700, Junio C Hamano wrote:

> Or am I reacting to a typo and you meant to say "I would prefer not
> to instrument"?  Your "shipping the warnings to end users who did
> not package the software will not help" was unclear if you meant the
> README that has warning or warning message they have to see every
> time from the instrumented code.

Argh, yes, it is a typo. I had written "I would prefer _not_ to
instrument the code with warnings...". While reading it back to myself,
I thought "using underlining there is too argumentative", but somehow
managed to delete the whole word rather than simply the "_" characters.
I'm very sorry to have wasted people's time by accidentally making the
opposite point.

I agree with the line of reasoning you laid out in your email,
especially:

> I would say that the options I see are these three, and I would rank
> the "warn every time" as less helpful to end-users:
> 
>  - rename contrib/remote-helpers to contrib/obsolete-remote-helpers
>    and add README to point at the upstream.
> 
>  - remove contrib/remote-helpers scripts and add README.
> 
>  - warn every time the user runs the scripts.

I hadn't thought of the rename idea, and it would address the concerns I
brought up. I do think "obsolete" is the wrong word, as it sends the
wrong message. The helpers are not obsolete; it is our _copy_ of them
that is.

-Peff
