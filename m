From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] completion: git commit should list --interactive
Date: Fri, 19 Sep 2008 18:16:54 -0700
Message-ID: <20080920011654.GI13139@spearce.org>
References: <279b37b20809101740v4a8f19b8k395208c124af0de0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 03:18:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgr73-0003oI-DI
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 03:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbYITBQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 21:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYITBQ4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 21:16:56 -0400
Received: from george.spearce.org ([209.20.77.23]:50937 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbYITBQz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 21:16:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D49B63835F; Sat, 20 Sep 2008 01:16:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <279b37b20809101740v4a8f19b8k395208c124af0de0@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96331>

Eric Raible <raible@gmail.com> wrote:
> Signed-off-by: Eric Raible <raible@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Trivally-Acked-by: Shawn O. Pearce <spearce@spearce.org>

Sorry, got backlogged at day-job.  I'm kind of surprised this isn't
in-tree yet, its pretty simple...

> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index d3fb6ae..2d8d1c3 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -750,7 +750,7 @@ _git_commit ()
>  	--*)
>  		__gitcomp "
>  			--all --author= --signoff --verify --no-verify
> -			--edit --amend --include --only
> +			--edit --amend --include --only --interactive
>  			"
>  		return
>  	esac
> -- 
> 1.6.0.1.436.g09e16c.dirty

-- 
Shawn.
