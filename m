From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] rebase --no-verify
Date: Mon, 6 Oct 2008 07:30:28 -0700
Message-ID: <20081006143028.GC7684@spearce.org>
References: <20081005222654.6117@nanako3.lavabit.com> <b19eae4e0810021710v14a3901an1f793de00c439ba1@mail.gmail.com> <20081006141429.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 16:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmr83-0000yh-4J
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 16:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbYJFOaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 10:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbYJFOa3
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 10:30:29 -0400
Received: from george.spearce.org ([209.20.77.23]:40686 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbYJFOa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 10:30:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2D0513835F; Mon,  6 Oct 2008 14:30:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081006141429.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97587>

Nanako Shiraishi <nanako3@lavabit.com> wrote:
> It is sometimes desirable to disable the safety net of pre-rebase hook
> when the user knows what he is doing (for example, when the original
> changes on the branch have not been shown to the public yet).
> 
> This teaches --no-verify option to git-rebase, which is similar to the way
> pre-commit hook is bypassed by git-commit.

Looks good.
 
>     It probably is better to fix "rebase -i" to share more code with the main
>     "rebase" script to avoid duplicated run-pre-rebase-hook function, but it
>     is beyond what I can do right now.  Perhaps people more smart and
>     beautiful than me can help (^_^;)

True.  But its already a mess.  git-sequencer is probably the
right approach to merge it all together.
 
>  git-rebase--interactive.sh |   10 +++++++++-
>  git-rebase.sh              |    7 ++++++-
>  t/t3409-rebase-hook.sh     |   16 ++++++++++++++++
>  3 files changed, 31 insertions(+), 2 deletions(-)

Docs?

-- 
Shawn.
