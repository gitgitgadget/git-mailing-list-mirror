From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Thu, 9 Jun 2016 02:58:06 -0400
Message-ID: <20160609065805.GA19015@sigill.intra.peff.net>
References: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
 <20160524191950.21889-1-pranit.bauva@gmail.com>
 <CAFZEwPOZSU315oCJSdawtacPmgZobCnkkguTnSy1_V7x_n09kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 08:58:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAtuz-00052Q-Q2
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 08:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933414AbcFIG6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 02:58:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:51754 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750881AbcFIG6J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 02:58:09 -0400
Received: (qmail 29388 invoked by uid 102); 9 Jun 2016 06:58:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 02:58:09 -0400
Received: (qmail 20778 invoked by uid 107); 9 Jun 2016 06:58:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 02:58:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2016 02:58:06 -0400
Content-Disposition: inline
In-Reply-To: <CAFZEwPOZSU315oCJSdawtacPmgZobCnkkguTnSy1_V7x_n09kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296874>

On Tue, Jun 07, 2016 at 08:25:17PM +0530, Pranit Bauva wrote:

> On Wed, May 25, 2016 at 12:49 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> > This is a follow up commit for f932729c (memoize common git-path
> > "constant" files, 10-Aug-2015).
> >
> > The many function calls to git_path() are replaced by
> > git_path_commit_editmsg() and which thus eliminates the need to repeatedly
> > compute the location of "COMMIT_EDITMSG".
> >
> > Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> > ---
> [...]
> Anyone any comments?

Looks good to me. You may want to re-post without the quoting to make it
easier for the maintainer to pick up, and feel free to add my:

  Reviewed-by: Jeff King <peff@peff.net>

-Peff
