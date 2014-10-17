From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 21/25] rev-list: add --index-objects option
Date: Thu, 16 Oct 2014 20:43:46 -0400
Message-ID: <20141017004346.GD7848@peff.net>
References: <20141015223244.GA25368@peff.net>
 <20141015224430.GU25630@peff.net>
 <xmqqiojjuaao.fsf@gitster.dls.corp.google.com>
 <20141017001230.GB7848@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 02:43:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xeve4-0003hW-W1
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 02:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbaJQAnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 20:43:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:59467 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751382AbaJQAns (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 20:43:48 -0400
Received: (qmail 5108 invoked by uid 102); 17 Oct 2014 00:43:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 19:43:48 -0500
Received: (qmail 4109 invoked by uid 107); 17 Oct 2014 00:43:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 20:43:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2014 20:43:46 -0400
Content-Disposition: inline
In-Reply-To: <20141017001230.GB7848@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 08:12:31PM -0400, Jeff King wrote:

> > "--indexed-objects" (short for "--show-objects-in-the-index") or
> > something?
> 
> That sounds reasonable. We could technically do `--indexed` as that is
> different from `--index`, but maybe they are still confusingly close.

Here's a re-roll of the final 5 patches of the series with the updated
name (`--indexed-objects`). The name change cascades from patch 22 to
patches 23 and 25 (and I renamed the matching pack-objects option as
well). 24 and 26 are unchanged, but I figured it is easier on you to
replace the whole block of patches at once.

  [22/26]: rev-list: add --indexed-objects option
  [23/26]: reachable: use revision machinery's --indexed-objects code
  [24/26]: pack-objects: use argv_array
  [25/26]: repack: pack objects mentioned by the index
  [26/26]: pack-objects: double-check options before discarding objects
