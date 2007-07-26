From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 11:07:22 -0400
Message-ID: <fcaeb9bf0707260807u476719e3rec2dcf5f780013c0@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <7v6447bxc1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0707260614500.14781@racer.site>
	 <46A8378A.6050201@xs4all.nl>
	 <Pine.LNX.4.64.0707260737170.14781@racer.site>
	 <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
	 <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com>
	 <46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com>
	 <fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com>
	 <Pine.LNX.4.64.0707261534550.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 17:07:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE4w4-0002jx-6E
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 17:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719AbXGZPHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 11:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756014AbXGZPHZ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 11:07:25 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:12721 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719AbXGZPHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 11:07:24 -0400
Received: by an-out-0708.google.com with SMTP id d31so108863and
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 08:07:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fvvx9N+isgqhWcdbSem2hA15yiD3vTLxUJPsOxOozs3k35pG7fgF//2d2LBOl8f3IGvvsxUlvIWApmoAL5hJ4mDr0MB/QkKafGBtBT14SoLrG0SjFNZLkmWvfEyoIYUsKllAuiPVhsCy9DUD10obE8cgSXyZ0ozqjHv/2qI005s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ucT7hOr2sV7o6ZIN6GN6Z3Re13ZSwI9ZqJLjuM7Olis2r8YDUA0ap7P9L5+uBx6DDfnjOE8M+iqLMqDXtJW3aGOZnO56640OgFAKkRHJ6dRAjZ2O7tOko1OQ4k4+/3Q4RiJ0RhdWW8Cvsrb5oYgADMTZZl1U6rdrDVPETUkkqoE=
Received: by 10.100.197.15 with SMTP id u15mr1418478anf.1185462442658;
        Thu, 26 Jul 2007 08:07:22 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Thu, 26 Jul 2007 08:07:22 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707261534550.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53838>

On 7/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 26 Jul 2007, Nguyen Thai Ngoc Duy wrote:
>
> > On 7/26/07, Christian MICHON <christian.michon@gmail.com> wrote:
> > > On 7/26/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > > > microperl [1] maybe? I haven't tried it yet.
> > > >
> > >
> > > it won't work. I tried that few months back.
> > >
> > > plus the fact you'll still need perl modules.
> > >
> > > I just had a look at your gitbox gitweb. Did you really manage
> > > to get busybox-1.6.1 to work with mingw ?
> >
> > Most of tools (that are included) work fine. Ash almost works. It can
> > run git status, git commit, git clone.. and most of test cases. There
> > are still some missing pieces and bugs to hunt down though.
>
> Thank you for working on this!
>
> However, I am not completely convinced that having a builtin shell is all
> that useful.  I for one would like to have MinGW busybox _separate_ from
> git...

I make MinGW busybox part of git for some reasons:

 - Making a full MinGW busybox would take lots of time. I don't need
busybox for Windows. What I need is a shell and enough POSIX utilities
to run git shell scripts without any dependencies. Windows users
(including myself when I have to use Windows) hate dependencies.
 - I don't want MinGW busybox to be used outside of git (if it is
installed separated from git), there are cygwin and msys already. I
don't want to compete them. And I don't like conflicts (not sure
though) because you have multiple UNIX emulations on the same system.
 - Making ash part of git has an advantage that you could tune the
shell to fit git. Earlier you had to replace find/sort with
/usr/bin/find and /usr/bin/sort in git scripts to avoid Windows
alternatives. I don't like that. If you have control over the shell,
you could make it ignore whatever program out there and use your own
ones. This one is not a strong point though.
 - MinGW busybox (or gitbox as I call it now) utilizes compat/mingw.c
and other stuff like run-command.c... Making it separate (as source
code) duplicates code for nothing.
 - If you meant separating from git.exe binary, not from source code,
then it's ok.

>
> Yes, you could not use the nice "ln -s busybox ash" idiom, since Windows
> lacks symlinks, but you could still say "busybox ash" with a relatively
> small, single executable.
>
> Ciao,
> Dscho
>
>


-- 
Duy
