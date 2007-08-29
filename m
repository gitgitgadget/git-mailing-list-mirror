From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 14:21:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708291421060.28586@racer.site>
References: <1188319608.6106.63.camel@beauty> <200708291005.08795.andyparkins@gmail.com>
 <20070829095202.GE1219@pasky.or.cz> <200708291356.33126.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Josh England <jjengla@sandia.gov>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 15:21:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQNUS-0005X1-HF
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 15:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbXH2NVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 09:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756377AbXH2NVp
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 09:21:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:44474 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753990AbXH2NVp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 09:21:45 -0400
Received: (qmail invoked by alias); 29 Aug 2007 13:21:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 29 Aug 2007 15:21:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18b1+J4MgkbF/I4JCMzCha95WjmtwgvodNY6r0oMZ
	KprYLOLWD4Fmog
X-X-Sender: gene099@racer.site
In-Reply-To: <200708291356.33126.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56945>

Hi,

On Wed, 29 Aug 2007, Andy Parkins wrote:

> On Wednesday 2007 August 29, Petr Baudis wrote:
> 
> > But overally, I'm still not convinced that there is a feasible use-case
> > for the cloned hooks at all. Someone has a particular example?
> 
> Hits me all the time.
> 
> 1) Start a new project
> 2) Install a pre-commit hook that checks that every patch meets some
>    arbitrary coding standard
> 3) Clone to laptop
> 4) Kick self the first time you make a commit that doesn't adhere to coding
>    standards that would have been enforced by the hook script.

For me it is

4) put the check into the Makefile where it belongs.

Ciao,
Dscho
