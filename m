From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Fix worktree usage message
Date: Sun, 18 Oct 2015 13:39:02 +0200
Message-ID: <20151018113902.GA12622@ikke.info>
References: <1445166144-29509-1-git-send-email-tigerkid001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 13:46:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnmPt-0000pK-He
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 13:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbbJRLqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 07:46:16 -0400
Received: from ikke.info ([178.21.113.177]:44782 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456AbbJRLqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 07:46:16 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Oct 2015 07:46:15 EDT
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id DAE3F4400AE; Sun, 18 Oct 2015 13:39:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1445166144-29509-1-git-send-email-tigerkid001@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279808>



On Sun, Oct 18, 2015 at 04:32:24PM +0530, Sidhant Sharma wrote:
> Mark <branch> as optional in worktree command line usage.

Thank you for the patch. 

Can you also explain why you mark it as optional in the commit message?
That way it's clear why this patch is needed.

> 
> Hi, just starting out with development for Git. Found this one super easy to fix,
> so made a patch :)

These kind of comments don't belong in the commit message. You could add
them below the first three ---. That way, they will not be part of the
commit history.


> 
> ---
>  builtin/worktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 71bb770..33d2d37 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -10,7 +10,7 @@
>  #include "refs.h"
> 
>  static const char * const worktree_usage[] = {
> -	N_("git worktree add [<options>] <path> <branch>"),
> +	N_("git worktree add [<options>] <path> [<branch>]"),
>  	N_("git worktree prune [<options>]"),
>  	NULL
>  };
> --
> 2.6.2
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
