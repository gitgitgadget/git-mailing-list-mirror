From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Mon, 15 Aug 2005 14:05:14 +1200
Message-ID: <46a038f905081419057cc6b5cd@mail.gmail.com>
References: <46a038f905081417241f9598cc@mail.gmail.com>
	 <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 04:06:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4ULv-0002zb-St
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 04:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbVHOCFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 22:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbVHOCFX
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 22:05:23 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:25651 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932632AbVHOCFW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2005 22:05:22 -0400
Received: by rproxy.gmail.com with SMTP id i8so713673rne
        for <git@vger.kernel.org>; Sun, 14 Aug 2005 19:05:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KExUUUzm4Z62+RD+42VS9/QMoHq1jEi4Kz0/1lTcDmMrI4Bk0QxBP5q0Nm01RTA05fOBoXIu+z45brZglUgEgA8lkAHI9vSfJYYacaux/7uEwROkKMSUxoRSTh0NakfUZgRbMdkMd8mLRPVe9Jd8lqn8A/puHSOQ3tdXG0aZQv8=
Received: by 10.38.181.31 with SMTP id d31mr1577658rnf;
        Sun, 14 Aug 2005 19:05:14 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Sun, 14 Aug 2005 19:05:14 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Just do
> 
>         git checkout branch-name
> 
> to switch between them.

thanks! I was doing cg-branch-chg branch-name and it wasn't working.

> So in a cvsimport, you'll never see a merge back to the head, even if one
> technically took place.

There may be some surprises in here! gitk --all shows at least one
branch opening and merging back into origin, and it has figured it out
correctly: that was a feature branch where people worked on for a
while and merged back. I haven't had time to explore it more, but it
looks promising.

Except for the keyword expansion. surely there's a way to tell cvsps
to not do it. Why would we ever want it?

> > And I am confused about the difference between heads and branches.
> 
> Confusion of naming.
> 
> branches and heads are the same thing in git. 

right. There are two separate directories in .git for them, so I was
misled by that. Should I assume git is safe from name clashes or is it
up to porcelain to deal with such minutiae?

> They are "proper branches", and sorry about the confusion. 

Don't worry! Means I'll have to wake up and pay attention from now on...

thanks,


martin
