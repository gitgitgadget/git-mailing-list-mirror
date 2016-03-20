From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add the tag.gpgsign option to sign all created tags
Date: Sun, 20 Mar 2016 12:52:17 -0400
Message-ID: <20160320165216.GA5710@sigill.intra.peff.net>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320122023.GA5139@spk-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Laurent Arnoud <laurent@spkdev.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 17:52:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahgaX-0006so-MO
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 17:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbcCTQwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 12:52:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:34921 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751384AbcCTQwU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 12:52:20 -0400
Received: (qmail 27594 invoked by uid 102); 20 Mar 2016 16:52:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 12:52:19 -0400
Received: (qmail 29538 invoked by uid 107); 20 Mar 2016 16:52:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 12:52:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2016 12:52:17 -0400
Content-Disposition: inline
In-Reply-To: <20160320122023.GA5139@spk-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289367>

On Sun, Mar 20, 2016 at 01:20:23PM +0100, Laurent Arnoud wrote:

> Hi Jeff,
> 
> On Sun, Mar 20, 2016 at 12:29:12AM -0400, Jeff King wrote:
> > We have commit.gpgsign, so this makes some sense. Would you want to sign
> > _all_ tags created with "git tag", including lightweight tags, or only
> > those that would already create a tag object (i.e., annotated tags)?
> 
> Yes those that create a tag object (annotated tags).
> All you suggestions make sense and I will prepare a patch v2.

That behavior makes more sense to me, but I don't think it's what your
patch does (v1 or v2). Perhaps it would make sense to add some tests,
both to verify that it is behaving as expected, and to protect that
behavior from future changes?

-Peff
