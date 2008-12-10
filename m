From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] bash completion: Use 'git add' completions for
	'git stage'
Date: Wed, 10 Dec 2008 11:59:57 -0800
Message-ID: <20081210195957.GE11928@spearce.org>
References: <1228937958-5091-1-git-send-email-lee.marlow@gmail.com> <1228937958-5091-2-git-send-email-lee.marlow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 21:01:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAVFS-0003i3-Lw
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 21:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbYLJT77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 14:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755336AbYLJT76
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 14:59:58 -0500
Received: from george.spearce.org ([209.20.77.23]:36526 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480AbYLJT76 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 14:59:58 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 96ED138200; Wed, 10 Dec 2008 19:59:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1228937958-5091-2-git-send-email-lee.marlow@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102708>

Lee Marlow <lee.marlow@gmail.com> wrote:
> Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Also,

Trivially-Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 5356e5b..7e2b482 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1660,6 +1660,7 @@ _git ()
>  	show)        _git_show ;;
>  	show-branch) _git_show_branch ;;
>  	stash)       _git_stash ;;
> +	stage)       _git_add ;;
>  	submodule)   _git_submodule ;;
>  	svn)         _git_svn ;;
>  	tag)         _git_tag ;;
> -- 
> 1.6.1.rc2.14.g5363d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Shawn.
