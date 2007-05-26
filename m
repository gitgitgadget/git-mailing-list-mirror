From: Jeff King <peff@peff.net>
Subject: Re: Bug: git-rebase goofs up \n in commit messages
Date: Sat, 26 May 2007 02:27:48 -0400
Message-ID: <20070526062748.GA21229@coredump.intra.peff.net>
References: <465750FE.9000406@iii.hu> <20070526004028.GA8940@sigill.intra.peff.net> <20070526011036.GA4169@gondor.apana.org.au> <20070526034236.GA18169@coredump.intra.peff.net> <7vps4onps0.fsf@assigned-by-dhcp.cox.net> <20070526060748.GA20715@coredump.intra.peff.net> <20070526061942.GA5986@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Szekeres Istvan <szekeres@iii.hu>,
	git@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
X-From: git-owner@vger.kernel.org Sat May 26 08:28:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrpku-0007tu-2W
	for gcvg-git@gmane.org; Sat, 26 May 2007 08:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbXEZG1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 02:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbXEZG1v
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 02:27:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2673 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbXEZG1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 02:27:50 -0400
Received: (qmail 26749 invoked from network); 26 May 2007 06:27:55 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 26 May 2007 06:27:55 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 26 May 2007 02:27:48 -0400
Content-Disposition: inline
In-Reply-To: <20070526061942.GA5986@gondor.apana.org.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48455>

On Sat, May 26, 2007 at 04:19:42PM +1000, Herbert Xu wrote:

> > Is "\n" portable to all shells (i.e., do you need '\n')? It works with
> > bash and dash, which are by far the most common, but who knows what evil
> > lurks in the heart of Sun?
> 
> You mean the "\n" in printf? Yes that is specified in POSIX.
> Without the "\n" printf will act like echo -n (which incidentally
> is forbidden by POSIX).

No, I meant would the shell, while interpolating a double-quoted string
"\n", always preserve the string and pass the backslash and 'n' to
printf?  Clearly \\ and \" get interpolated, but I don't know the rules
for "unrecognized" backslash sequences.

-Peff
