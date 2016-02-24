From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] diff: activate diff.renames by default
Date: Wed, 24 Feb 2016 05:42:04 -0500
Message-ID: <20160224104203.GD21152@sigill.intra.peff.net>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
 <1456249498-3232-6-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:42:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYWtc-0003AN-W1
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 11:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbcBXKmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 05:42:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:48212 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755367AbcBXKmG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 05:42:06 -0500
Received: (qmail 28831 invoked by uid 102); 24 Feb 2016 10:42:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:42:06 -0500
Received: (qmail 7123 invoked by uid 107); 24 Feb 2016 10:42:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:42:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 05:42:04 -0500
Content-Disposition: inline
In-Reply-To: <1456249498-3232-6-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287195>

On Tue, Feb 23, 2016 at 06:44:58PM +0100, Matthieu Moy wrote:

> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 1acd203..fdf5a79 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -111,7 +111,7 @@ diff.renames::
>  	Whether and how Git detects renames.  If set to "false",
>  	rename detection is disabled. If set to "true", basic rename
>  	detection is enable.  If set to "copies" or "copy", Git will
> -	detect copies, as well.  Defaults to false.
> +	detect copies, as well.  Defaults to true.

I wonder if we need to talk about plumbing versus porcelain here, as it
does not default to true for diff-tree, for example. But I guess that is
already the case (even setting it to true yourself does not affect
diff-tree).

-Peff
