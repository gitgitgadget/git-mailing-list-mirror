From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] push: allow --follow-tags to be set by config
 push.followTags
Date: Sat, 14 Mar 2015 13:34:24 -0400
Message-ID: <20150314173424.GB32599@peff.net>
References: <20150216061051.GA29895@peff.net>
 <20150216061619.GC32381@peff.net>
 <xmqqh9toxgdd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Olszewski <cxreg@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 18:34:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWpxH-0004xw-Ae
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 18:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbbCNRe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 13:34:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:33076 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751688AbbCNRe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 13:34:26 -0400
Received: (qmail 26809 invoked by uid 102); 14 Mar 2015 17:34:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Mar 2015 12:34:26 -0500
Received: (qmail 2588 invoked by uid 107); 14 Mar 2015 17:34:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Mar 2015 13:34:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Mar 2015 13:34:24 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9toxgdd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265453>

On Fri, Mar 13, 2015 at 11:06:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > From: Dave Olszewski <cxreg@pobox.com>
> >
> > Signed-off-by: Dave Olszewski <cxreg@pobox.com>
> > ---
> > Again, this is just a preview. Dave should send the final when he thinks
> > it is good.
> 
> Dave?
> 
> I do not see anything wrong with this version that builds on top of
> the previous 2 clean-up.  Personally I find that these clean-up
> changes more valuable than I care about this particular feature, and
> it is unfortunate that waiting an Ack or reroll of this one kept
> them stalled.
> 
> I am tempted to throw "Helped-by: Peff" into the log message and
> merge the result to 'next', unless I hear otherwise in a few days.

FWIW, as the author of the leadup patches, that would be fine with me. I
think the end patch is in fine shape.

-Peff
