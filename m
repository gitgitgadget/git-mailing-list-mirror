From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/3 v2] git-svn log: handle unreachable revisions like "svn log"
Date: Sat, 17 Nov 2007 13:47:38 -0800
Message-ID: <20071117214738.GB22835@soma>
References: <1194761435-7286-4-git-send-email-ddkilzer@kilzer.net> <1194850612-6907-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: David D Kilzer <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 22:48:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItVWA-00037S-3X
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 22:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbXKQVrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 16:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbXKQVrj
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 16:47:39 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33702 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbXKQVrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 16:47:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 784DA7DC0FE;
	Sat, 17 Nov 2007 13:47:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1194850612-6907-1-git-send-email-ddkilzer@kilzer.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65314>

David D Kilzer <ddkilzer@kilzer.net> wrote:
> When unreachable revisions are given to "svn log", it displays all commit
> logs in the given range that exist in the current tree.  (If no commit
> logs are found in the current tree, it simply prints a single commit log
> separator.)  This patch makes "git-svn log" behave the same way.
> 
> Ten tests added to t/t9116-git-svn-log.sh.
> 
> Signed-off-by: David D Kilzer <ddkilzer@kilzer.net>
> ---
> 
> No changes were needed to parts 1 and 2 of this series, so I am not
> reposting them.
> 
> Updated this patch based on feedback from Benoit Sigoure and Eric Wong:
> 
> - Commented find_rev_before() and find_rev_after().
> - Changed commit_log_separator() into a constant.
> - Made return statement safer by adding another check in git_svn_log_cmd().
> - Changed echo statement to printf in t/t9116-git-svn-log.sh.
> 
> All tests pass on maint branch.

Thanks,

Acked and pushed out to http://git.bogomips.org/git-svn.git

David D Kilzer (3):
      git-svn log: fix ascending revision ranges
      git-svn log: include commit log for the smallest revision in a range
      git-svn log: handle unreachable revisions like "svn log"

David Reiss (1):
      git-svn: Fix a typo and add a comma in an error message in git-svn

Eric Wong (1):
      git-svn: add tests for command-line usage of init and clone commands

Konstantin V. Arkhipov (1):
      git-svn's dcommit must use subversion's config

-- 
Eric Wong
