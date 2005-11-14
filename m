From: Andreas Ericsson <ae@op5.se>
Subject: Re: Simple questions on GIT usage.
Date: Mon, 14 Nov 2005 17:56:10 +0100
Message-ID: <4378C1AA.9090209@op5.se>
References: <cda58cb80511140746w2f691fb8y@mail.gmail.com>	<4378B687.3060701@op5.se> <86iruvxk1i.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:58:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebhct-0005Hs-I8
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVKNQ4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVKNQ4M
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:56:12 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:38851 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751195AbVKNQ4L
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 11:56:11 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 5225E6BD01; Mon, 14 Nov 2005 17:56:10 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86iruvxk1i.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11827>

Randal L. Schwartz wrote:
>>>>>>"Andreas" == Andreas Ericsson <ae@op5.se> writes:
> 
> 
> Andreas> man git-branch
> 
> Andreas> It will tell you about its -d and -D options.
> 
> It will?  My manpage has no -d or -D option for git-branch.
> 

Ah. It's the help output that has them. I've submitted a patch to add 
them to the man-page though, so it should show up soonish.

> And I've been looking for something like that too.  If I want to
> abandon a what-if branch, how do I make sure that the branch and all
> objects are deleted?
> 

git branch -D branchname
git prune

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
