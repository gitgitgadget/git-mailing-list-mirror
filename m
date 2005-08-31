From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] Reorganize read-tree
Date: Wed, 31 Aug 2005 13:04:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508311257480.23242@iabervon.org>
References: <Pine.LNX.4.63.0508302317380.23242@iabervon.org> <tnxy86ikxan.fsf@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 19:01:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAVxJ-0003LN-Jy
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 19:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVHaRAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 13:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbVHaRAz
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 13:00:55 -0400
Received: from iabervon.org ([66.92.72.58]:14348 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964882AbVHaRAy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2005 13:00:54 -0400
Received: (qmail 6552 invoked by uid 1000); 31 Aug 2005 13:04:39 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Aug 2005 13:04:39 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxy86ikxan.fsf@arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7980>

On Wed, 31 Aug 2005, Catalin Marinas wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > I got mostly done with this before Linus mentioned the possibility of
> > having multiple index entries in the same stage for a single path. I
> > finished it anyway, but I'm not sure that we won't want to know which of
> > the common ancestors contributed which, and, if some of them don't have a
> > path, we wouldn't be able to tell.
> 
> I don't have time to look at the patch and I don't have a good
> knowledge of the GIT internals, so I will just ask. Does this patch
> changes the call convention for git-merge-one-file-script? I have my
> own script for StGIT and I would need to know whether it is affected
> or not.

Nope, it only changes the trivial merge calling convention within 
read-tree.c; I think it's plausible that we might like to add information 
at some point, but the short-term goal is just to prevent a few bad cases 
in trivial merges.
