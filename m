From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Query about documentation of git pull -n
Date: Thu, 24 Jan 2008 11:01:44 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801241058330.5731@racer.site>
References: <72481CA3A5A6474EA49CFD2CF28A5D5D02CA348A@hektor.iplbath.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Anthony Bolton <Anthony.Bolton@ipl.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 12:03:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHzrN-0005g1-Vm
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 12:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbYAXLB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 06:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbYAXLB4
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 06:01:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:46600 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755676AbYAXLBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 06:01:54 -0500
Received: (qmail invoked by alias); 24 Jan 2008 11:01:53 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp036) with SMTP; 24 Jan 2008 12:01:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19A3H4JNKtAePO4ib4naHa8oYvIvMOPhw9yxcyvJV
	bnap/Py0QbPsbN
X-X-Sender: gene099@racer.site
In-Reply-To: <72481CA3A5A6474EA49CFD2CF28A5D5D02CA348A@hektor.iplbath.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71614>

Hi,

On Thu, 24 Jan 2008, Anthony Bolton wrote:

> Comment from a new user:
>  The git-pull man pages imply that "git pull -n" and "git pull 
> --no-tags" are the same, but -n seems to do something different entirely 
> (same with git fetch). I found this in msysgit but the msysgit boys say 
> that it's actually a problem with core git.

FWIW I am that msysgit boy.  And I did not say anything about git-fetch, 
but only about git-pull.  I even said that "-n" means "--no-summary" to 
git-pull.

> If -n is intended to be different from --no-tags than can you update the 
> documentation please?

That is such a low-hanging fruit.  Since you apparently use git yourself, 
there is not much left to learn in order to fix this bug.  IOW this is a 
perfect occasion to get just a little involved in the git development.

Just look at Documentation/diff-options.txt for an example how to use the 
"ifdef::" construct, and then use that construct in 
Documentation/fetch-options.txt.

Hth,
Dscho
