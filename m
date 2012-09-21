From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/6] Color skipped tests blue
Date: Fri, 21 Sep 2012 02:13:25 -0400
Message-ID: <20120921061325.GA15867@sigill.intra.peff.net>
References: <20120919201326.GA23016@sigill.intra.peff.net>
 <1348086263-27555-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 08:13:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEwUb-0001W9-3J
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 08:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab2IUGN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 02:13:28 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52342 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab2IUGN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 02:13:28 -0400
Received: (qmail 29974 invoked by uid 107); 21 Sep 2012 06:13:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 02:13:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 02:13:25 -0400
Content-Disposition: inline
In-Reply-To: <1348086263-27555-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206111>

On Wed, Sep 19, 2012 at 09:24:23PM +0100, Adam Spiers wrote:

>  t/test-lib.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 5293830..78c88c2 100755
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -182,13 +182,13 @@ then
>  		error)
>  			tput bold; tput setaf 1;; # bold red
>  		skip)
> -			tput bold; tput setaf 2;; # bold green
> +			tput setaf 4;;            # blue
>  		warn)
>  			tput bold; tput setaf 3;; # bold yellow
>  		pass)
>  			tput setaf 2;;            # green
>  		info)
> -			tput setaf 3;;            # brown
> +			tput setaf 3;;            # yellow/brown

I happened to be running a test script with "-v" earlier today, and I
noticed that the "expecting success..." dump of the test contents is
also yellow. By your new rules, shouldn't it be blue?

I think it is matching the "info" type, which from the discussion should
be blue, no?

Maybe it is just my terminal. I see it is labeled as "brown" here, but
it looks very yellow (and I am using the stock xterm colors. According
to:

  https://en.wikipedia.org/wiki/ANSI_colors

It looks it really is brown on some platforms. I'm not sure if it is
worth worrying about.  I don't really want to get into configurable
colors just for the test-suite output.

-Peff
