From: Andreas Ericsson <ae@op5.se>
Subject: Re: n-heads and patch dependency chains
Date: Tue, 04 Apr 2006 13:47:39 +0200
Message-ID: <44325CDB.2000101@op5.se>
References: <4430D352.4010707@vilain.net> <7vsloucuxk.fsf@assigned-by-dhcp.cox.net> <4431B60E.3030008@vilain.net> <44323C52.2030803@op5.se> <e0tjpk$ktu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 13:48:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQk0t-0006Q1-QD
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 13:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWDDLrl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 07:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWDDLrl
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 07:47:41 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:34506 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932179AbWDDLrk
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 07:47:40 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id A81336BCBC; Tue,  4 Apr 2006 13:47:39 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e0tjpk$ktu$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18388>

Jakub Narebski wrote:
> Andreas Ericsson wrote:
> 
> 
>>Wouldn't "git commit -M -b topic", for committing to a different branch
>>than what is checked out (-b) and also to the checked out branch (-M)
>>have the same beneficial effects, but without the complexity of hydras
>>and patch dependency theory? It would only remove the cherry-pick stage
>>though, but perhaps it's good enough. Although when I think about it, -b
>><branch> for committing to another branch and -B <branch> for doing the
>>above probably makes more sense.
> 
> 
> Do you mean that you commit current state to the checked out (working)
> branch, and commit *changes* (i.e. apply patch) to a different branch?
> 

No, I mean that this would commit both to the testing branch (being the 
result of several merged topic-branches) and to the topic-branch merged 
in. Commit as in regular commit, with a commit-message and a patch. The 
resulting repository would be the exact same as if the change was 
committed only to the topic-branch and then cherry-picked on to the 
testing-branch.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
