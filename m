From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] completion.bash: add 'skip' and 'run' to git-bisect
Date: Wed, 2 Jul 2008 13:35:40 +0000
Message-ID: <20080702133540.GA19103@spearce.org>
References: <1215005390-1506-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 15:36:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE2VO-0000jo-N9
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 15:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbYGBNfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 09:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbYGBNfO
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 09:35:14 -0400
Received: from george.spearce.org ([209.20.77.23]:33382 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbYGBNfN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 09:35:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B6F4B38265; Wed,  2 Jul 2008 13:35:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1215005390-1506-1-git-send-email-dpotapov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87134>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>

Keeping up with the subcommands is a challenge.  ;-)

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  contrib/completion/git-completion.bash |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ebf7cde..3d15434 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -511,7 +511,7 @@ _git_add ()
>  
>  _git_bisect ()
>  {
> -	local subcommands="start bad good reset visualize replay log"
> +	local subcommands="start bad good skip reset visualize replay log run"
>  	local subcommand="$(__git_find_subcommand "$subcommands")"
>  	if [ -z "$subcommand" ]; then
>  		__gitcomp "$subcommands"
> @@ -519,7 +519,7 @@ _git_bisect ()
>  	fi
>  
>  	case "$subcommand" in
> -	bad|good|reset)
> +	bad|good|reset|skip)
>  		__gitcomp "$(__git_refs)"
>  		;;
>  	*)
> -- 

-- 
Shawn.
