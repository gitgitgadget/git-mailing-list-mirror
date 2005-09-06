From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: bogus merges
Date: Tue, 6 Sep 2005 14:28:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509061409180.23242@iabervon.org>
References: <59a6e58305090507387d412b3d@mail.gmail.com>
 <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wayne Scott <wsc9tt@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 20:26:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECi7k-0005rK-6P
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 20:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVIFSYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 14:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVIFSYo
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 14:24:44 -0400
Received: from iabervon.org ([66.92.72.58]:29956 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750777AbVIFSYo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 14:24:44 -0400
Received: (qmail 32051 invoked by uid 1000); 6 Sep 2005 14:28:39 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Sep 2005 14:28:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8136>

On Mon, 5 Sep 2005, Linus Torvalds wrote:

> On Mon, 5 Sep 2005, Wayne Scott wrote:
> >
> > A recent commit in linux-2.6 looks like this:
> 
> It hopefully shouldn't happen any more with the improved and fixed
> git-merge-base.

Couldn't it also happen if there's stale data in MERGE_HEAD when you 
commit a normal patch? The description doesn't look like a merge at all, 
but rather like a normal patch that inappropriately picked up an extra 
head. I'd guess he tried to merge something, got a conflict, decided that 
he didn't really want to do that anyway, switched to a different branch, 
applied a patch, and committed without noticing the note that he seemed to 
be committing a merge.

Probably the right thing is actually to clean up more when switching 
tasks, but it would probably also be worth checking that merges make sense 
as well.

	-Daniel
*This .sig left intentionally blank*
