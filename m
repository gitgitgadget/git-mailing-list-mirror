From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Fetching a tree from a remote server
Date: Wed, 3 May 2006 21:08:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605032054170.6713@iabervon.org>
References: <Pine.LNX.4.64.0605032026070.6713@iabervon.org>
 <Pine.LNX.4.63.0605040247460.24675@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 03:08:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbSJv-000069-4K
	for gcvg-git@gmane.org; Thu, 04 May 2006 03:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWEDBHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 21:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWEDBHs
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 21:07:48 -0400
Received: from iabervon.org ([66.92.72.58]:40720 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750777AbWEDBHs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 21:07:48 -0400
Received: (qmail 8400 invoked by uid 1000); 3 May 2006 21:08:27 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 May 2006 21:08:27 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605040247460.24675@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19544>

On Thu, 4 May 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 3 May 2006, Daniel Barkalow wrote:
> 
> > Is there something to do the opposite of git clone -n? That is, I want to 
> > fill a directory with a treeish ref, and I don't care about any history or 
> > bookkeeping.
> 
> Is git-tar-tree your friend or what?

The problem is that I'm on the build machine, and the repository is on the 
remote server. I suppose I could do "(ssh server 
GIT_DIR=/repo.git git-tar-tree HEAD) | tar -xf -", but that's not quite 
the most clear thing, and I'd have to split up the URLs. Also, it wouldn't 
work with only git: access to the repository.

(On the other hand, it does work for my actual application, I'm doing it 
from a Makefile, and it's blazingly fast, so I guess I'm set.)

	-Daniel
*This .sig left intentionally blank*
