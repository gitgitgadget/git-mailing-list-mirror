From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] sha1_name: implement @{push} shorthand
Date: Tue, 31 Mar 2015 18:33:33 -0400
Message-ID: <20150331223332.GD31948@peff.net>
References: <20150331173339.GA17732@peff.net>
 <20150331173834.GF18912@peff.net>
 <CAPig+cR9U9Tm1Lbk_wQpfvY7okEKvYgMvNRzT1ci2u9ALr0HpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:33:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd4j6-0005aG-GA
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbbCaWdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 18:33:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:40714 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751496AbbCaWdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 18:33:35 -0400
Received: (qmail 30565 invoked by uid 102); 31 Mar 2015 22:33:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 17:33:35 -0500
Received: (qmail 29523 invoked by uid 107); 31 Mar 2015 22:33:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 18:33:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 18:33:33 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cR9U9Tm1Lbk_wQpfvY7okEKvYgMvNRzT1ci2u9ALr0HpQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266573>

On Tue, Mar 31, 2015 at 05:41:02PM -0400, Eric Sunshine wrote:

> On Tue, Mar 31, 2015 at 1:38 PM, Jeff King <peff@peff.net> wrote:
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> > index 0796118..5d9df25 100644
> > --- a/Documentation/revisions.txt
> > +++ b/Documentation/revisions.txt
> > @@ -98,6 +98,31 @@ some output processing may assume ref names in UTF-8.
> >    `branch.<name>.merge`).  A missing branchname defaults to the
> >    current one.
> >
> > +'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
> > +  The suffix `@{push}` reports the branch "where we would push to" if
> > +  `git push` were run while `branchname` was checked out (or the current
> > +  `HEAD` is no branchname is specified). Since our push destination is
> 
> s/is no/if no/

Thanks, fixed for my re-roll.

-Peff
