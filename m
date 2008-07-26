From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Add long options for 'git describe'
Date: Sat, 26 Jul 2008 16:52:10 -0500
Message-ID: <20080726215210.GC16219@spearce.org>
References: <20080725162028.GB21117@spearce.org> <1217068016-10954-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	SZEDER GGGbor <szeder@ira.uka.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jul 26 23:53:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMrhP-0005nS-Rx
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 23:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbYGZVwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 17:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756026AbYGZVwL
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 17:52:11 -0400
Received: from george.spearce.org ([209.20.77.23]:57094 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbYGZVwK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 17:52:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 19566383A5; Sat, 26 Jul 2008 21:52:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1217068016-10954-1-git-send-email-trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90288>

Thomas Rast <trast@student.ethz.ch> wrote:
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Much shorter, thanks.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 3b04934..4ae8b36 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -665,6 +665,15 @@ _git_commit ()
>  
>  _git_describe ()
>  {
> +	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	case "$cur" in
> +	--*)
> +		__gitcomp "
> +			--all --tags --contains --abbrev= --candidates=
> +			--exact-match --debug --long --match --always
> +			"
> +		return
> +	esac
>  	__gitcomp "$(__git_refs)"
>  }
>  

-- 
Shawn.
