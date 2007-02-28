From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: defaults for where to merge from
Date: Wed, 28 Feb 2007 16:13:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702281611140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es450f$d58$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 16:13:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQUj-0001cV-Hg
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933036AbXB1PN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933040AbXB1PN1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:13:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:46768 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933036AbXB1PN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:13:26 -0500
Received: (qmail invoked by alias); 28 Feb 2007 15:13:25 -0000
X-Provags-ID: V01U2FsdGVkX1873whZuO47Z9hZHG+MW/f5fsH2wLh+4GidZ4h/Cr
	VcTg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <es450f$d58$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40933>

Hi,

On Wed, 28 Feb 2007, Paolo Bonzini wrote:

> As can be seen from my other messages, I'm experimenting a little with 
> git and trying to understand how its workflow compares with arch.  
> Right now, my procedure for branching off a remote archive is:
> 
>   git checkout -b branchname remote/upstreambranch
>   git config --add branch.branchname.remote remote
>   git config --add branch.branchname.merge refs/heads/upstreambranch
> 
> Is there a reason why "git branch" and "git checkout -b" should not 
> automatically do the two "git-config --add"s when the source branch is 
> remote?

I like it.

> In case the source branch is not remote, would "origin" be a good choice 
> for the "branch.branchname.remote" variable?

In case source branch is not a remote, I would not want that DWIMery.

Ciao,
Dscho
