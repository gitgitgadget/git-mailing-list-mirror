From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 4 May 2016 04:57:08 -0400
Message-ID: <20160504085708.GA17920@sigill.intra.peff.net>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
 <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
 <1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
 <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com, gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:57:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axscR-00062L-Ew
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757781AbcEDI5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:57:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:33799 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757631AbcEDI5L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:57:11 -0400
Received: (qmail 30666 invoked by uid 102); 4 May 2016 08:57:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 04:57:11 -0400
Received: (qmail 8579 invoked by uid 107); 4 May 2016 08:57:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 04:57:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 04:57:08 -0400
Content-Disposition: inline
In-Reply-To: <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293526>

On Wed, May 04, 2016 at 10:43:04AM +0200, Lars Schneider wrote:

> > diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> > index 73fd9e8..6538cb1 100644
> > --- a/Documentation/git-filter-branch.txt
> > +++ b/Documentation/git-filter-branch.txt
> > @@ -205,8 +205,8 @@ to other tags will be rewritten to point to the underlying commit.
> > Remap to ancestor
> > ~~~~~~~~~~~~~~~~~
> > 
> > -By using linkgit:rev-list[1] arguments, e.g., path limiters, you can limit the
> > -set of revisions which get rewritten. However, positive refs on the command
> > +By using linkgit:git-rev-list[1] arguments, e.g., path limiters, you can limit
> > +the set of revisions which get rewritten. However, positive refs on the command
> 
> All other linkgit fixes seem legimiate to me although I am not sure of this case
> 
> -linkgit:rev-list[1] 
> +linkgit:git-rev-list[1]
>   
> "rev-list" works but I think "git-rev-list" would be the canonical form?
> See: https://git-scm.com/docs/git-filter-branch

It should definitely be "git-rev-list". The "linkgit" macro will format
whatever text you feed it. For the manpages, that doesn't matter,
because they don't actually hyperlink. But for other formats (like
HTML), using just "rev-list" will generate a broken link.

-Peff
