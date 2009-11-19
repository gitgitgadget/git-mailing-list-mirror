From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] expand_user_path: expand ~ to $HOME, not to the actual
 homedir.
Date: Thu, 19 Nov 2009 10:23:59 -0500
Message-ID: <20091119152359.GB6877@coredump.intra.peff.net>
References: <1258534693-7220-1-git-send-email-Matthieu.Moy@imag.fr>
 <1258644075-16191-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 19 16:24:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB8rh-0007L6-GC
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 16:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbZKSPX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 10:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbZKSPX5
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 10:23:57 -0500
Received: from peff.net ([208.65.91.99]:35078 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026AbZKSPX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 10:23:56 -0500
Received: (qmail 19271 invoked by uid 107); 19 Nov 2009 15:27:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Nov 2009 10:27:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Nov 2009 10:23:59 -0500
Content-Disposition: inline
In-Reply-To: <1258644075-16191-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133234>

On Thu, Nov 19, 2009 at 04:21:15PM +0100, Matthieu Moy wrote:

> -	of files which are not meant to be tracked.  "~/" and "~user/"
> -	are expanded to the specified user's home directory.  See
> -	linkgit:gitignore[5].
> +	of files which are not meant to be tracked.  "~/" is expanded
> +	to the value of `$HOME` and "~user/" to the specified user's
> +	home directory.  See linkgit:gitignore[5].

Thanks. As a side effect, this wording change addresses my original
ambiguity concern (and I also think using $HOME is the right thing to
do).

-Peff
