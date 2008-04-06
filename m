From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add prefix oriented completions for diff and format-patch commands.
Date: Sun, 6 Apr 2008 15:45:20 -0400
Message-ID: <20080406194520.GK10274@spearce.org>
References: <1207500968-792-1-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Pascal Obry <pascal@obry.net>
To: Pascal Obry <pascal.obry@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 21:46:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jiaoh-0005eA-VS
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 21:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbYDFTpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 15:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYDFTpZ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 15:45:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43606 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbYDFTpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 15:45:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jiani-0004sw-5a; Sun, 06 Apr 2008 15:45:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BE08120FBAE; Sun,  6 Apr 2008 15:45:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1207500968-792-1-git-send-email-pascal@obry.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78917>

Pascal Obry <pascal.obry@gmail.com> wrote:
> Signed-off-by: Pascal Obry <pascal@obry.net>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 791e30f..618d278 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -639,7 +639,9 @@ _git_diff ()
>  			--find-copies-harder --pickaxe-all --pickaxe-regex
>  			--text --ignore-space-at-eol --ignore-space-change
>  			--ignore-all-space --exit-code --quiet --ext-diff
> -			--no-ext-diff"
> +			--no-ext-diff
> +			--no-prefix --src-prefix= --dst-prefix=
> +			"
>  		return
>  		;;
>  	esac
> @@ -696,6 +698,7 @@ _git_format_patch ()
>  			--full-index --binary
>  			--not --all
>  			--cover-letter
> +			--no-prefix --src-prefix= --dst-prefix=
>  			"
>  		return
>  		;;
> -- 

-- 
Shawn.
