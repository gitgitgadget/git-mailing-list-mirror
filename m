From: Jeff King <peff@peff.net>
Subject: Re: Bug: Branch Deletion Doesn't Clean Up
Date: Thu, 4 Feb 2016 03:29:11 -0500
Message-ID: <20160204082911.GA23479@sigill.intra.peff.net>
References: <4AC354E1-9E78-42A8-9828-BF1C084A6CBB@me.com>
 <20160204075500.GA21161@sigill.intra.peff.net>
 <20160204081220.GA11434@glandium.org>
 <20160204081759.GA23259@sigill.intra.peff.net>
 <20160204082613.GA14076@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karl Moskowski <kmoskowski@me.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 09:29:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFHx-0005g4-Uv
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 09:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbcBDI3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 03:29:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:37289 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754123AbcBDI3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 03:29:13 -0500
Received: (qmail 17355 invoked by uid 102); 4 Feb 2016 08:29:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 03:29:14 -0500
Received: (qmail 490 invoked by uid 107); 4 Feb 2016 08:29:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 03:29:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Feb 2016 03:29:11 -0500
Content-Disposition: inline
In-Reply-To: <20160204082613.GA14076@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285412>

On Thu, Feb 04, 2016 at 05:26:13PM +0900, Mike Hommey wrote:

> > There are a few reasons not to:
> > 
> >   - it breaks backwards compatibility (unless we continue to create the
> >     directory in order to put the dot-lock in it, but then I don't think
> >     we've gained anything)
> 
> Is that the kind of backwards compatibility that matters, though? I
> mean, I won't claim to know all the internals of how refs are used, but
> you sound like the theoretical incompatibility would be two different
> versions of git racing for update-ref on the same local repository.

Yes, that's true. It's a lesser breakage than "you cannot go back to the
old version at all".

-Peff
