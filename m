From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Fri, 22 Nov 2013 12:26:27 -0500
Message-ID: <20131122172626.GA4881@sigill.intra.peff.net>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
 <20131122102345.GC12042@sigill.intra.peff.net>
 <87d2lsjs4q.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Nov 22 18:26:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjuV0-0005sV-Oy
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 18:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856Ab3KVR03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 12:26:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:43883 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755816Ab3KVR02 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 12:26:28 -0500
Received: (qmail 1060 invoked by uid 102); 22 Nov 2013 17:26:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Nov 2013 11:26:28 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Nov 2013 12:26:27 -0500
Content-Disposition: inline
In-Reply-To: <87d2lsjs4q.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238199>

On Fri, Nov 22, 2013 at 05:52:37PM +0100, Thomas Rast wrote:

> > Looks like you picked up my latest re-roll with Ramsay's fix on top.
> > There wasn't a lot of review on this past round (I'm not surprised; it's
> > a dauntingly large chunk to review).  I outlined a few possible open
> > issues in the cover letter, but I'd be happy to build those on top,
> > which I think will make review of them a lot easier.
> >
> > Do we want to try this in 'next' post-1.8.5, or should I try to prod an
> > area expert like Shawn into doing another round of review?
> 
> Hmm, maybe I missed something, but AFAICS you (or Vicent) never acted on
> or responded to my June reviews in this thread:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/228918
> 
> and again mentioned here, though I didn't point out all of them:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/236587/focus=236740

Sorry, I didn't respond directly to the email. Vicent did a pass for
style and documentation shortly after the initial series, and then I did
another pass in the most recent re-roll, adding a C fallback for the
gcc builtin. I thought that covered it, but:

> Granted, the way I verified this was checking whether you renamed
> rlw_xor_run_bit() to something more fitting, so perhaps you just forgot
> that one thing but did all the rest.

I didn't touch that. Vicent, did you have a comment on the name (it
really does look like it is a negation, and the only caller is
ewah_not).

-Peff
