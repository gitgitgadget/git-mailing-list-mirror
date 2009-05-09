From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCHv2 2/2] completion: complete config variables for
	--get/getall/unset/unset-all
Date: Fri, 8 May 2009 20:44:38 -0700
Message-ID: <20090509034438.GZ30527@spearce.org>
References: <1241832213-23070-1-git-send-email-bebarino@gmail.com> <1241832213-23070-2-git-send-email-bebarino@gmail.com> <1241832213-23070-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 09 05:44:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2dUZ-0006KT-9p
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 05:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbZEIDoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 23:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbZEIDoi
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 23:44:38 -0400
Received: from george.spearce.org ([209.20.77.23]:34693 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbZEIDoi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 23:44:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B7AFF381D1; Sat,  9 May 2009 03:44:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1241832213-23070-3-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118647>

Stephen Boyd <bebarino@gmail.com> wrote:
> This should make it easier for users to get and unset their
> configuration variables without having to open documentation or dig
> through their configuration file.
> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

These probably could have been one patch, since the function
is introduced only to support this one usage, and this patch
is only 4 lines larger than the function definition anyway...

But yea, this series is better.

Acked-by: Shawn O. Pearce <spearce@spearce.org>


> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index e73359c..ad26b7c 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1417,6 +1417,10 @@ _git_config ()
>  		__gitcomp "$__git_send_email_suppresscc_options"
>  		return
>  		;;
> +	--get|--get-all|--unset|--unset-all)
> +		__gitcomp "$(__git_config_get_set_variables)"
> +		return
> +		;;
>  	*.*)
>  		COMPREPLY=()
>  		return
> -- 
> 1.6.3
> 

-- 
Shawn.
