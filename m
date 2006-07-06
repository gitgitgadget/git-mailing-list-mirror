From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Does Git run on Windows ?
Date: Thu, 6 Jul 2006 08:34:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607060830060.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <01c001c6a0a7$a2783f90$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 06 08:35:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyNSW-0000hW-No
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 08:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWGFGee (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 02:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWGFGee
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 02:34:34 -0400
Received: from mail.gmx.net ([213.165.64.21]:26248 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030210AbWGFGee (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 02:34:34 -0400
Received: (qmail invoked by alias); 06 Jul 2006 06:34:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 06 Jul 2006 08:34:32 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Aaron Gray <angray@beeb.net>
In-Reply-To: <01c001c6a0a7$a2783f90$0200a8c0@AMD2500>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23375>



On Thu, 6 Jul 2006, Aaron Gray wrote:

> This maybe a stupid question but does Git run on Windows ?

You do know that there are several list archives?

> Are there better options ?

Than Windows? Yes.

> Its got lots of C code, and Bash scripts, with a couple of Perl scripts.

And you completely forgot Python.

> So should run on Cygwin okay, maybe even MinGW. Anyone tried either ?

Yes, I have tried.

You might be surprised that Cygwin is supported. But then, you could have 
seen it in the Makefile.

I also tried to port git to MinGW. This project is stalled a little, 
because there is really, really, _really_ much to adapt.

MinGW inherits the problem of Windows being utterly non-POSIX, and that 
has to be worked around.

HOWEVER, if you would like to continue where I left off, I'll send you a 
repo URL where you can download it.

Ciao,
Dscho
