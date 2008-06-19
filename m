From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] completion: add --graph to log command completion
Date: Thu, 19 Jun 2008 17:58:42 -0400
Message-ID: <20080619215842.GL11793@spearce.org>
References: <1213910153-10679-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:59:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9SAP-00027G-71
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbYFSV6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbYFSV6q
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:58:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59612 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYFSV6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 17:58:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K9S9L-0003FQ-0o; Thu, 19 Jun 2008 17:58:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C7A7820FBAE; Thu, 19 Jun 2008 17:58:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1213910153-10679-1-git-send-email-dpmcgee@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85545>

Dan McGee <dpmcgee@gmail.com> wrote:
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

First change for 1.5.6.1?  With --graph in 1.5.6 we really should
have included this as part of 1.5.6.  Oh well.  1.5.6.1 perhaps
Junio?

> ---
>  contrib/completion/git-completion.bash |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2141b6b..0eb8df0 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -761,6 +761,7 @@ _git_log ()
>  			--pretty= --name-status --name-only --raw
>  			--not --all
>  			--left-right --cherry-pick
> +			--graph
>  			"
>  		return
>  		;;
> -- 
> 1.5.6

-- 
Shawn.
