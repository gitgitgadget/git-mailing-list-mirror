From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Documentation/git-am.txt: mention mailinfo.scissor
 config variable
Date: Fri, 20 Feb 2015 05:19:53 -0500
Message-ID: <20150220101952.GB29980@peff.net>
References: <1424426947-26441-1-git-send-email-Matthieu.Moy@imag.fr>
 <1424426947-26441-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:20:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOkgh-0005tK-S7
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbbBTKT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:19:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:51481 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753863AbbBTKTz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:19:55 -0500
Received: (qmail 16341 invoked by uid 102); 20 Feb 2015 10:19:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Feb 2015 04:19:55 -0600
Received: (qmail 8930 invoked by uid 107); 20 Feb 2015 10:19:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Feb 2015 05:19:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2015 05:19:53 -0500
Content-Disposition: inline
In-Reply-To: <1424426947-26441-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264149>

On Fri, Feb 20, 2015 at 11:09:07AM +0100, Matthieu Moy wrote:

> It was already documented, but the user had to follow the link to
> git-mailinfo.txt to find it.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> This one may be more controversial. I think it makes sense to apply
> it, but I won't fight for it if you think it adds too much noise to
> the doc.

I recently looked up the option to reply to your other mail, knowing it
existed but forgetting the exact name. It took me several minutes to
find it. I'm in favor of this.

>  --scissors::
>  	Remove everything in body before a scissors line (see
> -	linkgit:git-mailinfo[1]).
> +	linkgit:git-mailinfo[1]). Can be activated by default using
> +	the `mailinfo.scissor` configuration variable.

As in the other patch, "scissors", with a trailing "s".

-Peff
