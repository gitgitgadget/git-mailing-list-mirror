From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] completion: use git rev-parse to detect bare repos
Date: Wed, 20 May 2009 15:54:30 -0700
Message-ID: <20090520225430.GU30527@spearce.org>
References: <1242663870-11895-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 00:54:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6ugG-0007RD-Qu
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 00:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611AbZETWy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 18:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754997AbZETWy2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 18:54:28 -0400
Received: from george.spearce.org ([209.20.77.23]:55728 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbZETWy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 18:54:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2CA2E381FD; Wed, 20 May 2009 22:54:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1242663870-11895-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119640>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> Its check is more robust than a config check for core.bare

Trivially-Acked-by: Shawn O. Pearce <spearce@spearce.org>

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ba13c49..0c8bb53 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -132,7 +132,7 @@ __git_ps1 ()
>  		local c
>  
>  		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
> -			if [ "true" = "$(git config --bool core.bare 2>/dev/null)" ]; then
> +			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
>  				c="BARE:"
>  			else
>  				b="GIT_DIR!"
> -- 
> 1.6.3.1.137.g29aa
> 

-- 
Shawn.
