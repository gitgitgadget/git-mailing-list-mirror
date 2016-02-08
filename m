From: Jeff King <peff@peff.net>
Subject: Re: man git-config inconsistency (*.fsckObjects)
Date: Mon, 8 Feb 2016 10:08:56 -0500
Message-ID: <20160208150856.GB13664@sigill.intra.peff.net>
References: <56B8A928.4000802@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Markus Kuhn <Markus.Kuhn@cl.cam.ac.uk>
X-From: git-owner@vger.kernel.org Mon Feb 08 16:09:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSnR7-0008H0-48
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 16:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbcBHPI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 10:08:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:39233 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753590AbcBHPI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 10:08:59 -0500
Received: (qmail 679 invoked by uid 102); 8 Feb 2016 15:08:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 10:08:58 -0500
Received: (qmail 5712 invoked by uid 107); 8 Feb 2016 15:09:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 10:09:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 10:08:56 -0500
Content-Disposition: inline
In-Reply-To: <56B8A928.4000802@cl.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285773>

On Mon, Feb 08, 2016 at 02:41:44PM +0000, Markus Kuhn wrote:

> https://www.kernel.org/pub/software/scm/git/docs/git-config.html
> 
> The git-config(1) man page entries for "fetch.fsckObjects" and
> "receive.fsckObjects" both end with the lines
> 
>            Defaults to false. If not set, the value of transfer.fsckObjects is
>            used instead.
> 
> These two sentences contradict each other: if the variable is not set,
> the first sentence says it is interpreted as false, the second sentence
> says the value of transfer.fsckObjects is used instead.
> 
> Both sentences can't be true at the same time when transfer.fsckObjects = true.
> 
> Suggested rephrasing:
> 
>            If not set, the value of transfer.fsckObjects is used
>            instead, which defaults to false.

Yeah, I agree your phrasing is much clearer.

> From f6253cce1a0f9df53b020c5821e9fc9fa27cd23f Mon Sep 17 00:00:00 2001
> From: Markus Kuhn <Markus.Kuhn@cl.cam.ac.uk>
> Date: Mon, 8 Feb 2016 14:36:22 +0000
> Subject: [PATCH] avoid self-contradiction on fsckObjects default
> 
> ---
>  Documentation/config.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

I think the text in your email would make a good commit message. :)

-Peff
