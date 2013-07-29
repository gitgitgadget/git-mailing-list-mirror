From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: fix typo in advice message
Date: Sun, 28 Jul 2013 21:55:16 -0700
Message-ID: <20130729045516.GC4766@sigill.intra.peff.net>
References: <1375071832-2959-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 06:55:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3fUa-0000pV-Rp
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 06:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab3G2EzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 00:55:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:53856 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778Ab3G2EzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 00:55:19 -0400
Received: (qmail 8298 invoked by uid 102); 29 Jul 2013 04:55:19 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 28 Jul 2013 23:55:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Jul 2013 21:55:16 -0700
Content-Disposition: inline
In-Reply-To: <1375071832-2959-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231275>

On Mon, Jul 29, 2013 at 06:23:52AM +0200, Ralf Thielow wrote:

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  builtin/push.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/push.c b/builtin/push.c
> index 6d36c24..04abd2d 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -250,7 +250,7 @@ static const char message_advice_ref_fetch_first[] =
>  	N_("Updates were rejected because the remote contains work that you do\n"
>  	   "not have locally. This is usually caused by another repository pushing\n"
>  	   "to the same ref. You may want to first integrate the remote changes\n"
> -	   "(e.g., 'git pull ...') before pushing again.\n"
> +	   "(e.g. 'git pull ...') before pushing again.\n"

I do not think the comma is a typo. In American English it is usually
preferred, but googling "comma after e.g." seems to indicate that it is
not in British English.

Grep shows that we use both styles in quite a few places.

-Peff
