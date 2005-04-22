From: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Subject: Re: Pulling linux-2.6.git with gitinit.sh and gitpull.sh fails
Date: Fri, 22 Apr 2005 15:54:04 +0100
Message-ID: <200504221554.04749.rhys@rhyshardwick.co.uk>
References: <200504221442.29488.rhys@rhyshardwick.co.uk> <1114181091.29271.27.camel@nosferatu.lan> <200504221543.43210.rhys@rhyshardwick.co.uk>
Reply-To: rhys@rhyshardwick.co.uk
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 22 16:51:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOzU3-0003iY-HZ
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 16:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVDVOyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 10:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVDVOyY
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 10:54:24 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:47778 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261955AbVDVOyH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 10:54:07 -0400
Received: from unknown (HELO mail.rhyshardwick.co.uk) (rhys?hardwick@81.103.65.153 with plain)
  by smtp004.mail.ukl.yahoo.com with SMTP; 22 Apr 2005 14:54:06 -0000
Received: from [192.168.1.40] (helo=metatron.rhyshardwick.co.uk)
	by mail.rhyshardwick.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1DOzXh-0003qh-AL
	for git@vger.kernel.org; Fri, 22 Apr 2005 15:54:05 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <200504221543.43210.rhys@rhyshardwick.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Friday 22 Apr 2005 15:43, Rhys Hardwick wrote:
> On Friday 22 Apr 2005 15:44, Martin Schlemmer wrote:
> > On Fri, 2005-04-22 at 15:30 +0100, Rhys Hardwick wrote:
> > > On Friday 22 Apr 2005 15:00, Martin Schlemmer wrote:
> > > > On Fri, 2005-04-22 at 14:50 +0100, Rhys Hardwick wrote:
> > > > > On Friday 22 Apr 2005 14:52, Martin Schlemmer wrote:
> > > > > > On Fri, 2005-04-22 at 14:42 +0100, Rhys Hardwick wrote:
> > > > > > > Hey there,
> > > > > > >
> > > > > > > I am trying to pull the latest repository of the linux-2.6 git
> > > > > > > from Linus' rsync mirror.
> > > > > > >
> > > > > > > Here is the shell:
> > > > > > >
> > > > > > > ===========
> > > > > > >
> > > > > > > rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh
> > > > > > > rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2
> > > > > > >.6 .git defaulting to local storage area
> > > > > > > gitpull.sh: unknown remote
> > > > > > > gitinit.sh: pull failed
> > > > > > > rhys@metatron:~/repo/linux-2.6.repo$ rm -r .git
> > > > > > > rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh
> > > > > > > www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
> > > > > > > defaulting to local storage area
> > > > > > > gitpull.sh: unknown remote
> > > > > > > gitinit.sh: pull failed
> > > > > > > rhys@metatron:~/repo/linux-2.6.repo$
> > > > > > >
> > > > > > > =============
> > > > > > >
> > > > > > > Any idea why this is not working?
> > > > > >
> > > > > > Try:
> > > > > >
> > > > > >  $ git init
> > > > > > rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6
> > > > > >.g it
> > > > >
> > > > > Exactly the same, sorry.....
> > > >
> > > > With latest git-pasky, after blowing the .git directory?  I am not
> > > > sure (and have not checked) that git will do the right thing if you
> > > > retry without clearing.
> > >
> > > Yes to all the above.  I pulled the latest today, and make && make
> > > install. Also, I have tried it with a .git in place, deleted, in the
> > > unpacked 2.6.11-r3 source, all of the above!
> > >
> > > >From what I can gather, it must happen in an empty directory, and that
> > > > is what
> > >
> > > the top two examples are.
> >
> > Really weird.  I tested it my side before doing my last reply.  Maybe
> > Petr will know.
>
> Hopefully!
>
> Thanks for the help anywho.....
>
> Rhys

I think I have some more information.  If you remove the -e from the origins 
file, and put the name at the start of the line, it suddenly works!!!

Cool,

Not sure what was going on there, but hey, Petr will work it out!

Rhys


