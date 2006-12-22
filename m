From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t5000-tar-tree.sh failing
Date: Fri, 22 Dec 2006 03:48:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612220345530.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061221133746.GA13751@cepheus>
 <Pine.LNX.4.63.0612211458360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <9A725DAA-FAA8-4779-A73D-ED117CC068C1@silverinsanity.com>
 <20061221185948.GA27072@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 03:48:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxaSu-0007t7-Im
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 03:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945918AbWLVCsn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 21:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945919AbWLVCsm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 21:48:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:55722 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945918AbWLVCsm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 21:48:42 -0500
Received: (qmail invoked by alias); 22 Dec 2006 02:48:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 22 Dec 2006 03:48:40 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20061221185948.GA27072@informatik.uni-freiburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35123>

Hi,

On Thu, 21 Dec 2006, Uwe Kleine-Koenig wrote:

> I'm not sure if (in this case) a missing unzip should be as silent as
> you suggest.  The danger is, that s.o. makes a change, runs `make test`
> and is then conviced that nothing broke.

Well, the tests are not distributed with the binary packages. For a 
reason. The maintainer of the binary packages has to check if the tests 
succeed. An she better know what she's doing!

So, if Joe Average compiles git, does not have unzip installed, and runs 
the tests, chances are that he does not want to be bothered about the zip 
tests failing because of the absence of unzip.

>  So I think that the test should fail, but with a more descriptive error 
> than it is now.

Sorry. Does not work here. I _only_ look at the messages if the test suite 
fails somewhere, with a loud error message at the end.

Ciao,
Dscho
