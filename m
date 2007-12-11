From: Clifford Heath <clifford.heath@gmail.com>
Subject: Re: "remote end hung up unexpectedly"
Date: Tue, 11 Dec 2007 18:15:56 +1100
Message-ID: <A24153E2-0C85-44FB-B03E-18663A854194@gmail.com>
References: <CE1FB037-26E3-475E-9F9D-AC3874987B9C@gmail.com> <475D3AF9.60402@op5.se> <5F13DCA7-5072-4D76-89A7-7F05A5928FA2@gmail.com> <475E3415.3030208@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 11 08:16:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1zMN-0000rZ-SK
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 08:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbXLKHQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 02:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbXLKHQ3
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 02:16:29 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:2276 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbXLKHQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 02:16:28 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3834435wah
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 23:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        bh=gD56vfe6MzUid856ix28hd6KFU8URvzQnZQEWHuNgfc=;
        b=l+6gd0gyb44gKPQJmf3jLQpydylqNWsppgbsKWCrc7zfSQWCqlirZ7yfuesXrCIzQjwFsTA19iJPtwxcrMOzQGhwOx1JiLh7ulA0lItXiqbUwFFPBQKvP1eFPwYRuEjGdOoG5jFSrRqMDHC2qfZIMBYzWTmo+oZXbrKOINS8F6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=CSeO4f4ueAd3LDoPds1B4sEnHVvcUPYifI2tGzRP7CgTar35BnxMOWH9SW6nVRAgGy3S3YeOnq8sQTigYatF3jHpKSfEhmtQNeumT9sDa7uPp2a/Yg5siHTOrLi1iBj0sGZd2xaBHtl1X9oWzNQwqwpsJcYe7wedISfiVOibZBw=
Received: by 10.114.204.7 with SMTP id b7mr1271737wag.1197357387364;
        Mon, 10 Dec 2007 23:16:27 -0800 (PST)
Received: from ?10.0.0.1? ( [122.107.155.136])
        by mx.google.com with ESMTPS id n32sm7752813wag.2007.12.10.23.16.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Dec 2007 23:16:25 -0800 (PST)
In-Reply-To: <475E3415.3030208@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67816>

On 11/12/2007, at 5:54 PM, Andreas Ericsson wrote:
> I'm bringing this back on the list. It's very uncharitable of you  
> to not
> do so yourself,

My humble apologies - I just hit reply. I've previously only encountered
majordomo configurations where the reply goes to the list (including
when I operated majordomo for ten years), so I made a mistake.

>>> Not really. You can do "git rebase --onto origin/master master".  
>>> However,
>>> since you merged origin/master earlier, a rebase will only tell  
>>> you that
>>> you're up-to-date.
>> I don't think that anything I've done has affected the remote  
>> repository.
>
> It hasn't. The only way you can update the remote repository, short of
> editing it manually, is to use "git push". That's not strictly  
> true, but
> for the sake of this argument, it will suffice.

Thanks, that's good confirmation.

>> Most of the instructions and manpages I've read show how to do things
>> to local repositories and push changes back. Here's what I most  
>> recently
>> tried, perhaps you can see where I went wrong. I've changed the  
>> project
>> name for PROJECT, and the branch name with BRANCH
>> git clone git+ssh://cjheath@repo.or.cz/srv/git/PROJECT.git
>> cd PROJECT
>> git checkout --track -b BRANCH origin/BRANCH
>> git rebase origin/master
>> At this point the local branch seems to have the content I want,  
>> so I tried
>> to push the changes back in:
>
> You mean, "at this point BRANCH seems to have the content I want"?

No, I mean that the recent changes have been pulled from origin/master
and my tree looks like what I want the remote origin/BRANCH to look  
like.
Though if I pushed, I don't know that its revision history would  
necessarily
be in the preferred order.

>> git push
>> Which replied:
>> error: remote 'refs/heads/BRANCH' is not a strict subset of local  
>> ref 'refs/heads/BRANCH'. maybe you are not up-to-date and need to  
>> pull first?
>> error: failed to push to 'git+ssh://cjheath@repo.or.cz/srv/git/ 
>> PROJECT.git'
>
> Yes. What you did caused history to be rewritten. Push is fast- 
> forward[1]
> only by default, to prevent published history from being modified,  
> so when
> you moved one line of development onto another you effectively  
> changed its
> ancestry.

Ok, I think I follow that. I can see I need to spend more time  
reading the
man pages.  Thanks for your help...

Clifford Heath.

> If you do
>
> git checkout BRANCH
> git reset --hard origin/BRANCH
> git merge origin/master
> git push
>
> you will achieve the desired end-result. If you really, really want  
> a linear
> history, you can do
>
> git push -f origin BRANCH
>
> but beware that this will cause errors for everyone fetching from  
> you, and
> for yourself if you fetch into multiple local clones of the same  
> remote.
>
> I suggest you sit down and really read through the git rebase man- 
> page to
> understand what it does and the precautions one must take when  
> rewriting
> history like that.
>
>
> [1]fast-forward:
>    A fast-forward is a special type of merge where you have a
>    revision and you are "merging" another branch's changes that
>    happen to be a descendant of what you have. In such cases,
>    you do not make a new merge commit but instead just update
>    to his revision. This will happen frequently on a tracking
>    of a remote repository.
>
> -- 
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
