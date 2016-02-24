From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/5] Make README more pleasant to read
Date: Wed, 24 Feb 2016 05:22:47 -0500
Message-ID: <20160224102247.GA21152@sigill.intra.peff.net>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, emma.westby@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:22:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYWaw-0005lw-2t
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 11:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbcBXKWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 05:22:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:48185 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752641AbcBXKWu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 05:22:50 -0500
Received: (qmail 27939 invoked by uid 102); 24 Feb 2016 10:22:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:22:50 -0500
Received: (qmail 6819 invoked by uid 107); 24 Feb 2016 10:22:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:22:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 05:22:48 -0500
Content-Disposition: inline
In-Reply-To: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287189>

On Tue, Feb 23, 2016 at 06:40:24PM +0100, Matthieu Moy wrote:

> This patch series was inspired by a discussion I had with Emma Jane
> after Git Merge last year. It tries both to make the README file less
> agressive and generally more pleasant to read.
> 
> To get a quick overview, compare the old one:
> 
>   https://github.com/git/git#readme
> 
> and my proposal:
> 
>   https://github.com/moy/git/tree/git-readme#readme
> 
> Matthieu Moy (5):
>   README: use markdown syntax
>   README.md: add hyperlinks on filenames
>   README.md: move the link to git-scm.com up
>   README.md: don't call git stupid in the title
>   README.md: move down historical explanation about the name

Thanks for working on this. I think the end product is much nicer on the
web, with very little downside for local viewing.

I'm especially happy about the final patch. I don't look at Git's README
often, but I always cringe when I see that intro paragraph and think
that it's some people's first introduction to what git is.

>  README => README.md | 54 ++++++++++++++++++++++++++++-------------------------
>  t/t7001-mv.sh       |  2 +-

I do not overly care, but I wonder if it would be nice to keep README as
a symlink. I don't think that complicates things for people checking out
on Windows (we already have RelNotes as a symlink, and IIRC they just
get a file with the link contents. Not helpful, but not harmful to them
either).

-Peff
