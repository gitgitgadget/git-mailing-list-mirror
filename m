From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] git-am.txt: Use date instead of time or timestamp
Date: Mon, 4 May 2009 03:15:34 -0400
Message-ID: <20090504071534.GB12654@coredump.intra.peff.net>
References: <1241419618-20304-1-git-send-email-bebarino@gmail.com> <1241419618-20304-2-git-send-email-bebarino@gmail.com> <1241419618-20304-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 09:15:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0sOu-0004X6-7F
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 09:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbZEDHPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 03:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbZEDHPh
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 03:15:37 -0400
Received: from peff.net ([208.65.91.99]:33123 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbZEDHPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 03:15:36 -0400
Received: (qmail 16601 invoked by uid 107); 4 May 2009 07:15:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 04 May 2009 03:15:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 May 2009 03:15:34 -0400
Content-Disposition: inline
In-Reply-To: <1241419618-20304-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118215>

On Sun, May 03, 2009 at 11:46:57PM -0700, Stephen Boyd wrote:

> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 715531b..c141261 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -85,7 +85,7 @@ default.   You can use `--no-utf8` to override this.
>  	By default the command records the date from the e-mail
>  	message as the commit author date, and uses the time of
>  	commit creation as the committer date. This allows the
> -	user to lie about author timestamp by using the same
> +	user to lie about the author date by using the same
>  	timestamp as the committer date.

But you leave the "timestamp" in the next context line?

The other two patches in the series look fine to me, though.

-Peff
