From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: remove unused function _git_diff_tree
Date: Sat, 2 Aug 2008 13:59:57 -0700
Message-ID: <20080802205957.GB24723@spearce.org>
References: <1217652429-58511-1-git-send-email-lee.marlow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:01:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPODl-0007O7-Dn
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbYHBU76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 16:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbYHBU76
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 16:59:58 -0400
Received: from george.spearce.org ([209.20.77.23]:54335 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbYHBU76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 16:59:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A666538438; Sat,  2 Aug 2008 20:59:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1217652429-58511-1-git-send-email-lee.marlow@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91177>

Lee Marlow <lee.marlow@gmail.com> wrote:
> completion for git diff-tree was removed in 5cfb4fe
> 
> Signed-off-by: Lee Marlow <lee.marlow@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 30d8701..e32c1f1 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -721,11 +721,6 @@ _git_diff ()
>  	__git_complete_file
>  }
>  
> -_git_diff_tree ()
> -{
> -	__gitcomp "$(__git_refs)"
> -}
> -
>  _git_fetch ()
>  {
>  	local cur="${COMP_WORDS[COMP_CWORD]}"
> -- 

-- 
Shawn.
