From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] bash completion: Add '--intent-to-add' long option
	for 'git add'
Date: Wed, 10 Dec 2008 11:41:31 -0800
Message-ID: <20081210194131.GB11928@spearce.org>
References: <1228937958-5091-1-git-send-email-lee.marlow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 20:42:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAUxP-0004Y7-Bl
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 20:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbYLJTld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 14:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbYLJTlc
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 14:41:32 -0500
Received: from george.spearce.org ([209.20.77.23]:34298 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbYLJTlc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 14:41:32 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C67DA38200; Wed, 10 Dec 2008 19:41:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1228937958-5091-1-git-send-email-lee.marlow@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102706>

Lee Marlow <lee.marlow@gmail.com> wrote:
> Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Trivially-Acked-by: Shawn O. Pearce <spearce@spearce.org>

 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c79c98f..5356e5b 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -563,7 +563,7 @@ _git_add ()
>  	--*)
>  		__gitcomp "
>  			--interactive --refresh --patch --update --dry-run
> -			--ignore-errors
> +			--ignore-errors --intent-to-add
>  			"
>  		return
>  	esac
> -- 
> 1.6.1.rc2.14.g5363d
> 

-- 
Shawn.
