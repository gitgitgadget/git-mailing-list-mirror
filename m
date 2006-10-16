From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 01:55:10 +0200
Message-ID: <200610170155.10536.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 01:55:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZcIN-0005fz-AZ
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 01:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422956AbWJPXys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 19:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422954AbWJPXys
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 19:54:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:10047 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422953AbWJPXyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 19:54:46 -0400
Received: by ug-out-1314.google.com with SMTP id o38so889628ugd
        for <git@vger.kernel.org>; Mon, 16 Oct 2006 16:54:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l1cb2RPaED5abw0rDIpAPM47vm/wYktK0HS2/ncKnVXebayreoIuZ2Hysp0II6q3ZTXba2TBMJO7Lep+ptw7UA+c89RCw6qyRPqfpvINC+3ev5qGhNxHBS2hE733+vZ0OQc8JBLM12J1E7fQ7xwNGVXUHddZbVUyHlF9TTaDXD4=
Received: by 10.66.244.10 with SMTP id r10mr9009139ugh;
        Mon, 16 Oct 2006 16:54:44 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id y1sm1482657uge.2006.10.16.16.54.44;
        Mon, 16 Oct 2006 16:54:44 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29000>

Linus Torvalds wrote:
>>> About "checkouts", i.e. working directories with repository elsewhere:
>>> you can use GIT_DIR environmental variable or "git --git-dir" option,
>>> or symlinks, and if Nguyen Thai Ngoc D proposal to have .gitdir/.git
>>> "symref"-like file to point to repository passes, we can use that.
>> 
>> It sounds like the .gitdir/.git proposal would give Git "checkouts", by
>> our meaning of the term.
> 
> Well, in the git world, it's really just one shared repository that has 
> separate branch-namespaces, and separate working trees (aka "checkouts"). 
> So yes, it probably matches what bazaar would call a checkout.
> 
> Almost nobody seems to actually use it that way in git - it's mostly more 
> efficient to just have five different branches in the same working tree, 
> and switch between them. When you switch between branches in git, git only 
> rewrites the part of your working tree that actually changed, so switching 
> is extremely efficient even with a large repo. 

Unless you have branch(es) with totally different contents, like git.git
'todo' branch.

> So there is seldom any real need or reason to actually have multiple 
> checkouts. But it certainly _works_.

But without .git being either symlink, or .git/.gitdir "symref"-link,
you have to remember what to ser GIT_DIR to, or parameter for --git-dir
option.

I'd like to mention once again that in Git branches and tags have
totally separate namespace than repository namespace.
-- 
Jakub Narebski
Poland
