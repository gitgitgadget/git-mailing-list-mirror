From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Documentation: replace sha1 by SHA-1
Date: Fri, 24 Apr 2009 17:28:56 -0400
Message-ID: <20090424212856.GB14435@coredump.intra.peff.net>
References: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net> <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 23:30:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxSyo-0005LU-C9
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 23:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917AbZDXV3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 17:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756153AbZDXV3I
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 17:29:08 -0400
Received: from peff.net ([208.65.91.99]:59695 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755517AbZDXV3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 17:29:07 -0400
Received: (qmail 31595 invoked by uid 107); 24 Apr 2009 21:29:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 17:29:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 17:28:56 -0400
Content-Disposition: inline
In-Reply-To: <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117491>

On Fri, Apr 24, 2009 at 04:49:34PM +0200, Michael J Gruber wrote:

> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -76,7 +76,7 @@ If '--batch' is specified, output of the following form is printed for each
>  object specified on stdin:
>  
>  ------------
> -<sha1> SP <type> SP <size> LF
> +<SHA-1> SP <type> SP <size> LF
>  <contents> LF
>  ------------

Maybe it is just me, but I find the original for this one easier to
read. Perhaps because <sha1> is really a variable name here (but for a
human reader to interpret instead of a compiler), so I find the
punctuation and capitalization distracting.

I wonder if all <sha1> should simply be left as-is.

-Peff
