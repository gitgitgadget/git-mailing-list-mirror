From: Alp Toker <alp@atoker.com>
Subject: Re: [PATCH] Fix some doubled word typos
Date: Mon, 10 Jul 2006 01:32:31 +0100
Message-ID: <44B1A01F.5090408@atoker.com>
References: <11524377844177-git-send-email-alp@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 02:32:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzjha-0005b1-4u
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 02:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161282AbWGJAci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 20:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161283AbWGJAci
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 20:32:38 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:62736 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1161282AbWGJAch (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 20:32:37 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by ndesk.org (Postfix) with ESMTP id AFE298AAF6;
	Mon, 10 Jul 2006 01:32:31 +0100 (BST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <11524377844177-git-send-email-alp@atoker.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23578>

Alp Toker wrote:
> Signed-off-by: Alp Toker <alp@atoker.com>
> ---
>  Documentation/git-svn.txt |    2 +-
>  Documentation/urls.txt    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

My patch was made against the 'next' branch, where the file had recently 
been moved to Documentation/git-svn.txt, but it was applied to the 
'master' branch where the file still exists at 
contrib/git-svn/git-svn.txt as it has not yet been moved.

As a result, it seems that only the modification to 
Documentation/urls.txt in this patch made it into the repository, with 
the fix to Documentation/git-svn.txt having been silently omitted.

By the time the commit was merged from 'master' to 'next', it had 
permanently lost the modification to git-svn.txt, and even though the 
commit message claims to "Fix some doubled word typos" it only fixes one.

Could this situation have been avoided if the patch had mentioned that 
it was against the 'next' branch? Should/does git warn the user if a 
patch modifies files that don't exist? Would rename tracking have helped 
this patch to apply properly?
