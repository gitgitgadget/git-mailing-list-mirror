From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: Lump commit HOWTO?
Date: Fri, 13 Jul 2007 08:43:15 -0500
Message-ID: <625fc13d0707130643v1fb739bejb894648dcf16bd3@mail.gmail.com>
References: <625fc13d0707121821l70e2d6aaw555c79b5d700585f@mail.gmail.com>
	 <20070713045447.GA2430@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 15:43:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9LQy-0004K3-3D
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 15:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657AbXGMNnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 09:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932943AbXGMNnT
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 09:43:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:44332 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932864AbXGMNnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 09:43:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so566185ugf
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 06:43:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ol5LFQefAnaOcJqIhUAyLtxhEa7f8CWMHJeDQzyHfk075vGQByWEZuimEjj5OhDDNQj+uYHKCXAXtb8nKPvRtNt635ev4YK6RkYHPMyRTvKCrs2yHrVlSfa7BbYeGGds/3nkReagZcuGMs7HBcZYey3fSDCWRbPbqhOs1jbFOzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iZa4iLLlNFMG9CgmrmC4Nxz1McwZNXi9R6XDacd0xMec/Qc7Sq+zGaYHjl/hLpNwR9g/y1ksFH9dy7rlhq/6u4CVmBikkM4WBkdFFjZX1TMD3EuH4CVYXi5XA57BTMd1N3M2b2g9WAI2Oi7lyYLXxXfGm9I4XJ1w/BQSHTAol9s=
Received: by 10.82.116.15 with SMTP id o15mr1971802buc.1184334195646;
        Fri, 13 Jul 2007 06:43:15 -0700 (PDT)
Received: by 10.82.114.16 with HTTP; Fri, 13 Jul 2007 06:43:15 -0700 (PDT)
In-Reply-To: <20070713045447.GA2430@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52393>

On 7/12/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> Josh Boyer, Fri, Jul 13, 2007 03:21:17 +0200:
> > Hi All,
> >
> > I have a specific workflow in mind that I'm not entirely sure how to
> > accomplish with git.  What I'd like to do is track a project in a
> > local branch, and do commits of my own there as well.  Then when I'm
> > ready to submit the work, I want to take all the incremental commits
> > and lump them into a single new commit and push that out as a patch or
> > into a branch for people to pull from.
>
> See git merge --squash. It is exactly that.

Hm, OK.  I'll have to play with that.

> Also git-rebase --interactive and git cherry-pick -n can help you to
> get the same.

Gah... I totally missed git rebase.  Looks massively useful.  Thanks!

josh
