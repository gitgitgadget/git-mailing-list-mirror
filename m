From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Alter git-rebase command line options.
Date: Wed, 26 Apr 2006 14:30:47 +0200
Organization: At home
Message-ID: <e2np4p$b9a$1@sea.gmane.org>
References: <BAYC1-PASMTP0659C709B7FFCB63182FE1AEBC0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Apr 26 14:31:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYjB5-0000Zl-S4
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 14:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWDZMbR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 08:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWDZMbQ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 08:31:16 -0400
Received: from main.gmane.org ([80.91.229.2]:22942 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932418AbWDZMbQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 08:31:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYjAR-0000QV-SI
	for git@vger.kernel.org; Wed, 26 Apr 2006 14:30:52 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 14:30:51 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 14:30:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19202>

sean wrote:

>   git rebase [--branch <branch>] <newbase>
>   git rebase --continue
>   git rebase --abort
> 
> Add "--continue" to restart the rebase process after
> manually resolving conflicts.  The user is warned if
> there are still differences between the index and the
> working files.
> 
> Add "--abort" to restore the original branch, and
> remove the .dotest working files.

Very nice.

>  SYNOPSIS
>  --------
> -'git-rebase' [--onto <newbase>] <upstream> [<branch>]
> +'git-rebase' [--branch <branch>] <newbase>
> +
> +'git-rebase' --continue
> +
> +'git-rebase' --abort
>  
>  DESCRIPTION
>  -----------
> -git-rebase applies to <upstream> (or optionally to <newbase>) commits
> -from <branch> that do not appear in <upstream>. When <branch> is not
> -specified it defaults to the current branch (HEAD).
> +git-rebase replaces <branch> with a new branch of the same name having
> +a HEAD of <newbase>.  It then attempts to make a new commit for each
> +commit from the original <branch> that does not yet exist in this new
> +<branch>.

What about 'git-rebase --onto <newbase> <upstream> <branch>' three options
version?

-- 
Jakub Narebski
Warsaw, Poland
