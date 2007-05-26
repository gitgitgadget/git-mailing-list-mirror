From: Jeff King <peff@peff.net>
Subject: Re: Bug: git-rebase goofs up \n in commit messages
Date: Sat, 26 May 2007 03:47:04 -0400
Message-ID: <20070526074703.GA2563@coredump.intra.peff.net>
References: <465750FE.9000406@iii.hu> <20070526004028.GA8940@sigill.intra.peff.net> <20070526011036.GA4169@gondor.apana.org.au> <20070526034236.GA18169@coredump.intra.peff.net> <7vps4onps0.fsf@assigned-by-dhcp.cox.net> <20070526060748.GA20715@coredump.intra.peff.net> <20070526061942.GA5986@gondor.apana.org.au> <20070526062748.GA21229@coredump.intra.peff.net> <20070526073855.GA6395@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Szekeres Istvan <szekeres@iii.hu>,
	git@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
X-From: git-owner@vger.kernel.org Sat May 26 09:47:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrqzZ-0000bN-Mv
	for gcvg-git@gmane.org; Sat, 26 May 2007 09:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbXEZHrH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 03:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbXEZHrH
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 03:47:07 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4758 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458AbXEZHrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 03:47:06 -0400
Received: (qmail 31077 invoked from network); 26 May 2007 07:47:11 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 26 May 2007 07:47:11 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 26 May 2007 03:47:04 -0400
Content-Disposition: inline
In-Reply-To: <20070526073855.GA6395@gondor.apana.org.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48457>

On Sat, May 26, 2007 at 05:38:55PM +1000, Herbert Xu wrote:

> Yep.  Section 2.2.3 says that the backslash within double quotes will
> only serve as an escape character for $, `, ", \ and <newline>.  Of
> course, you can always use a single quote instead, i.e.,
> 
> printf '%s\n' "$VAR"
> 
> Then there can be no doubt :)

Right, I wasn't sure if the single quotes were necessary, but it looks
like Junio's version (with doublequotes) is also fine according to
POSIX. Thanks again.

-Peff
