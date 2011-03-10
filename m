From: Jeff King <peff@peff.net>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 13:46:53 -0500
Message-ID: <20110310184653.GA17832@sigill.intra.peff.net>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net>
 <20110310001017.GA24169@elie>
 <201103101815.23477.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 10 19:47:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxkt4-0005EE-3L
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 19:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767Ab1CJSq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 13:46:56 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36806
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125Ab1CJSq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 13:46:56 -0500
Received: (qmail 29710 invoked by uid 107); 10 Mar 2011 18:47:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 13:47:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 13:46:53 -0500
Content-Disposition: inline
In-Reply-To: <201103101815.23477.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168842>

On Thu, Mar 10, 2011 at 06:15:23PM +0100, Thomas Rast wrote:

> * Clean up add -p
> 
>   git-add--interactive.perl became a bit of a mess.  Partly due to my
>   own efforts with {checkout,stash,...} it has bolted-on interfaces to
>   other commands.  There are some UI issues that simply fall out of
>   its design, e.g., you cannot go back from one file to another,
>   Ctrl-C stops applying to the current file but does not discard
>   earlier files, etc.  And that's not saying anything about 'add -i'
>   which I don't really know.
> 
>   This would probably not be a very fun project, but it could add a
>   little edge of usability to the tool and it's probably one of the
>   few pure-Perl ideas we can offer.

One more wishlist item for this. I use "add -p" for almost all of my
adds these days, because I like the final review check. So after a
conflicted merge, I find myself doing "add -p" to stage my resolution.
The current behavior is that it shows the --cc diff and exits. It would
be cool to handle staging the resolution, which would involve converting
the combined diff into something that can be applied.

> I'd be interested to hear how that goes, because I think the tools are
> fundamentally different.  The rebase and thus sequencer family is
> delta-based, and the fast-import and filter-branch families are
> tree-based.  Feel free to prove me wrong of course.

Hmm, yeah, that is a fundamental difference. It might be possible to
overcome it, but I admit I haven't really given it any thought yet at
this point.

-Peff
