From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] completion: add --graph to log command completion
Date: Thu, 19 Jun 2008 18:55:52 -0400
Message-ID: <20080619225552.GQ11793@spearce.org>
References: <1213910153-10679-1-git-send-email-dpmcgee@gmail.com> <20080619215842.GL11793@spearce.org> <20080619224012.GA6705@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:57:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9T3w-00009V-HA
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbYFSWz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 18:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYFSWz7
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:55:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45532 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbYFSWz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 18:55:58 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K9T2e-0007kG-34; Thu, 19 Jun 2008 18:55:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 62FE420FBAE; Thu, 19 Jun 2008 18:55:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080619224012.GA6705@mithlond.arda.local>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85556>

Teemu Likonen <tlikonen@iki.fi> wrote:
> I think I have already sent twice a patch with --graph completion.

I didn't Ack them because at the time --graph wasn't even in next
yet I think.  Then I got busy and forgot.  And --graph slipped
through into the 1.5.6 release without your bash completion patches.
Sorry.

> ---snip---
> bash: Add more option completions for 'git log'
> 
> Options added: --graph --walk-reflogs --stat --numstat --shortstat
> --decorate --diff-filter= --color-words
> 
> Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
> ---

This conflicts with the patch you are replying to, but it makes
sense to do these options as well.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

assuming the semantic (or merge) conflict on --graph is worked out.
;-)

>  contrib/completion/git-completion.bash |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 506b40c..e78ca8e 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -761,6 +761,9 @@ _git_log ()
>  			--pretty= --name-status --name-only --raw
>  			--not --all
>  			--left-right --cherry-pick
> +			--stat --numstat --shortstat
> +			--decorate --diff-filter=
> +			--color-words --walk-reflogs --graph
>  			"
>  		return
>  		;;
> -- 
> 1.5.6.2.g3c3a
> 

-- 
Shawn.
