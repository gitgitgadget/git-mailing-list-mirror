From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git User's Survey 2008 partial summary, part 4 - how do we use
 Git
Date: Sun, 07 Sep 2008 10:31:01 +0200
Message-ID: <48C39145.9020709@op5.se>
References: <200809031607.19722.jnareb@gmail.com> <200809070017.09463.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 10:32:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcFhE-0006xd-6O
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 10:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbYIGIbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 04:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbYIGIbV
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 04:31:21 -0400
Received: from mail.op5.se ([193.201.96.20]:57331 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbYIGIbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 04:31:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2E4F21B800B5;
	Sun,  7 Sep 2008 10:37:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d-CO190gLoZj; Sun,  7 Sep 2008 10:37:10 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 417341B8007E;
	Sun,  7 Sep 2008 10:37:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <200809070017.09463.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95127>

Jakub Narebski wrote:
> 
> Analysis: strangely "git add + git commit" is slightly more used than
> "git commit -a"; I would suspect that "git commit -a" would dominate a
> bit over other forms of committing.

I believe people have finally gotten to grasp with the index. Besides,
those answers are probably a bit skewed, as people that use git as just
a faster and better cvs/svn aren't likely to be those who answer the
survey.

>  What is for me more suprising is
> that "git commit <file>..." has such large presence in often used
> commands; I would think that it should be mostly used as 'sometimes'
> command.
> 

I know myself and most others where I work use it as a 'fixup' command.
One commit is done, the second is being staged (git add or git add -i),
while testing reveals some silly bug in one of the files from the last
commit. Assuming that file isn't touched again, it's easy to fix up
using "git commit --amend <file>", as that automatically sets up a new
index so that the staged changes remain staged.

The alternative would be to do a mixed reset, git add <file>, git commit
--amend. Not so sexy.

> 
> Top 10 rarely used commands
> 
> ===================================
> Command + options      | rarely [%]
> -----------------------------------
> git revert             | 31% (454)
> git pull <URL> <ref>   | 22% (348)
> git blame              | 21% (328)
> git fetch [<options>]  | 20% (313)
> git rebase             | 20% (291)
> git remote             | 20% (289)
> git merge              | 18% (286)
> git apply              | 18% (284)
> git pull --rebase      | 18% (283)
> 
> Analysis: "git pull <URL> <ref>", direct pull without using
> remote-tracking branches, is quite popular among rarely used
> commands.  Strange that "git pull ---rebase" is among rarely
> used; I would think it is question of workflow... but perhaps
> rarely encountered workflow.
> 

Perhaps many who use it don't know that they are. The "git sync"
alias is much in use where I work. It's basically just a
"git pull --rebase && git push". As it was suggested on the mailing
list and also listed in some tutorial somewhere (don't know where),
I can imagine quite a lot of people using it without realising it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
