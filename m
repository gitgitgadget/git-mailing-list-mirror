From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Dec 2008, #02; Sun, 14)
Date: Mon, 15 Dec 2008 14:59:19 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812151423390.19665@iabervon.org>
References: <7v7i632mg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 21:00:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCJcN-0004f1-U1
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 21:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbYLOT7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 14:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbYLOT7W
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 14:59:22 -0500
Received: from iabervon.org ([66.92.72.58]:38018 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbYLOT7V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 14:59:21 -0500
Received: (qmail 4992 invoked by uid 1000); 15 Dec 2008 19:59:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Dec 2008 19:59:19 -0000
In-Reply-To: <7v7i632mg9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103203>

On Sun, 14 Dec 2008, Junio C Hamano wrote:

> [On Hold]
> 
> * nd/narrow (Sun Nov 30 17:54:38 2008 +0700) 17 commits
>  - wt-status: show sparse checkout info
>  - Introduce default sparse patterns (core.defaultsparse)
>  - checkout: add new options to support sparse checkout
>  - clone: support sparse checkout with --sparse-checkout option
>  - unpack_trees(): add support for sparse checkout
>  - unpack_trees(): keep track of unmerged entries
>  - Introduce "sparse patterns"
>  - Merge branch 'master' into nd/narrow
>  + t2104: touch portability fix
>  + grep: skip files outside sparse checkout area
>  + checkout_entry(): CE_NO_CHECKOUT on checked out entries.
>  + Prevent diff machinery from examining worktree outside sparse
>    checkout

I think this patch (slightly reframed) would be good to have independantly 
of the series; it also means that we won't do weird things if someone 
changes a file in the worktree which is marked as CE_VALID, and may well 
may CE_VALID sufficient for the index representation of paths outside the 
checkout.

	-Daniel
*This .sig left intentionally blank*
