From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git drawbacks?
Date: Tue, 10 Nov 2009 17:04:28 +0300
Message-ID: <20091110140428.GL27126@dpotapov.dyndns.org>
References: <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org> <loom.20091109T170054-451@post.gmane.org> <28c656e20911091047r353e9451hd856b99541fbd5ff@mail.gmail.com> <20091109210631.GJ27126@dpotapov.dyndns.org> <loom.20091110T093334-810@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 15:05:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7rKn-0004FJ-Fm
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 15:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbZKJOE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 09:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbZKJOE0
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 09:04:26 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:33790 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZKJOEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 09:04:25 -0500
Received: by fg-out-1718.google.com with SMTP id d23so1161658fga.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 06:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NBYLTDsbpjao4XJxxPpJWJLyiFMom6y2fLDVMgPcRNc=;
        b=MXKrXBMoeHQxPhtAsfGV1sNV0jH4FW/WVgm5Lc3XjDBjHh8bsoQGUjFWQW2M7IxM3N
         lQmAzENz/JZLMtMpQXThGqtyv+MAr7vezScQ/I5Pln6A3xmPlNndYFlsNgRi+QsJCfqL
         Wm//p7T4iv5xEdyS6lGln6QOj3zovJdpkPPeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P9/+zVpAbUdCr3Md8ehBCAmGlc0rFw0arIlF0MZVzJkaqpqYIATpAsyR2QqDKLzccS
         Ue1hqdKvXX0YmU9a34KgJFfxvb4k5jqROUBKYfEjrwV3UEybw1AUE5yJGn+twuKfhCJx
         GHoAsjAy1L8JDcKrVF8RdlC0BskeietSYnEBs=
Received: by 10.86.106.21 with SMTP id e21mr128034fgc.67.1257861870561;
        Tue, 10 Nov 2009 06:04:30 -0800 (PST)
Received: from localhost (ppp85-140-126-241.pppoe.mtu-net.ru [85.140.126.241])
        by mx.google.com with ESMTPS id 3sm90531fge.19.2009.11.10.06.04.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 06:04:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20091110T093334-810@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132569>

On Tue, Nov 10, 2009 at 08:51:53AM +0000, Dmitry Smirnov wrote:
> Dmitry Potapov <dpotapov <at> gmail.com> writes:
> 
> > With many other VCS, a typical policy is that you do not commit your
> > changes unless you have finished and tested them. But it means that
> > your changes are not committed and stored only in the work tree for
> > a long time. Moreover, when you eventually decide that they are good
> > enough to commit, you will produce a huge patch, which will be difficult
> > to review or to bisect history later.
> 
> oh, yes. but this is just a policy. You can make your changes on your 
> branch and commit them (for example, for review). Later someone just 
> need to integrate it on original branch. The same as with Git, 
> isn't it? The problem is just a price to branch.

With some VCSes, it is not just the cost of branch, but it is also name
pollution that happens when many branches created. But even the cost of
branch creation alone may be high enough to make creating small feature
branches impractical. You can try to force that on developers, but they
will be frustrated with that pretty soon... And then if you really want
to have good and clean history, you need more than just a branch. You
should be able to amend your previous commits while you work on some
feature. With Git, it is trivial, you just run 'git rebase -i' and may
edit some previous commits, correct comments, squash fix-ups, etc...
How can you model that? By creating another branch and moving patches
to it by hands... Well, it is not very productive time spending, and
the cost of branch becomes even more prominent.

> BTW, once I started to talk about review, we can see that most 
> "benefits" of DVCS go away... Just because you still need some 
> central storage to save the record of this review that should 
> be available for SQA later...

I do not see how any benefit go away because of having some central
storage. Most benefits are not due to that you do not have it, but due
to cheap branching, easy mirroring, and flexibility in what you want to
store and where...

>  
> > So, you can always commit your changes as your progress to your goal and
> > review amend them later before publishing. This means that you can have
> > as many work-in-progress branches as you wish, and you do not need a
> > separate work tree for each of them -- everything can be stored in the
> > repository, and you can go to another computer, issue 'git fetch' and
> > continue your work at the exact point where you left it. So, it is very
> > flexible.
> 
> As for me, I would not to have more than 4-5 such deferred changes in the same 
> repository. Otherwise, I will be entangled finally :-)

A quick look at "What's cooking in git.git" that Junio posted a few days
ago reveals that there are at least 43 branches that are cooking now and
the total number of branches that have been merged to 'master' over all
Git history is 3290. And Git is not the largest project out there...


Dmitry
