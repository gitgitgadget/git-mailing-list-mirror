From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge & sequencer: turn "Conflicts:" hint into a comment
Date: Tue, 28 Oct 2014 18:22:38 -0400
Message-ID: <20141028222238.GC20722@peff.net>
References: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
 <xmqqvbn9f9ig.fsf@gitster.dls.corp.google.com>
 <xmqqr3xxf9ey.fsf_-_@gitster.dls.corp.google.com>
 <20141026185909.GC18144@peff.net>
 <20141027211441.GH5500@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 23:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjFA4-0001ek-TJ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 23:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbaJ1WWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 18:22:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:34732 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750786AbaJ1WWk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 18:22:40 -0400
Received: (qmail 9968 invoked by uid 102); 28 Oct 2014 22:22:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Oct 2014 17:22:40 -0500
Received: (qmail 28051 invoked by uid 107); 28 Oct 2014 22:22:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Oct 2014 18:22:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2014 18:22:38 -0400
Content-Disposition: inline
In-Reply-To: <20141027211441.GH5500@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 27, 2014 at 02:14:42PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > For the most part, combined-diff (and --cc) will show the interesting
> > cases anyway. But if you take a whole file from one side of the merge,
> > then there is nothing interesting for diff to show. Do people still want
> > to get that more complete list of potentially interesting files? And if
> > so, how do they do it?  I think there really isn't a great way besides
> > repeating the merge.
> 
> If you have time to experiment with tr/remerge-diff from pu[1], that
> would be welcome.

Thanks, that was the topic I was thinking of.

It's not very often that I want to carefully investigate merge commits
(usually it is when I am trying to help somebody track the addition or
deletion of content that came as part of an evil merge), but I'll give
it a try next time it comes up.

-Peff
