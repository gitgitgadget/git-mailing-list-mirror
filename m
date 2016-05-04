From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] http: expand http.cookieFile as a path
Date: Wed, 4 May 2016 15:30:51 -0400
Message-ID: <20160504193051.GF21259@sigill.intra.peff.net>
References: <1462387335-57937-1-git-send-email-computersforpeace@gmail.com>
 <1462387335-57937-3-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 21:31:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay2Vf-0003Jh-Bp
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbcEDTaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:30:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:34143 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752610AbcEDTay (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:30:54 -0400
Received: (qmail 31052 invoked by uid 102); 4 May 2016 19:30:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 15:30:54 -0400
Received: (qmail 13180 invoked by uid 107); 4 May 2016 19:31:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 15:31:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 15:30:51 -0400
Content-Disposition: inline
In-Reply-To: <1462387335-57937-3-git-send-email-computersforpeace@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293575>

On Wed, May 04, 2016 at 11:42:15AM -0700, Brian Norris wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e655b9729a7d..4c3cd7621ad0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1664,7 +1664,8 @@ http.emptyAuth::
>  	authentication.
>  
>  http.cookieFile::
> -	File containing previously stored cookie lines which should be used
> +	The pathname of a file containing previously stored cookie lines,
> +	which should be used
>  	in the Git http session, if they match the server. The file format
>  	of the file to read cookies from should be plain HTTP headers or
>  	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).

I think we usually re-wrap paragraphs when adding to the documentation,
but I do not have a strong opinion (and certainly understand the reasons
for not doing so).

The whole series looks fine to me. Thanks.

-Peff
