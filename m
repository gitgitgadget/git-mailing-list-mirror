From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 40/43] refs: allow ref backend to be set for clone
Date: Mon, 5 Oct 2015 21:58:07 -0400
Message-ID: <20151006015806.GA4972@sigill.intra.peff.net>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
 <1443477738-32023-41-git-send-email-dturner@twopensource.com>
 <5612439E.4080200@alum.mit.edu>
 <1444094977.7739.24.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 03:58:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjHWJ-0006Ov-A6
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 03:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbbJFB6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 21:58:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:39982 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751600AbbJFB6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 21:58:12 -0400
Received: (qmail 26009 invoked by uid 102); 6 Oct 2015 01:58:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Oct 2015 20:58:12 -0500
Received: (qmail 18769 invoked by uid 107); 6 Oct 2015 01:58:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Oct 2015 21:58:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Oct 2015 21:58:07 -0400
Content-Disposition: inline
In-Reply-To: <1444094977.7739.24.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279112>

On Mon, Oct 05, 2015 at 09:29:37PM -0400, David Turner wrote:

> > Therefore, I don't think this can be merged without a bump to
> > core.repositoryformatversion. Such a bump will tell well-behaved older
> > Git clients keep their hands off the repository. (Of course repositories
> > that use the files backend can continue using
> > core.repositoryformatversion 0.)
> > 
> > I thought Peff proposed a way to do such a bump, including a way to
> > extend repositories one by one with new features. But that was something
> > that we were chatting about off-list.
> > 
> > I haven't reviewed the actual code in this patch yet but I wanted to get
> > the above comment on your radar.
> > 
> > Michael
> 
> I'll fix this to upgrade to v=1 when the lmdb refs backend is in use,
> and to give sensible error messages in a v1 repo if built without LMDB.

I think the relevant series is:

  http://article.gmane.org/gmane.comp.version-control.git/272447

It did not seem too controversial, but it mostly got dropped amidst the
release, and I haven't reposted it yet.

-Peff
