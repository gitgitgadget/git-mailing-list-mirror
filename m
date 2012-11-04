From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb.perl: fix %highlight_ext mappings
Date: Sun, 4 Nov 2012 08:48:41 -0500
Message-ID: <20121104134841.GC31623@sigill.intra.peff.net>
References: <20121102141226.643a96e61b8bf383428c5287@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: rh <richard_hubbe11@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 14:48:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV0ZM-0007rg-Qj
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 14:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149Ab2KDNso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 08:48:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56612 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779Ab2KDNso (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 08:48:44 -0500
Received: (qmail 23861 invoked by uid 107); 4 Nov 2012 13:49:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 04 Nov 2012 08:49:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Nov 2012 08:48:41 -0500
Content-Disposition: inline
In-Reply-To: <20121102141226.643a96e61b8bf383428c5287@lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209029>

On Fri, Nov 02, 2012 at 02:12:26PM -0700, rh wrote:

> The previous change created a dictionary of one-to-one elements when
> the intent was to map mutliple related types to one main type.
> e.g. bash, ksh, zsh, sh all map to sh since they share similar syntax
> This makes the mapping as the original change intended.
> 
> Signed-off-by: rh <richard_hubbe11@lavabit.com>
> 
> diff --git a/gitweb.cgi.orig b/gitweb.cgi
> index 060db27..155b238 100755
> --- a/gitweb.cgi.orig
> +++ b/gitweb.cgi

Close on the format. There should be a "---" after the sign-off but
before the diff. I can fix it up locally (and the patch looks good to
me).

However, one final thing: the point of the sign-off is to indicate that
you are legally OK to release the code under the DCO. For that reason,
we usually require a real name (not rh). I can guess at your real name
from your email, but I'd rather be sure. Can you provide it?

-Peff
