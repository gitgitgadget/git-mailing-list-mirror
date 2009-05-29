From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: remove always true if statement from __git_ps1()
Date: Fri, 29 May 2009 08:03:19 -0700
Message-ID: <20090529150319.GC30527@spearce.org>
References: <1243527441-3394-1-git-send-email-szeder@ira.uka.de> <1243598436-2207-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Pavlic <ted@tedpavlic.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: SZEDER G??bor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 29 17:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA3d1-000179-T5
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 17:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761520AbZE2PDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 11:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761497AbZE2PDT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 11:03:19 -0400
Received: from george.spearce.org ([209.20.77.23]:42460 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761469AbZE2PDS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 11:03:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 753C6381FD; Fri, 29 May 2009 15:03:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1243598436-2207-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120283>

SZEDER G??bor <szeder@ira.uka.de> wrote:
> The recent commits 8763dbb1 (completion: fix PS1 display during a
> merge on detached HEAD, 2009-05-16), ff790b6a (completion: simplify
> "current branch" in __git_ps1(), 2009-05-10), and d7107ca6
> (completion: fix PS1 display during an AM on detached HEAD,
> 2009-05-26) ensure that the branch name in __git_ps1() is always set
> to something sensible.  Therefore, the condition for checking the
> non-empty branch name is always fulfilled, and can be removed.
> 
> Signed-off-by: SZEDER G??bor <szeder@ira.uka.de>
> ---
> 
> The patch is the same, but the commit message is different, because
> Junio's d7107ca6 has fixed the issue.
>
>  contrib/completion/git-completion.bash |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)

Yay, code reduction is good.  :-)

Trivially-Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
