From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] diff-highlight: add `less -r` to cmd in README
Date: Tue, 3 Nov 2015 16:55:35 -0500
Message-ID: <20151103215535.GA24971@sigill.intra.peff.net>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
 <1446516334-27652-2-git-send-email-jonathan.lebon@gmail.com>
 <20151103211435.GA22484@sigill.intra.peff.net>
 <xmqqwptybvk5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Lebon <jonathan.lebon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:55:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtjYN-0000MV-J8
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 22:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbbKCVzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 16:55:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:52330 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755390AbbKCVzi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 16:55:38 -0500
Received: (qmail 3094 invoked by uid 102); 3 Nov 2015 21:55:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 15:55:38 -0600
Received: (qmail 29121 invoked by uid 107); 3 Nov 2015 21:56:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 16:56:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Nov 2015 16:55:35 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwptybvk5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280825>

On Tue, Nov 03, 2015 at 01:51:54PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I agree with Junio that "-R" is a more sensible default, but I don't
> > think that should be necessary. We already set LESS when running the
> > pager (and if you are overriding it, you are already in trouble, because
> > git itself will generate ANSI codes by default).
> 
> I do not quite understand this part.  Inside git itself when we
> spawn the pager we export LESS with a sensible default, exactly to
> help users who do not have LESS set and exported.  This one however
> is not spawned by git but the end-user piping output of diff-hilite.

Oh, you're right. I mistook it as instructions for what to put in
pager.log, but that is clearly not what this is. I agree that telling
the user to use "-R" here is a good idea.

And indeed, the instructions just below the hunk in question describe
setting it properly in your config (with less, and no "-R"). So I was
simply confused and not reading carefully enough.

-Peff
