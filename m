From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Sat, 9 Feb 2008 13:10:21 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802091307160.11591@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:11:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNpTo-0001s3-LP
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbYBINKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbYBINKS
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:10:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:58225 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754533AbYBINKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:10:17 -0500
Received: (qmail invoked by alias); 09 Feb 2008 13:10:15 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp010) with SMTP; 09 Feb 2008 14:10:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2g+MxwhC2g160Pl8YiBBXOjrhwMkZHiyFKGS6Sx
	1CcKJfw3vK2c+a
X-X-Sender: gene099@racer.site
In-Reply-To: <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73219>

Hi,

On Sat, 9 Feb 2008, Steffen Prohaska wrote:

> Personally, I decided it is safer to teach users to explicitly type what 
> they mean.  I'd probably not use the push.onlyHEAD config option.
> 
> I also proposed that the default could do nothing if no explicit push 
> lines are in the configuration file.  Users would be forced to 
> explicitly type what the want: Either they can say "--matching" or they 
> can say "--current".  This is similar to the new "git clean" default.  
> But I remember there *was* objection against this because everyone would 
> be forced to type more and different than "git clean" the default of 
> "git push" is considered "safe", so there's no need to protect the user 
> from "git push".
> 
> Junio proposed various possible changes to the configuration variables 
> that could resolve the issues.  I do not remember the details.

The way would be like this, I think:

- introduce a command line option for push, like "--push-common-refs", and 
issue a warning whenever "git push" is called without command line 
options (along the lines "This default behaviour is deprecated; please use 
--push-common-refs").

- in a waaaay later version, just take away the default action of "git 
push", instead showing the usage.

We had something similar wit the -i and -o options to "git commit".

Ciao,
Dscho
