From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 15:43:15 -0400
Message-ID: <fcaeb9bf0707261243v65f6e9deof8e266590e05d49f@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <46A8378A.6050201@xs4all.nl>
	 <Pine.LNX.4.64.0707260737170.14781@racer.site>
	 <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
	 <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com>
	 <46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com>
	 <fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com>
	 <Pine.LNX.4.64.0707261534550.14781@racer.site>
	 <fcaeb9bf0707260807u476719e3rec2dcf5f780013c0@mail.gmail.com>
	 <46A8D2BE.7070309@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 21:43:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE9FD-0004zF-QG
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 21:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935116AbXGZTnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 15:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935173AbXGZTnT
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 15:43:19 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:39708 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935116AbXGZTnS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 15:43:18 -0400
Received: by an-out-0708.google.com with SMTP id d31so125002and
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 12:43:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ehuSoyyzz+dmlXEkQpFCgiLJBCXBuaHDHfqHKGuSAJatJmvffjomRNl7xf1MD+ruk5lB8lrcU67oXEyyNUvGS7A3JcDhdk3Cz9y4IRvHEfENasaPITaciR62bxlVeI3BpvApfqFSIdwQ7+YorZor/M+qMCjMCzhHZhiuwn80TSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i9zhA7V+8jOgpdWY5I6mmyOiqtaT8VITnVy73cPOMkQ/fAqxWOReM1wlNhRepBQDlOUhzYlKOvBYld2tFctKADLAHjzLtTCz/uaZONa8BAZfijIENIec/g9WBkb+vo5Qju3a7GIgQveggrq+TNHBoYBsiU4bCOcx0/bgTRvQypM=
Received: by 10.100.197.15 with SMTP id u15mr1894984anf.1185478996000;
        Thu, 26 Jul 2007 12:43:16 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Thu, 26 Jul 2007 12:43:15 -0700 (PDT)
In-Reply-To: <46A8D2BE.7070309@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53863>

On 7/26/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> Nguyen Thai Ngoc Duy wrote:
> > On 7/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> Thank you for working on this!
> >>
> >> However, I am not completely convinced that having a builtin shell is all
> >> that useful.  I for one would like to have MinGW busybox _separate_ from
> >> git...
> >
> > I make MinGW busybox part of git for some reasons:
> >
> > - Making a full MinGW busybox would take lots of time. I don't need
> > busybox for Windows. What I need is a shell and enough POSIX utilities
> > to run git shell scripts without any dependencies. Windows users
> > (including myself when I have to use Windows) hate dependencies.
> > - I don't want MinGW busybox to be used outside of git (if it is
> > installed separated from git), there are cygwin and msys already. I
> > don't want to compete them. And I don't like conflicts (not sure
> > though) because you have multiple UNIX emulations on the same system.
> (..snip..)
>
> Hi Duy,
>
> *drool*
> This was an extremely good idea! Thank you so much for working on it!
> I'll be sure to play around with it, and see if there's any way I can
> help out. Guess I finally have to get that MinGW compile environment set
> up then :-)
>
> Btw, are you compiling with MinGW on Windows, or cross-compiling on Linux?

I cross-compile all the time (and test it on Windows when I have one,
on the buggy Wine when not). I'd absolutely appreciate bug reports
regarding building it on Windows ;-)
-- 
Duy
