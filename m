From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] git-config.txt: describe '--includes' default
 behavior
Date: Sat, 13 Feb 2016 12:17:04 -0500
Message-ID: <20160213171704.GF30144@sigill.intra.peff.net>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
 <1455373456-64691-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 13 18:17:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUdom-0002sq-97
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 18:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbcBMRRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 12:17:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:41545 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750932AbcBMRRH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 12:17:07 -0500
Received: (qmail 8941 invoked by uid 102); 13 Feb 2016 17:17:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 12:17:06 -0500
Received: (qmail 26925 invoked by uid 107); 13 Feb 2016 17:17:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 12:17:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2016 12:17:04 -0500
Content-Disposition: inline
In-Reply-To: <1455373456-64691-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286118>

On Sat, Feb 13, 2016 at 03:24:14PM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/git-config.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 2608ca7..59b1c95 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -219,7 +219,9 @@ See also <<FILES>>.
>  
>  --[no-]includes::
>  	Respect `include.*` directives in config files when looking up
> -	values. Defaults to on.
> +	values. Defaults to off when reading a specific config file
> +	(e.g. via `--file` or via `--local` etc.), and to on when
> +	generically reading all config.

Hmph. I wondered why you were confused about this the other day, when I
checked my Documentation/git-config.txt and found that yes, we do indeed
document this behavior. I did not realize then that my patch from:

  http://article.gmane.org/gmane.comp.version-control.git/262641

was never picked up (but of course I've been carrying it in my tree for
a year). I guess maybe you found it, given the similarity of the
wording. I mildly prefer the wording and formatting of my original, but
I am OK either way. :)

-Peff
