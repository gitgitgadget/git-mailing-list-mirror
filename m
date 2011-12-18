From: DeMarcus <demarcus@hotmail.com>
Subject: Re: How can I do an automatic stash when doing a checkout?
Date: Sun, 18 Dec 2011 16:10:41 +0100
Message-ID: <jckvpk$i8v$1@dough.gmane.org>
References: <jcki8u$oip$1@dough.gmane.org> <84ty4ycdcc.fsf@cenderis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 16:11:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcIOa-0000g3-Gr
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 16:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab1LRPLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 10:11:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:49692 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab1LRPK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 10:10:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RcIO9-0000U0-SR
	for git@vger.kernel.org; Sun, 18 Dec 2011 16:10:57 +0100
Received: from c83-251-142-66.bredband.comhem.se ([83.251.142.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Dec 2011 16:10:57 +0100
Received: from demarcus by c83-251-142-66.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Dec 2011 16:10:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c83-251-142-66.bredband.comhem.se
User-Agent: Mozilla/5.0 (Windows NT 6.0; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <84ty4ycdcc.fsf@cenderis.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187423>

>> This is not how it works with git, where when I want to change branch
>> I have to do a git checkout. However, that leaves all the modified and
>> untracked files in the directory of the branch I switched to. This is
>> seldom the behavior I want.
>>
>> With the git stash command I can clean the directory the way I want
>> but the stash command is not connected to a particular branch.
>>
>> Is there a way to have git checkout do an automatic stash when doing a
>> checkout to another branch, and then do an automatic git stash apply
>> with the correct stash when changing back to the previous branch
>> again?
>
> You probably don't want to use stash. Just commit whatever partial work
> you've done.
>

It feels strange doing a commit of partial work. Some of the files may 
not even be supposed to be checked in.

> You could also just checkout different branches in different
> directories. Nothing wrong with doing that in git.
>

Ok thanks, that would give me the same behavior as I have today.

However, I can see some benefits with have everything in the same 
directory as git allows compared to other VCSs. And since the stashing 
feature is already there in git, it would be nice if the git checkout 
with some flag could use stashing automatically.
