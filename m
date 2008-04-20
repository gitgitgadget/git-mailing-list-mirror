From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] completion: remove use of dashed git commands
Date: Sun, 20 Apr 2008 15:20:54 -0400
Message-ID: <20080420192054.GH29771@spearce.org>
References: <1208712525-1747-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 21:21:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnf6e-0007G7-GN
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 21:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbYDTTU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 15:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755531AbYDTTU6
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 15:20:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47528 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154AbYDTTU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 15:20:57 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jnf5k-0006l6-0H; Sun, 20 Apr 2008 15:20:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 588D720FBAE; Sun, 20 Apr 2008 15:20:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1208712525-1747-1-git-send-email-dpmcgee@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79977>

Dan McGee <dpmcgee@gmail.com> wrote:
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Shawn O. Pearce <spearce@spearce.org>

Despite Dscho's remarks, this is a change that is harmless and
should be happening before we officially remove the dashed forms
from the user's path.
 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 4d81963..3f78630 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -152,7 +152,7 @@ __git_heads ()
>  		done
>  		return
>  	fi
> -	for i in $(git-ls-remote "$1" 2>/dev/null); do
> +	for i in $(git ls-remote "$1" 2>/dev/null); do
>  		case "$is_hash,$i" in
>  		y,*) is_hash=n ;;
>  		n,*^{}) is_hash=y ;;
> @@ -173,7 +173,7 @@ __git_tags ()
>  		done
>  		return
>  	fi
> -	for i in $(git-ls-remote "$1" 2>/dev/null); do
> +	for i in $(git ls-remote "$1" 2>/dev/null); do
>  		case "$is_hash,$i" in
>  		y,*) is_hash=n ;;
>  		n,*^{}) is_hash=y ;;
> @@ -200,7 +200,7 @@ __git_refs ()
>  		done
>  		return
>  	fi
> -	for i in $(git-ls-remote "$dir" 2>/dev/null); do
> +	for i in $(git ls-remote "$dir" 2>/dev/null); do
>  		case "$is_hash,$i" in
>  		y,*) is_hash=n ;;
>  		n,*^{}) is_hash=y ;;
> @@ -223,7 +223,7 @@ __git_refs2 ()
>  __git_refs_remotes ()
>  {
>  	local cmd i is_hash=y
> -	for i in $(git-ls-remote "$1" 2>/dev/null); do
> +	for i in $(git ls-remote "$1" 2>/dev/null); do
>  		case "$is_hash,$i" in
>  		n,refs/heads/*)
>  			is_hash=y
> -- 
> 1.5.5
> 

-- 
Shawn.
