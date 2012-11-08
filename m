From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb.perl: fix %highlight_ext mappings
Date: Thu, 8 Nov 2012 13:01:57 -0500
Message-ID: <20121108180157.GK15560@sigill.intra.peff.net>
References: <20121104094555.a46992b6d836c1e09524d2cc@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: rh <richard_hubbe11@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 19:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWWQj-0007Io-HI
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 19:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544Ab2KHSCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 13:02:03 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36527 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500Ab2KHSCB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 13:02:01 -0500
Received: (qmail 31381 invoked by uid 107); 8 Nov 2012 18:02:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 13:02:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 13:01:57 -0500
Content-Disposition: inline
In-Reply-To: <20121104094555.a46992b6d836c1e09524d2cc@lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209179>

On Sun, Nov 04, 2012 at 09:45:55AM -0800, rh wrote:

> The previous change created a dictionary of one-to-one elements when
> the intent was to map mutliple related types to one main type.
> e.g. bash, ksh, zsh, sh all map to sh since they share similar syntax
> This makes the mapping as the original change intended.
> 
> Signed-off-by: Richard Hubbell <richard_hubbe11@lavabit.com>

Thanks.

> diff --git a/gitweb.cgi.orig b/gitweb.cgi
> index 060db27..155b238 100755
> --- a/gitweb.cgi.orig
> +++ b/gitweb.cgi

This is not the name of the source file in git.git, so "git am" choked.
I was able to fix it up locally, though. No need to resend.

-Peff
