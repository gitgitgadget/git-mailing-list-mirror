From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 02 Sep 2008 16:24:20 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809021620290.23787@xanadu.home>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KacRf-0003fM-EG
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 22:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbYIBUYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 16:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYIBUYl
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 16:24:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48923 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbYIBUYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 16:24:41 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6L00KHM4NP84G1@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Sep 2008 16:23:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94704>

On Tue, 2 Sep 2008, Pieter de Bie wrote:

> Sometimes I work on a detached HEAD and then forget about it. If I then create
> some commits and checkout another branch, I have to dig through my reflog to
> find the older commits. I know that "git commit" adds has a "Not currently on
> any branch", but it's not very noticeable and also doesn't work when you
> specify a commit message on the command line.
> 
> I suggest to add some extra output to the STDOUT after a commit if we're on a
> detached HEAD. The quick patch below adds output like:
> 
> Vienna:git pieter$ ./git commit --allow-empty -m"test"
> Created commit 6ce62c8b: test
> You are on a detached head, so this commit has not been recorded in a branch.
> If you don't want to lose this commit, checkout a branch and then run:
> 	git merge 6ce62c8bfcfb341106f3587d1c141c3955c2544c

Nah.

I have nothing against the idea of an extra message, but there are other 
ways to preserve commits made on top of a detached head.  So I'd keep 
only the first line.


Nicolas
