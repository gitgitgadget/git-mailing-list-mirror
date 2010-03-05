From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] stash: suggest the correct command line for unknown
 options.
Date: Fri, 5 Mar 2010 12:08:42 -0500
Message-ID: <20100305170841.GA9325@coredump.intra.peff.net>
References: <4B910736.7060604@syntevo.com>
 <1267805693-25206-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thomas Singer <thomas.singer@syntevo.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Mar 05 18:08:58 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nnb1F-0002Q8-MJ
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 18:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab0CERIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 12:08:47 -0500
Received: from peff.net ([208.65.91.99]:38024 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943Ab0CERIq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 12:08:46 -0500
Received: (qmail 8034 invoked by uid 107); 5 Mar 2010 17:09:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 05 Mar 2010 12:09:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Mar 2010 12:08:42 -0500
Content-Disposition: inline
In-Reply-To: <1267805693-25206-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141589>

On Fri, Mar 05, 2010 at 05:14:53PM +0100, Matthieu Moy wrote:

> diff --git a/git-stash.sh b/git-stash.sh
> index 2d69196..cf4e673 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -151,6 +151,7 @@ save_stash () {
>  			;;
>  		-*)
>  			echo "error: unknown option for 'stash save': $1"
> +			echo "       To provide a message, use 'git stash -- $1'."

Don't you mean "git stash save -- $1"?

-Peff
