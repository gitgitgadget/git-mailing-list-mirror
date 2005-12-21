From: Peter Baumann <peter.baumann@gmail.com>
Subject: Re: Am I doing something wrong?
Date: Wed, 21 Dec 2005 19:53:00 +0100
Message-ID: <802d21790512211053q60e05301l@mail.gmail.com>
References: <86k6dyxuke.fsf@blue.stonehenge.com>
	 <7v3bkmcp83.fsf@assigned-by-dhcp.cox.net>
	 <864q52xrm6.fsf@blue.stonehenge.com>
	 <7vmziub9yw.fsf@assigned-by-dhcp.cox.net>
	 <86zmmuwbzh.fsf@blue.stonehenge.com>
	 <7vhd92b90w.fsf@assigned-by-dhcp.cox.net>
	 <802d21790512211037q4ffc5816u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 19:56:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep95O-00054Z-Ip
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 19:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVLUSxI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 13:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVLUSxI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 13:53:08 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:55366 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751181AbVLUSxG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 13:53:06 -0500
Received: by wproxy.gmail.com with SMTP id 68so187591wra
        for <git@vger.kernel.org>; Wed, 21 Dec 2005 10:53:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hWbRGtsD5XiA9ZTFXuq0fBn5kdthMp3xM6Rp4G3WB4i7DbLaSOXU0h1eitrtCBlWaniGOcPb+EnvAhYKO67AX2/TtvYYk2TfIA6i0yBg87dTvBAK/LK4JjTh5AdzcOFR8GPkUtPEW4StQV5AvdZF/g1Pr9uJfP6tLf1sG4KI6kI=
Received: by 10.65.153.4 with SMTP id f4mr659522qbo;
        Wed, 21 Dec 2005 10:53:01 -0800 (PST)
Received: by 10.64.21.6 with HTTP; Wed, 21 Dec 2005 10:53:00 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <802d21790512211037q4ffc5816u@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13892>

2005/12/21, Peter Baumann <peter.baumann@gmail.com>:
> 2005/12/21, Junio C Hamano <junkio@cox.net>:
> > merlyn@stonehenge.com (Randal L. Schwartz) writes:
> >
> > >>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> > >
> > > Junio> I said I tried cloning from scratch and fetching into an old one
> > > Junio> over HTTP and succeeded, did I not?  So it does not seem to be
> > > Junio> the case either.
> > >
> > > Cloning from scratch probably worked differently than starting
> > > from wherever I was.
> >
> > Yup, that's why I tried both.
> >
> > > ... However, I'm very clear on the symptoms... trying to start
> > > from wherever I had last updated, to update to the current release,
> > > failed when sucking from HTTP, but worked when sucking from GIT.
> >
> > I do not doubt you got a failure.  I just couldn't reproduce it
> > easily by fetching into a copy of a stale repository.  Earlier I
> > was suspecting mirroring lags (my successful trial was done
> > within the last hour) but I do not think that is the case
> > because your failure was also way after the mirroring should
> > have happened.
> >
> > Will dig a bit more when able.
> >
>
> Sorry , but I have seen this too. I deleted my git directory and
> cloned it again and it worked, but the original pull didn't work.
> (Same error as above.) I'll look if I can find a backup of my old git
> directory and look if there is the same error for you to reproduce. If
> I can find something, I'll get back to you.
>
> Peter Baumann
>

Ok. I digged a bit around and found the backup of my old git version repository.
xp:/var/tmp/git cat .git/HEAD
112d0bafd620c0e0f10614a3ba021d4de4fae331

xp:/var/tmp/git git --version
git version 0.99.9i

But I wouldn't take this for serious if I were you. If the process for
building the debian package isnt't able to set the exact version the
above is definitly not true. Can't remember what version it was :-(

xp:/var/tmp/git git pull
Fetching refs/heads/master from
http://www.kernel.org/pub/scm/git/git.git using http
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
Getting pack list for http://www.kernel.org/pub/scm/git/git.git/
error: Unable to find c2f3bf071ee90b01f2d629921bb04c4f798f02fa under
http://www.kernel.org/pub/scm/git/git.git/

Cannot obtain needed object c2f3bf071ee90b01f2d629921bb04c4f798f02fa
while processing commit 0000000000000000000000000000000000000000.


Peter
