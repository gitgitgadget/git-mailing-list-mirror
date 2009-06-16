From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-branch: Actually using the current branch as default
 start-point
Date: Tue, 16 Jun 2009 23:28:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906162326210.26154@pacific.mpi-cbg.de>
References: <4A37EEC5.4020007@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Martin Nordholts <enselic@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 23:27:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGgCB-0004G8-Bz
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 23:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757846AbZFPV1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 17:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756528AbZFPV1o
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 17:27:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:41316 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755481AbZFPV1o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 17:27:44 -0400
Received: (qmail invoked by alias); 16 Jun 2009 21:27:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp022) with SMTP; 16 Jun 2009 23:27:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+24AoeJMO2yJSF8/0xHJe/lu0JMvY1ezmO6DQMZJ
	ekmmD4W8MfgmWa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A37EEC5.4020007@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121714>

Hi,

On Tue, 16 Jun 2009, Martin Nordholts wrote:

> The git-branch documentation states that the start-point defaults to the 
> current branch if omitted. I interpret that to mean that
> 
>  git checkout origin/somebranch

This detaches the HEAD.

>  git branch newbranch

This gives the detached HEAD a name.

> is equivalent to
> 
>  git branch newbranch origin/somebranch

In this case, we know exactly from which remote branch the new branch was 
created.

The difference?

In the former case, origin can be long gone by the time the new branch is 
created.  And you have to make sure that once we switch away (by whatever 
means) from the detached HEAD, the tracking information is deleted.

All in all, your wish sounds rather fragile and thus not desirable to me.

Ciao,
Dscho

P.S.: Disclaimer skipped as we talked on IRC about it, and I am actually 
surprised you still think it would be a sensible idea.
