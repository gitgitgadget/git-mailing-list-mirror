From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: Git 1.3.2 on Solaris
Date: Fri, 26 May 2006 05:30:49 +0200
Message-ID: <f3d7535d0605252030p55f83db9w4bdf436934badb19@mail.gmail.com>
References: <Pine.LNX.4.64.0605170919290.10823@g5.osdl.org>
	 <6471.1147883724@lotus.CS.Berkeley.EDU>
	 <f3d7535d0605222020j2d581bd9j602752659a4b3ac2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri May 26 05:30:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjT2L-0000MS-7P
	for gcvg-git@gmane.org; Fri, 26 May 2006 05:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWEZDau (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 23:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWEZDau
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 23:30:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:38191 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030221AbWEZDau convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 23:30:50 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1959194wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 20:30:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R+b3Yln/LglL7dAwNXPdrUZSPOoJzzF8meunTQxJh0bSdHoWJK0bbhdx0XxUwDJDXHP/qkFiMiF2Bj6xosoUyTMOkzWiQ32I2F61wGFgJ1d/lKi4fm3OSlKjPOgVOapx7TqYOMa3zwHgZ7zdQ8a/cAzq/ynHtXhsbY9EOLIjiY8=
Received: by 10.65.61.20 with SMTP id o20mr56572qbk;
        Thu, 25 May 2006 20:30:49 -0700 (PDT)
Received: by 10.64.253.10 with HTTP; Thu, 25 May 2006 20:30:49 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <f3d7535d0605222020j2d581bd9j602752659a4b3ac2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20788>

Hi list,

2006/5/23, Stefan Pfetzing <stefan.pfetzing@gmail.com>:

> 2006/5/17, Jason Riedy <ejr@eecs.berkeley.edu>:
> > And pkgsrc itself works just fine without the silly g prefix,
> > or at least does for me as a mere user (and as well as it does
> > work).  But if you intend on adding the package upstream, it'll
> > need something to cope with the g.  And pkgsrc handles local
> > patches...
>
> Well I had some problems on NetBSD without the g prefix for the
> gnu coreutils - since then I always used that prefix.

...

Well finally - after some patching around access() and after figuring
out "merge" was broken in pkgsrc (and still is - I had to open a
problem report) - I got all tests to complete successfully.

bye

Stefan

P.S.: merge from devel/rcs uses /bin/diff3 on solaris which somehow
breaks merge.
-- 
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
