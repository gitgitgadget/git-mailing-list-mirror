From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] check-ignore: correct documentation about output
Date: Fri, 20 Nov 2015 06:31:29 -0500
Message-ID: <20151120113129.GE11198@sigill.intra.peff.net>
References: <20151108201036.GA28434@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 12:31:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzjup-0003l4-JX
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 12:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161969AbbKTLbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 06:31:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:60068 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759290AbbKTLbc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 06:31:32 -0500
Received: (qmail 18965 invoked by uid 102); 20 Nov 2015 11:31:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 05:31:32 -0600
Received: (qmail 26570 invoked by uid 107); 20 Nov 2015 11:32:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 06:32:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2015 06:31:29 -0500
Content-Disposition: inline
In-Reply-To: <20151108201036.GA28434@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281508>

On Sun, Nov 08, 2015 at 09:10:39PM +0100, Dennis Kaarsemaker wrote:

> By default git check-ignore shows only the filenames that will be
> ignored, not the pattern that causes their exclusion.

Yeah, I think the described behavior is really about the "-v" output.

> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -16,10 +16,9 @@ DESCRIPTION
>  -----------
>  
>  For each pathname given via the command-line or from a file via
> -`--stdin`, show the pattern from .gitignore (or other input files to
> -the exclude mechanism) that decides if the pathname is excluded or
> -included.  Later patterns within a file take precedence over earlier
> -ones.
> +`--stdin`, check whether the file is excluded by .gitignore (or other
> +input files to the exclude mechanism) and output the path if it is
> +excluded.

This just drops the mention of patterns entirely. Is the description of
"-v" sufficient to cover this (especially I am thinking of the
last-pattern-wins behavior)?

-Peff
