From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 12:43:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 12:42:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhjJP-0003KM-Vs
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 12:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbZCLLlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 07:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZCLLlX
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 07:41:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:60627 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754125AbZCLLlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 07:41:22 -0400
Received: (qmail invoked by alias); 12 Mar 2009 11:41:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 12 Mar 2009 12:41:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ak2wdig2Aq3SHNIPcsrmL+Pvm6z9SEPdYtufhil
	jqofHexBcAUGz9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113047>

Hi,

On Thu, 12 Mar 2009, John Tapsell wrote:

>   One of my collegues did:
> 
> git checkout origin/somebranch
> 
>   git complained that they need to specify the name with -b.  So they did:
> 
> git checkout -b origin/somebranch origin/somebranch

Yeah, a pilot error.  It should have been

	$ git checkout -t origin/somebranch

I have to wonder, though, why "git checkout origin/somebranch" did not 
detach your HEAD.

>   Git accepts this with no problems, but boy - all hell broke loose.
> Doing a push or pull gave errors, because "origin/somebranch" is now
> ambigous (since there is two of them).

I strongly doubt that it gave errors, but rather warnings.  I have a 
repository where I get warnings all the time (it has a cvsimport and an 
origin remote), but it works without problems.

>  They can't even:  "git checkout -b somebranch origin/somebranch"  
> anymore, since "origin/somebranch" is ambigous.  It all got into a mess.

I wonder why you did not just "git branch -m somebranch".

Ciao,
Dscho
