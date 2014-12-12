From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] document string_list_clear
Date: Fri, 12 Dec 2014 16:27:26 -0500
Message-ID: <20141212212726.GA26284@peff.net>
References: <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <20141210084351.GA29776@peff.net>
 <20141210091815.GA18372@google.com>
 <20141212091625.GA9049@peff.net>
 <20141212183114.GA29365@google.com>
 <20141212192417.GA21132@peff.net>
 <20141212193552.GB29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 22:27:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzXkL-0003Q3-Vc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 22:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbaLLV13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 16:27:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:52300 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750774AbaLLV12 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 16:27:28 -0500
Received: (qmail 19855 invoked by uid 102); 12 Dec 2014 21:27:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 15:27:28 -0600
Received: (qmail 14227 invoked by uid 107); 12 Dec 2014 21:27:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 16:27:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Dec 2014 16:27:26 -0500
Content-Disposition: inline
In-Reply-To: <20141212193552.GB29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261374>

On Fri, Dec 12, 2014 at 11:35:52AM -0800, Jonathan Nieder wrote:

> If I were doing it, I would first de-asciidoc within technical/ and
> then move into the header in a separate patch.  Or first move with
> asciidoc intact and then de-asciidoc in a separate patch.  Combining
> the two into a single patch is also fine.  Please don't change wording
> at the same time.

Here's what I came up with. The first patch probably does more than
you'd like (and more than I would have done if I were starting from
scratch today). But I didn't want to get into undoing the stripping of
each function-name list item that I showed earlier, as it would be a lot
of tedious manual work. If we decide we want to keep those, I'm happy to
do the work to restore them, but it didn't seem like a good tradeoff
just to create an intermediate state to make the patch prettier.

I did split out some of the other formatting decisions, though, so they
can be evaluated individually.

  [1/4]: strbuf: migrate api-strbuf.txt documentation to strbuf.h
  [2/4]: strbuf.h: drop asciidoc list formatting from API docs
  [3/4]: strbuf.h: format asciidoc code blocks as 4-space indent
  [4/4]: strbuf.h: reorganize api function grouping headers

-Peff
