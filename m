From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] fetch: add missing documentation
Date: Tue, 24 Sep 2013 02:10:43 -0400
Message-ID: <20130924061043.GA6678@sigill.intra.peff.net>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
 <1379772563-11000-2-git-send-email-felipe.contreras@gmail.com>
 <20130924050343.GF2766@sigill.intra.peff.net>
 <CAMP44s1FFTS=wOcWBfqg3zt3TO-aM83oXHcGwBcwvt_HnXrn8g@mail.gmail.com>
 <20130924053023.GA5875@sigill.intra.peff.net>
 <CAMP44s1ezYMSuQRMp_SY1HqLiuyuf0tjuf3Fn6fXF2drODZ_iw@mail.gmail.com>
 <20130924054053.GA6192@sigill.intra.peff.net>
 <CAMP44s3QfkvXjgmhWPXN7qonbEPpvJFyVm82EBOMSjX7ng3OQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 08:11:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOLpy-0007WB-5S
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 08:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784Ab3IXGK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 02:10:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:53408 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714Ab3IXGKq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 02:10:46 -0400
Received: (qmail 2423 invoked by uid 102); 24 Sep 2013 06:10:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 01:10:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 02:10:43 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3QfkvXjgmhWPXN7qonbEPpvJFyVm82EBOMSjX7ng3OQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235272>

On Tue, Sep 24, 2013 at 12:57:36AM -0500, Felipe Contreras wrote:

> No, I'm not. The users that know branch.*.remote exists know why it
> exists. The part where it is explained, 'git config --help', is
> perfectly clear: "When on branch <name>, it tells 'git fetch' and 'git
> push' which remote to fetch from/push to.". So what does
> branch.<name>.remote does, if not precisely what the documentation
> says?
> 
> This is not a rhetorical question, I'm actually expecting you to
> answer, if a user knows that branch.<name>.remote exists, how would
> the above confuse him?

I do not know if by "above" you mean the part of git-config.1 you quoted
above, or the text you are proposing to put into git-fetch.1.

If the former, then I do not think it is confusing at all. The existing
text explains exactly what is going on.

If the latter, then my concern is that the term "upstream branch"
implies implies that "git fetch" depends on branch.*.merge, but it does
not.

> > I was hoping you might suggest something that can help both users by
> > being both precise and giving the appropriate breadcrumbs.
> 
> This is documentation for a Git porcelain command,
> branch.<name>.remote is an implementation detail, and it's irrelevant
> in the documentation at this level.

I don't think it is the end of the world if we say "upstream branch". I
was hoping to find a term that could be both friendly and accurate.

And failing that, I hoped you might say "I see what you are saying, but
I cannot think of a term that is more precise that does not sacrifice
friendliness". But as I seem incapable of even communicating the issue
to you, I'm giving up. It is not worth wasting more time on it.

-Peff
