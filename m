From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Dec 2008, #02; Sun, 14)
Date: Mon, 15 Dec 2008 22:36:20 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812152211310.19665@iabervon.org>
References: <7v7i632mg9.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0812151423390.19665@iabervon.org> <7vr648uc88.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 04:37:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCQkg-0002kd-68
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 04:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbYLPDgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 22:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbYLPDgW
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 22:36:22 -0500
Received: from iabervon.org ([66.92.72.58]:49739 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbYLPDgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 22:36:21 -0500
Received: (qmail 22920 invoked by uid 1000); 16 Dec 2008 03:36:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Dec 2008 03:36:20 -0000
In-Reply-To: <7vr648uc88.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103240>

On Mon, 15 Dec 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Sun, 14 Dec 2008, Junio C Hamano wrote:
> >
> >> [On Hold]
> >> 
> >> * nd/narrow (Sun Nov 30 17:54:38 2008 +0700) 17 commits
> >>  - wt-status: show sparse checkout info
> >>  - Introduce default sparse patterns (core.defaultsparse)
> >>  - checkout: add new options to support sparse checkout
> >>  - clone: support sparse checkout with --sparse-checkout option
> >>  - unpack_trees(): add support for sparse checkout
> >>  - unpack_trees(): keep track of unmerged entries
> >>  - Introduce "sparse patterns"
> >>  - Merge branch 'master' into nd/narrow
> >>  + t2104: touch portability fix
> >>  + grep: skip files outside sparse checkout area
> >>  + checkout_entry(): CE_NO_CHECKOUT on checked out entries.
> >>  + Prevent diff machinery from examining worktree outside sparse
> >>    checkout
> >
> > I think this patch (slightly reframed) would be good to have independantly 
> > of the series; it also means that we won't do weird things if someone 
> > changes a file in the worktree which is marked as CE_VALID, and may well 
> > may CE_VALID sufficient for the index representation of paths outside the 
> > checkout.
> 
> It is a bit unclear which one you meant by "this patch", sorry.

"Prevent diff machinery from examining worktree outside sparse checkout", 
which (possibly in the next version) will prevent the diff machinery from 
examining worktree files for paths that are CE_VALID in the index.

	-Daniel
*This .sig left intentionally blank*
