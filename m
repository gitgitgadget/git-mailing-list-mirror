From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Tue, 18 Feb 2014 03:52:24 -0500
Message-ID: <20140218085224.GB2692@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
 <20140108093716.GE15720@sigill.intra.peff.net>
 <xmqqob32s08p.fsf@gitster.dls.corp.google.com>
 <20140124213521.GA26602@sigill.intra.peff.net>
 <9D08338A41454F778D03FB2E9F4B7DD1@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 09:52:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFgPn-0006sZ-IC
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 09:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbaBRIw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 03:52:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:52518 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754030AbaBRIw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 03:52:27 -0500
Received: (qmail 20960 invoked by uid 102); 18 Feb 2014 08:52:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Feb 2014 02:52:26 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Feb 2014 03:52:24 -0500
Content-Disposition: inline
In-Reply-To: <9D08338A41454F778D03FB2E9F4B7DD1@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242283>

On Sat, Feb 15, 2014 at 11:50:10AM -0000, Philip Oakley wrote:

> >>> This patch introduces the <branch>@{publish} shorthand (or
> >>> "@{pu}" to be even shorter).
> 
> Just to say that I'm not sure that "publish" is the best word for
> this concept.
> 
> To my mind something is published when some form of editorial
> oversight has been applied to the works. Such an understanding would
> better match the 'upstream' concept (e.g. $gmane/240230 jch/9Jan14).
> This should be distinguished from 'self-publishing', and again from
> 'vanity-publishing'.
> 
> In terms of the triangular work-flow such a 'publish' repo is
> somewhere between a vanity publishing, and self publishing (depending
> on the level of code cleanliness;-)

I would much rather have a name that describes what the thing _is_, then
how it is meant to be used. The concept of @{publish} is a shorthand for
"where would I push if I typed git push on this branch". In a
non-triangular workflow, that means sharing your commits with others on
the main branch. In a triangular workflow, it means sharing your commits
with a publishing point so that others can see them. If your default
push goes to a backup repo, it does not mean publishing at all, but
rather syncing the backup.

So I do not think any one word can describe all of those use cases; they
are orthogonal to each other, and it depends on your workflow.

In that sense, "publish" is not the best word, either, as it describes
only the first two, but not the third case (and those are just examples;
there may be other setups beyond that, even).

Perhaps "@{push}" would be the most direct word.

-Peff
