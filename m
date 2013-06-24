From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] documentation: fix asterisks in fetch-options
Date: Mon, 24 Jun 2013 13:35:13 +0200
Message-ID: <8761x33fny.fsf@linux-k42r.v.cablecom.net>
References: <1372073467-29112-1-git-send-email-frase@frase.id.au>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Fraser Tweedale <frase@frase.id.au>
X-From: git-owner@vger.kernel.org Mon Jun 24 13:35:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur53N-0007aU-TJ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 13:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552Ab3FXLfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 07:35:17 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:20370 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697Ab3FXLfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 07:35:16 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 24 Jun
 2013 13:35:13 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 24 Jun 2013 13:35:13 +0200
In-Reply-To: <1372073467-29112-1-git-send-email-frase@frase.id.au> (Fraser
	Tweedale's message of "Mon, 24 Jun 2013 21:31:07 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228805>

Fraser Tweedale <frase@frase.id.au> writes:

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 9cb6496..f2ac3bc 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -61,11 +61,12 @@ endif::git-pull[]
>  ifndef::git-pull[]
>  -t::
>  --tags::
> -	This is a short-hand for giving "refs/tags/*:refs/tags/*"
> -	refspec from the command line, to ask all tags to be fetched
> -	and stored locally.  Because this acts as an explicit
> -	refspec, the default refspecs (configured with the
> -	remote.$name.fetch variable) are overridden and not used.
> +	This is a short-hand for giving
> +	"refs/tags/{asterisk}:refs/tags/{asterisk}" refspec from the
> +	command line, to ask all tags to be fetched and stored
> +	locally.  Because this acts as an explicit refspec, the
> +	default refspecs (configured with the remote.$name.fetch
> +	variable) are overridden and not used.

Wasn't this already fixed by 9eb4754 (fetch-options.txt: prevent a
wildcard refspec from getting misformatted, 2013-06-07), currently in
master?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
