From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] Make 'git var GIT_PAGER' always print the
 configured pager
Date: Mon, 15 Feb 2010 02:57:52 -0500
Message-ID: <20100215075752.GC5347@coredump.intra.peff.net>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214115959.GB3499@progeny.tock>
 <20100215050007.GE3336@coredump.intra.peff.net>
 <20100215054447.GB22121@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 08:57:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngvq6-00017t-9m
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 08:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328Ab0BOH5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 02:57:49 -0500
Received: from peff.net ([208.65.91.99]:42168 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab0BOH5s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 02:57:48 -0500
Received: (qmail 15394 invoked by uid 107); 15 Feb 2010 07:57:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 02:57:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 02:57:52 -0500
Content-Disposition: inline
In-Reply-To: <20100215054447.GB22121@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139995>

On Sun, Feb 14, 2010 at 11:44:47PM -0600, Jonathan Nieder wrote:

> > I think this is the right thing to do. But isn't "git am" broken in the
> > meantime, as it now always paginates (whereas before, it would never
> > paginate)? You fix it later in the series, but is there any test
> > breakage in the meantime (not rhetorical, I didn't actually check) that
> > would hurt bisectability?
> 
> The behavior before dec543 (am -i, git-svn: use "git var GIT_PAGER",
> 2009-10-30) was to always paginate.  This made some sense, since this
> is the (v)iew command in git am --interactive; whether we check or
> not, presumably stdout is a terminal.  So for git am, this restores
> the older behavior.
> 
> There are unfortunately no tests for am --interactive in the test
> suite, so test suite runs would detect none of this.
> 
> Thank you for your attention to detail.

Makes sense. Thank _you_ for patches and for checking on my concerns.

-Peff
