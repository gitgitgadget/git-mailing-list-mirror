From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 22:41:39 +0100
Message-ID: <20121125214139.GA29465@shrek.podlesie.net>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 22:42:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcjxe-0006MH-8Z
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 22:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab2KYVln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 16:41:43 -0500
Received: from [93.179.225.50] ([93.179.225.50]:43953 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753474Ab2KYVln (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 16:41:43 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 47F133B6; Sun, 25 Nov 2012 22:41:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121125024451.1ADD14065F@snark.thyrsus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210384>

On Sat, Nov 24, 2012 at 09:44:51PM -0500, Eric S. Raymond wrote:
> 
> We're behind the best-practices curve here.  The major Linux
> distributions, which have to deal with almost the same set of
> tradeoffs we do, went to Python for pretty much all glue and
> administration scripts outside /etc a decade ago, and the decision has
> served them well.
> 
> That, among other things, means up-to-date versions of Python are
> ubiquitous unless we're looking at Windows - in which case Perl and
> shell actually become much bigger portability problems.  Mac OS X 
> has kept up to date, too; Lion shipped 2.7.1 and that was a major
> release back at this point.
> 

What about embedded systems? git is also useful there. C and shell is
everywhere, python is not. Adding additional dependency if it's not
really needed it's not a good idea.

Also not everyone uses up-to-date systems and sometimes you just
care about some critical parts and do not touch everything else and
there is probably quote large number of systems with python < 2.6.
And even when you keep your system up-to-date, there are some GNU/Linux
distros that are still supported, but does not provide recent python - for
instance PLD Ac, which I still use on some systems and will use
until the hardware dies, provides only python 2.4.6 (by the way,
important packages like git are of course quite recent there - 1.7.11.1).

Krzysiek
