From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: oprofile on svn import
Date: Tue, 13 Jun 2006 22:39:32 -0400
Message-ID: <9e4733910606131939h35b2278bvaa296459ea061621@mail.gmail.com>
References: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com>
	 <20060614020108.GB12083@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 04:39:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqLIB-0001eX-VM
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 04:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWFNCjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 22:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWFNCjd
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 22:39:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:59350 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964942AbWFNCjc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 22:39:32 -0400
Received: by nz-out-0102.google.com with SMTP id s18so39755nze
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 19:39:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qh2FOabm5wyh416fh8fxcONaQs4qF6qnCoOHH0P3GrwT1cihdEwX6EUzGRmnWCX0ReLqxNEOuMPeEkGdRr87o1Z9yxiW0gxXn6mQNXQf5k6B9XXQDMVU/SACf96qZynx3kS882Da4EwtoIiBsSWtM1k2GM/5zXXYy9Vrehili3E=
Received: by 10.36.33.3 with SMTP id g3mr211741nzg;
        Tue, 13 Jun 2006 19:39:32 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Tue, 13 Jun 2006 19:39:32 -0700 (PDT)
To: "Eric Wong" <normalperson@yhbt.net>
In-Reply-To: <20060614020108.GB12083@hand.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21824>

On 6/13/06, Eric Wong <normalperson@yhbt.net> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > I'm going back to cvsimport tomorrow. My svn import that had been
> > running for five days got killed this morning when the city decided to
> > move the telephone pole that provides my electricty.
> >
> > Some oprofile data, this doesn't make a lot of sense to me. Why is it
> > in libcypto so much?
>
> The sha1 calculation is done in libcrypto, afaik.

That make sense, but it's eating up 14% of my CPU in a long sample.

> Anybody want to see how my latest patches to git-svn (and using SVN perl
> libraries) stacks up against the mozilla repo?  Speedwise, I don't
> expect git-svn to be too different than git-svnimport, but it should use
> much less memory (I'll probably port the hacks to git-svnimport, too).

Can svnimport be rewritten to avoid calling fork? If I am reading the
oprofiles correctly that fork is very expensive especially when the
svnimport task grows to 600MB.

I have an import running but post your code when it is ready and I can
try it on the next run. They always seem to fail so there will
probably be another run.

> I'll see about freeing up one of my machines to test the mozilla repo.
> Unfortunately, all of my hardware is a few years old and not extremely
> fast.
>
> --
> Eric Wong
>


-- 
Jon Smirl
jonsmirl@gmail.com
