From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix bash completion in path with spaces
Date: Mon, 30 Mar 2009 07:39:52 -0700
Message-ID: <20090330143952.GB23521@spearce.org>
References: <1238412457-29674-1-git-send-email-j16sdiz+freenet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 16:42:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoIgi-0004xz-BI
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 16:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbZC3Ojz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 10:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbZC3Ojy
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 10:39:54 -0400
Received: from george.spearce.org ([209.20.77.23]:60693 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbZC3Ojy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 10:39:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7705838211; Mon, 30 Mar 2009 14:39:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1238412457-29674-1-git-send-email-j16sdiz+freenet@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115159>

"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com> wrote:
> 
> Signed-off-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>

Trivially-acked-by: Shawn O. Pearce <spearce@spearce.org>

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1c6b0e2..e72ce24 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1103,7 +1103,7 @@ _git_log ()
>  	local cur="${COMP_WORDS[COMP_CWORD]}"
>  	local g="$(git rev-parse --git-dir 2>/dev/null)"
>  	local merge=""
> -	if [ -f $g/MERGE_HEAD ]; then
> +	if [ -f "$g/MERGE_HEAD" ]; then
>  		merge="--merge"
>  	fi
>  	case "$cur" in
> @@ -1943,7 +1943,7 @@ _gitk ()
>  	local cur="${COMP_WORDS[COMP_CWORD]}"
>  	local g="$(__gitdir)"
>  	local merge=""
> -	if [ -f $g/MERGE_HEAD ]; then
> +	if [ -f "$g/MERGE_HEAD" ]; then
>  		merge="--merge"
>  	fi
>  	case "$cur" in

-- 
Shawn.
