From: Jeff King <peff@peff.net>
Subject: Re: t9902-completion.sh failed
Date: Thu, 13 Nov 2014 06:24:47 -0500
Message-ID: <20141113112447.GA4437@peff.net>
References: <87mw7v9xhl.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:24:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XosWD-0001QA-Vj
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 12:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbaKMLYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 06:24:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:39840 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932328AbaKMLYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 06:24:49 -0500
Received: (qmail 23569 invoked by uid 102); 13 Nov 2014 11:24:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 05:24:49 -0600
Received: (qmail 23497 invoked by uid 107); 13 Nov 2014 11:24:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 06:24:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 06:24:47 -0500
Content-Disposition: inline
In-Reply-To: <87mw7v9xhl.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 04:59:12PM +0600, Alex Kuleshov wrote:

> i just got git from master (f6f61cbbad0611e03b712cc354f1665b5d7b087e),
> built and installed it successfully, now i'm running make test and got
> following error:
> 
> *** t9902-completion.sh ***
> t9902-completion.sh: 118:
> /home/shk/dev/git/t/../contrib/completion/git-completion.bash: Syntax
> error: "(" unexpected (expecting "fi")
> FATAL: Unexpected exit with code 2
> make[2]: *** [t9902-completion.sh] Error 1
> make[2]: Leaving directory `/home/shk/dev/git/t'
> make[1]: *** [test] Error 2
> make[1]: Leaving directory `/home/shk/dev/git/t'
> make: *** [test] Error 2
> 
> $ bash --version
> 4.3.11(1)-release (x86_64-pc-linux-gnu)

Weird. I can't reproduce here, using the version of bash from Debian
unstable (4.3.30(1)), nor compiling 4.3.11 from sources. What platform
are you on (i.e., might it be bash + some other patches installed by the
distro)?

-Peff
