From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] describe: Add documentation for "--abbrev=+"
Date: Sun, 14 Sep 2014 04:23:02 -0400
Message-ID: <20140914082302.GB20526@peff.net>
References: <1410532004-22769-1-git-send-email-jonh.wendell@gmail.com>
 <1410532004-22769-3-git-send-email-jonh.wendell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonh Wendell <jonh.wendell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 10:23:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT55V-0001ZW-4I
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 10:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbaINIXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 04:23:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:47974 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752443AbaINIXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 04:23:05 -0400
Received: (qmail 6998 invoked by uid 102); 14 Sep 2014 08:23:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Sep 2014 03:23:04 -0500
Received: (qmail 13901 invoked by uid 107); 14 Sep 2014 08:23:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Sep 2014 04:23:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Sep 2014 04:23:02 -0400
Content-Disposition: inline
In-Reply-To: <1410532004-22769-3-git-send-email-jonh.wendell@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257006>

On Fri, Sep 12, 2014 at 11:26:44AM -0300, Jonh Wendell wrote:

> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -54,6 +54,12 @@ OPTIONS
>  	abbreviated object name, use <n> digits, or as many digits
>  	as needed to form a unique object name.  An <n> of 0
>  	will suppress long format, only showing the closest tag.
> +	+
> +	+

Why two continuation lines here? One seems to be enough on my version of
asciidoc (though it would not be the first time we have encountered
weird behaviors in our documentation toolchain).

> +	A special case of <n> equals to "\+" (without quotes) will print
> +	just a "+" sign instead of the whole suffix. This is useful if you
> +	only need to know if the supplied <commit-ish> points to an exact
> +	match or if there are commits between the tag found and the <commit-ish>.

I found this first phrase a little hard to parse. What about just:

  An <n> of `+` will print...

That uses the same wording as above, and I think using backticks is
probably the right thing. It will appear in a monospaced font, which
avoids the need to explain the quotes (and you also do not need to
backslash-escape inside it).

-Peff
