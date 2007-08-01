From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: MinGW build environment for Git
Date: Wed, 1 Aug 2007 15:18:41 -0700
Message-ID: <a1bbc6950708011518n63968dc0see8a022d2934cba8@mail.gmail.com>
References: <a1bbc6950707291614w392bf3a9t5d0d9e50bfcb0f36@mail.gmail.com>
	 <46B016FC.4050005@trolltech.com>
	 <a1bbc6950708010208v15071005w3bcc471bef172fcc@mail.gmail.com>
	 <Pine.LNX.4.64.0708011143180.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:18:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMWl-0002Z5-3z
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbXHAWSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbXHAWSn
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:18:43 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:28919 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbXHAWSm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:18:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so258254rvb
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 15:18:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QPhmJVWXa1XOEOPm5pd13iy+4BWvKQXtFvfSPrcYKbssKEjZYRQCTi1b6CTipmZrEJi4On5DLZoelqvoOUO4NE52GzQpwgrccpCBE0/iqR0GrtaE0ZRm7zoHxAIYHlMGUcnNKo2veRyBEJE4YsD7k7ZIV5yRe0EC2UZmL7XffHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OLP0mj9/+eSt70JS89eM1D0LzVaYXzyO3hp8xW84lofHAdZRVCP0Fzjgb6pyHeLinEQHRw1Si5B8/kU470U+91t+tul81UTGHAzznGaxlcsbczQLfswSrOJPJrQwqKKXJVjlGgR2z8LaAg64vwKFKbdoSV0jjEZf0YJdGBiXWPU=
Received: by 10.141.108.21 with SMTP id k21mr418835rvm.1186006721488;
        Wed, 01 Aug 2007 15:18:41 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Wed, 1 Aug 2007 15:18:41 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708011143180.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54487>

On 8/1/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 1 Aug 2007, Dmitry Kakurin wrote:
>
> > On 7/31/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> > > Dmitry Kakurin said the following on 30.07.2007 01:14:
> > > > I want to be able to build MinGW port of Git on Windows. I've tried
> > > > to follow steps in README.MinGW to setup this environment myself
> > > > (install MinGW, MSys, ZLib etc.) but after wasting a lot of time
> > > > with no result I give up. So, could somebody please just pkzip
> > > > their environment (everything required) and share the zip file with
> > > > me (privately or publicly)? I also think that an even better idea
> > > > is to create a new Git repository with MinGW build environment.
> > > > This will make contributing to MinGW port of Git MUCH easier.
> > >
> > > Aaron has done this, and you can find the link on his blog, here:
> > >     http://www.ekips.org/cgi-bin/aaron.cgi/2007/02/27
> >
> > I've downloaded and installed it. But I could not make it work :-(.
> > First I had this problem:
> > $ make
> > GIT_VERSION = 1.5.3.GIT
> >     * new build flags or prefix
> >     CC convert-objects.o
> > gcc.exe: installation problem, cannot exec `cc1': No such file or directory
> > make: *** [convert-objects.o] Error 1
> >
> > Then I've copied cc1.exe and some others from
> > C:\mingw4git\libexec\gcc\mingw32 into /bin.
> >
> > $ make
> >     CC convert-objects.o
> > In file included from cache.h:4,
> >                  from convert-objects.c:1:
> > git-compat-util.h:51:22: sys/wait.h: No such file or directory
> >
> > Searching entire (downloaded) tree for wait.h gives nothing.
> >
> > 'make configure' does not work:
> > $ make configure
> >     GEN configure
> > configure.ac+:4: error: Autoconf version 2.59 or higher is required
> > configure.ac+:4: the top level
> > autom4te: /bin/m4 failed with exit status: 1
> > make: *** [configure] Error 1
> >
> > What do I do now?
>
> This looks like you downloaded git.git.  Official releases do not have
> MinGW support yet!  You have to get the MinGW port from repo.or.cz:
>
>        http://repo.or.cz/w/git/mingw.git
You were right. I was downloading Git under Cygwin and then copied it
to MSys. Somewhere along the way I got confused and copied the wrong
directory.
It works now!
Thank you!

- Dmitry
