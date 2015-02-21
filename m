From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] clone: add disassociate alias to dissociate option
Date: Sat, 21 Feb 2015 01:27:55 -0500
Message-ID: <20150221062754.GC29665@peff.net>
References: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
 <1424459423-11727-2-git-send-email-mattwhiteley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matt Whiteley <mattwhiteley@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 07:28:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP3Xn-0000xd-KL
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 07:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbbBUG16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 01:27:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:51911 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750746AbbBUG15 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 01:27:57 -0500
Received: (qmail 6560 invoked by uid 102); 21 Feb 2015 06:27:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Feb 2015 00:27:57 -0600
Received: (qmail 10861 invoked by uid 107); 21 Feb 2015 06:27:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Feb 2015 01:27:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Feb 2015 01:27:55 -0500
Content-Disposition: inline
In-Reply-To: <1424459423-11727-2-git-send-email-mattwhiteley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264211>

On Fri, Feb 20, 2015 at 11:10:22AM -0800, Matt Whiteley wrote:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 316c75d..7e193ae 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -97,6 +97,8 @@ static struct option builtin_clone_options[] = {
>  		    N_("clone only one branch, HEAD or --branch")),
>  	OPT_BOOL(0, "dissociate", &option_dissociate,
>  		 N_("use --reference only while cloning")),
> +	OPT_BOOL(0, "disassociate", &option_dissociate,
> +		 N_("use --reference only while cloning")),

Should this second one be marked as OPT_HIDDEN? I do not think we need
to show both in "git clone --help".

-Peff
