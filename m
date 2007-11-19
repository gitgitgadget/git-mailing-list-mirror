From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: Fix references to deprecated commands
Date: Sun, 18 Nov 2007 20:54:11 -0500
Message-ID: <20071119015411.GA4978@fieldses.org>
References: <7vlk998u6r.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711080041120.4362@racer.site> <20071108145435.GA18727@diku.dk> <4733249B.9020504@op5.se> <20071108160114.GB20988@diku.dk> <7vzlxo1mga.fsf@gitster.siamese.dyndns.org> <20071109002001.GB5082@diku.dk> <7vy7d8xlej.fsf_-_@gitster.siamese.dyndns.org> <20071112002410.GA21970@diku.dk> <20071112003251.GB21970@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Nov 19 02:54:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItvqQ-0006re-Br
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 02:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbXKSByV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 20:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbXKSByV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 20:54:21 -0500
Received: from mail.fieldses.org ([66.93.2.214]:33856 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509AbXKSByU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 20:54:20 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Itvpz-0001YS-PK; Sun, 18 Nov 2007 20:54:11 -0500
Content-Disposition: inline
In-Reply-To: <20071112003251.GB21970@diku.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65400>

On Mon, Nov 12, 2007 at 01:32:51AM +0100, Jonas Fonseca wrote:
> Subject: [PATCH] Documentation: Fix references to deprecated commands
> 
> ... by changing git-tar-tree reference to git-archive and removing
> seemingly unrelevant footnote about git-ssh-{fetch,upload}.

Makes sense to me, but for some reason git-am complains about a corrupt
patch when I feed it this email.  I reconstructed it by hand, fixed up
one more reference to git-tar-tree, and applied to my tree.

--b.

> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
>  Documentation/core-tutorial.txt         |    5 -----
>  Documentation/git-get-tar-commit-id.txt |    4 ++--
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
>  Now with SOB and ...
> 
>  Jonas Fonseca <fonseca@diku.dk> wrote Mon, Nov 12, 2007:
>  > diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
>  > index 9b5f86f..ef1b19c 100644
>  > --- a/Documentation/git-get-tar-commit-id.txt
>  > +++ b/Documentation/git-get-tar-commit-id.txt
>  > @@ -14,12 +14,12 @@ SYNOPSIS
>  >  return code of 1.  This can happen if <tarfile> had not been created
>  > -using git-tar-tree or if the first parameter of git-tar-tree had been
>  > +using git-archive or if the first parameter of git-tar-tree had been
>  >  a tree ID instead of a commit ID or tag.
> 
>  ... s//g
> 
> diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
> index ebd2492..401d1de 100644
> --- a/Documentation/core-tutorial.txt
> +++ b/Documentation/core-tutorial.txt
> @@ -1090,11 +1090,6 @@ server like git Native transport does.  Any stock HTTP server
>  that does not even support directory index would suffice.  But
>  you must prepare your repository with `git-update-server-info`
>  to help dumb transport downloaders.
> -+
> -There are (confusingly enough) `git-ssh-fetch` and `git-ssh-upload`
> -programs, which are 'commit walkers'; they outlived their
> -usefulness when git Native and SSH transports were introduced,
> -and are not used by `git pull` or `git push` scripts.
>  
>  Once you fetch from the remote repository, you `merge` that
>  with your current branch.
> diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
> index 9b5f86f..ef1b19c 100644
> --- a/Documentation/git-get-tar-commit-id.txt
> +++ b/Documentation/git-get-tar-commit-id.txt
> @@ -14,12 +14,12 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  Acts as a filter, extracting the commit ID stored in archives created by
> -git-tar-tree.  It reads only the first 1024 bytes of input, thus its
> +gitlink:git-archive[1].  It reads only the first 1024 bytes of input, thus its
>  runtime is not influenced by the size of <tarfile> very much.
>  
>  If no commit ID is found, git-get-tar-commit-id quietly exists with a
>  return code of 1.  This can happen if <tarfile> had not been created
> -using git-tar-tree or if the first parameter of git-tar-tree had been
> +using git-archive or if the <treeish> parameter of git-archive had been
>  a tree ID instead of a commit ID or tag.
> 
> -- 
> Jonas Fonseca
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
