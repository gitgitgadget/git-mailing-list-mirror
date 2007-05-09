From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: quick bare clones taking longer?
Date: Wed, 9 May 2007 13:09:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091309010.4167@racer.site>
References: <20070509.020916.80034730.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Wed May 09 13:10:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlk3i-0006qI-10
	for gcvg-git@gmane.org; Wed, 09 May 2007 13:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362AbXEILJg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 07:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756676AbXEILJg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 07:09:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:44556 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751580AbXEILJf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 07:09:35 -0400
Received: (qmail invoked by alias); 09 May 2007 11:09:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 09 May 2007 13:09:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tyGAqcMJtAKqOknOUqihil36aGPQCEm1GkxnI4U
	lhtBJCeWVrgufY
X-X-Sender: gene099@racer.site
In-Reply-To: <20070509.020916.80034730.davem@davemloft.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46697>

Hi,

On Wed, 9 May 2007, David Miller wrote:

> master.kernel.org just upgraded to git-1.5.1.4 and I notice
> that doing something like this:
> 
> 	git clone --bare -n -l -s ../torvalds/linux-2.6.git test-2.6.git
> 
> is no longer an instantaneous operation, it seems to be doing a lot
> of stuff now:
> 
> Initialized empty Git repository in /home/davem/git/test-2.6.git/
> remote: Generating pack...
> remote: Done counting 480025 objects.
> remote: Deltifying 480025 objects.
> remote:  100% (480025/480025) done
> Indexing 480025 objects.
> remote: Total 480025 (delta 385878), reused 473265 (delta 379369)
>  100% (480025/480025) done
> Resolving 385878 deltas.
>  100% (385878/385878) done
> 
> Is there a new way to get a quick clone?

I just checked out 1.5.1.4, built it, and cannot reproduce this behaviour. 
It's as fast as ever.

Ciao,
Dscho
