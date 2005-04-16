From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 16:19:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504161546120.30848-100000@iabervon.org>
References: <42616A9F.1030302@timesys.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 22:15:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMthV-0003zu-6Y
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 22:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVDPUTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 16:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVDPUTG
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 16:19:06 -0400
Received: from iabervon.org ([66.92.72.58]:46341 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262750AbVDPUSp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 16:18:45 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMtkr-0007i4-00; Sat, 16 Apr 2005 16:19:01 -0400
To: Mike Taht <mike.taht@timesys.com>
In-Reply-To: <42616A9F.1030302@timesys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Mike Taht wrote:

> Junio C Hamano wrote:
> >>>>>>"MT" == Mike Taht <mike.taht@timesys.com> writes:
> > 
> > 
> > MT> alternatively, "git-archive-torrent" to create a list of files for a
> > MT> bittorrent feed....
> > 
> > That is certainly good for establishing the baseline, but you
> > still need to leverage the inherent delta-compressibility
> > between related blobs/trees by also doing something like what I
> > described as "diff package", don't you?
> 
> Yes... yes you could have files and diffs generated statically...
> 
> although something like a bittorrent server/client/frontend, call it 
> "gittorrent" (I hate being the first to make this pun) could walk the 
> hashes dynamically (
> Ihave: sha,sha,sha,sha... Sendme: shaxxxxxxxxxxxxxxxxxxx
> Hereswhatyouneedfromgit: file,file,file,diff,diff,diff,...)

I'm actually working on a trivial HTTP client to do this. The user says
"get <commit-id> from <url>", and it gets that object, the associated
trees, and the associated blobs, skipping any that it already has.

This should save having a non-standard public-facing server process, and
be essentially as effective, at least once I have it using a single
connection for everything.

	-Daniel
*This .sig left intentionally blank*

