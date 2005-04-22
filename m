From: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Subject: Re: Pulling linux-2.6.git with gitinit.sh and gitpull.sh fails
Date: Fri, 22 Apr 2005 14:50:48 +0100
Message-ID: <200504221450.48196.rhys@rhyshardwick.co.uk>
References: <200504221442.29488.rhys@rhyshardwick.co.uk> <1114177940.29271.9.camel@nosferatu.lan>
Reply-To: rhys@rhyshardwick.co.uk
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 22 15:47:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOyUF-0000OM-1o
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 15:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVDVNu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 09:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVDVNu5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 09:50:57 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:55666 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261787AbVDVNut (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 09:50:49 -0400
Received: from unknown (HELO mail.rhyshardwick.co.uk) (rhys?hardwick@81.103.65.153 with plain)
  by smtp005.mail.ukl.yahoo.com with SMTP; 22 Apr 2005 13:50:48 -0000
Received: from [192.168.1.40] (helo=metatron.rhyshardwick.co.uk)
	by mail.rhyshardwick.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1DOyYS-0003fb-Mr
	for git@vger.kernel.org; Fri, 22 Apr 2005 14:50:48 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <1114177940.29271.9.camel@nosferatu.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Friday 22 Apr 2005 14:52, Martin Schlemmer wrote:
> On Fri, 2005-04-22 at 14:42 +0100, Rhys Hardwick wrote:
> > Hey there,
> >
> > I am trying to pull the latest repository of the linux-2.6 git from
> > Linus' rsync mirror.
> >
> > Here is the shell:
> >
> > ===========
> >
> > rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh
> > rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
> > defaulting to local storage area
> > gitpull.sh: unknown remote
> > gitinit.sh: pull failed
> > rhys@metatron:~/repo/linux-2.6.repo$ rm -r .git
> > rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh
> > www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
> > defaulting to local storage area
> > gitpull.sh: unknown remote
> > gitinit.sh: pull failed
> > rhys@metatron:~/repo/linux-2.6.repo$
> >
> > =============
> >
> > Any idea why this is not working?
>
> Try:
>
>  $ git init
> rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git

Exactly the same, sorry.....

Rhys


