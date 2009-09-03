From: Christian Halstrick <christian.halstrick@sap.com>
Subject: Re: jgit diff, was Re: [JGIT] Request for help
Date: Thu, 3 Sep 2009 15:54:35 +0000 (UTC)
Message-ID: <loom.20090903T155033-910@post.gmane.org>
References: <4A9EFFB1.9090501@codeaurora.org> <alpine.DEB.1.00.0909030157090.8306@pacific.mpi-cbg.de> <20090903012207.GF1033@spearce.org> <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 18:00:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjEjS-0005YI-Iz
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 18:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbZICQAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 12:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbZICQAE
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 12:00:04 -0400
Received: from lo.gmane.org ([80.91.229.12]:42228 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829AbZICQAD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 12:00:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MjEjD-0005Tm-DL
	for git@vger.kernel.org; Thu, 03 Sep 2009 18:00:03 +0200
Received: from 155.56.68.217 ([155.56.68.217])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Sep 2009 18:00:03 +0200
Received: from christian.halstrick by 155.56.68.217 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Sep 2009 18:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 155.56.68.217 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127659>

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

...
> > > This is not really difficult in Java, however, it relies on a working 
> > > diff implementation (and IIRC my implementation has not yet been 
> > > integrated into JGit).
> > 
> > Speaking of... where does that stand?
> 
> Same as where I left off.  IOW it is a working implementation that saw 
> some testing, but I simply lack the time for performance tuning.

I can offer my help here. I looked at Dscho's code before, provided patches to
let it compile and run the tests (IIRC not fully successfully). I started in my
local repo to modify enhance the tests but didn't finished with that yet. I'll
try now to add some performance tests and tests derived from native Git diff 
tests. 

> 
> It should not be all that bad, though.
> 
...
> Seems I misremembered a bit.  Christian provided a patch to make it 
> compileable, but I think that I ran the script to verify that the diffs 
> are correct on jgit.git and IIRC it completed fine.
