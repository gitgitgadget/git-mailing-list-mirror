From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: complete refs for git-grep
Date: Mon, 12 Oct 2009 07:27:10 -0700
Message-ID: <20091012142710.GI9261@spearce.org>
References: <200910071727.50770.trast@student.ethz.ch> <9f58ba1e7db9702d1b0594a8016c204e3d50b72f.1255337776.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:40:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxM4H-0002uT-7E
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914AbZJLO1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756908AbZJLO1t
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:27:49 -0400
Received: from george.spearce.org ([209.20.77.23]:50611 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906AbZJLO1r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:27:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DFA9F381FE; Mon, 12 Oct 2009 14:27:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9f58ba1e7db9702d1b0594a8016c204e3d50b72f.1255337776.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130020>

Thomas Rast <trast@student.ethz.ch> wrote:
> > So I'll roll a simpler patch that just always (before --) completes
> > refs instead, if that's ok.

Hard to argue with that logic.  :-)

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 6fd7e1d..b08cd77 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1048,7 +1048,8 @@ _git_grep ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +
> +	__gitcomp "$(__git_refs)"
>  }

-- 
Shawn.
