From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] refs: speed up is_refname_available
Date: Wed, 10 Sep 2014 21:39:03 -0400
Message-ID: <20140911013903.GA5525@peff.net>
References: <20140910101730.GA12399@peff.net>
 <20140910111155.GA14995@peff.net>
 <xmqqk35bf764.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 03:39:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRtLt-0008JX-Gk
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 03:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbaIKBjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 21:39:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:46861 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751250AbaIKBjI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 21:39:08 -0400
Received: (qmail 26446 invoked by uid 102); 11 Sep 2014 01:39:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 20:39:07 -0500
Received: (qmail 22319 invoked by uid 107); 11 Sep 2014 01:39:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 21:39:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2014 21:39:03 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk35bf764.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256811>

On Wed, Sep 10, 2014 at 03:21:39PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ...
> > Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Sorry for the quick v2; Michael and I crossed emails off-list, and I
> > missed some of his review. This version has some minor style and comment
> > fixups.
> 
> Looks sensible from a cursory read, but it conflicts heavily with
> 54e696fc (refs.c: pass a skip list to name_conflict_fn, 2014-07-16)
> which is queued early on 'pu', and I am definitely not in the
> business of re-designing that huge topic myself.

Did you miss the part in v1 where I pointed to a tree with a proposed
resolution? :)

I am also happy to rebase if the other bits are coming to master soon.

-Peff
