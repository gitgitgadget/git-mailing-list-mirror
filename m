From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add --staged to bash completion for git diff
Date: Sun, 22 Mar 2009 17:33:41 -0700
Message-ID: <20090323003341.GJ23521@spearce.org>
References: <372194e70903211629w52705806l5a82c2dde19b73f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin McConnell <kevin.mcconnell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 01:35:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlY8O-0007Et-Vq
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 01:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509AbZCWAdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 20:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbZCWAdn
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 20:33:43 -0400
Received: from george.spearce.org ([209.20.77.23]:51642 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbZCWAdn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 20:33:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AFC7038211; Mon, 23 Mar 2009 00:33:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <372194e70903211629w52705806l5a82c2dde19b73f7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114212>

Kevin McConnell <kevin.mcconnell@gmail.com> wrote:
> The --staged option (synonym for --cached) isn't listed in the
> completion choices for git diff.  This tiny patch adds it.

Missing Signed-off-by line?

Otherwise though,

Trivially-Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index ed235f7..6bc32df 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -899,7 +899,7 @@ _git_diff ()
>  	local cur="${COMP_WORDS[COMP_CWORD]}"
>  	case "$cur" in
>  	--*)
> -		__gitcomp "--cached --pickaxe-all --pickaxe-regex
> +		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
>  			--base --ours --theirs
>  			$__git_diff_common_options
>  			"

-- 
Shawn.
