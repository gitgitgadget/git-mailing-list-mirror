From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Sat, 11 Aug 2007 00:31:32 +0200
Message-ID: <e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com>
References: <f99cem$4a4$1@sea.gmane.org>
	 <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>
	 <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de>
	 <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com>
	 <Pine.LNX.4.64.0708081810130.14781@racer.site>
	 <75EB313E-807D-44FB-A186-A151F182B47B@zib.de>
	 <Pine.LNX.4.64.0708082228520.21857@racer.site>
	 <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
	 <e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com>
	 <2383328F-300E-459C-A299-90242DA230F7@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Aug 11 00:31:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJd1H-0000nb-Kg
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 00:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071AbXHJWbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 18:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758789AbXHJWbf
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 18:31:35 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:48120 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbXHJWbd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 18:31:33 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1038274wah
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 15:31:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xhx+PL/5qW6+oJ8/jMfhHZYBL9C5nOdbh3ZMRp0ybhrC1AhnQVqmie6Sz3dGG67Ul7PE90WnNg/yIiPG+SsZdRt5WANHdBpJwjEh0dJzGCgssBiBVtVHJuVk/CEUuqBBdCkym29heA4t3qDxC2KNfQazs2OfPEHT9bWuzHUUHjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZGMMW3kZeml+9JhM9DCRZvUDAVxOVaXHaay0ATmTS2XZeymwXh/glRL97/I73YWFyjjGFGZ1pbpPCAVlQHV/xiKWak9geWrm0th9Dyf0rmGCFwxRDuicQX8fZZkW747LQ1QR/WMZNvg9kPKa/YkjB7GcOrPJBY6kxGGS8dxCczU=
Received: by 10.114.123.1 with SMTP id v1mr4020026wac.1186785092631;
        Fri, 10 Aug 2007 15:31:32 -0700 (PDT)
Received: by 10.114.47.7 with HTTP; Fri, 10 Aug 2007 15:31:32 -0700 (PDT)
In-Reply-To: <2383328F-300E-459C-A299-90242DA230F7@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55575>

On 8/10/07, Steffen Prohaska <prohaska@zib.de> wrote:

>  [..list of tools and links]

Thank you for the information!  i'll check those up.

> >> My goal would be to type 'make windist' in the official repo and
> >> get a very basic installer (maybe just a zip archive) that contains
> >> everything needed to run git on Windows. Unpacking this self-
> >> contained
> >> installer on a freshly installed Windows should get you going. There
> >> should be no need to install Cygwin or something else.
> >>
> >> Is this realistic?
> >> What is needed to get there?
> >> What would be an estimated timeframe to achieve this goal?
> >>
> >> Will all this run on Windows XP 64 bit and Windows Vista 64 bit?
> >
> > How fast can you type?
>
> I don't see your point. The question is if git runs flawlessly
> on 64 bit systems, which we use for development. I have no experience
> with mingw. Maybe there are some issues with 64 bit Windows, maybe
> not. But its a reasonable question?
>
> > Why does it have to be the _official_ repo? Git have submodule
> > support, so you could do a repo called
> > "my_excellent_git_environment_for_windows.git" and have the official
> > repo as submodule (msysgit is done this way).
>
> The official repo would indicate a real commitment to me that
> Windows support if officially maintained.

I agree it's reasonable questions. My point is that to get something,
you have to be active (and you're a prime example of that I think).

Quoted from http://git.or.cz/ : "Traditionally, the low-level part of
Git is called plumbing and the interfaces and frontends are called
porcelains. Git itself comes with a default porcelain bundled and that
is actually what you will normally mean when you say you use Git."


What do you include in the "make windist" installer and the "Windows
support" ?  Are you talking porcelain or plumbing?

>> Aiming for
>> environments that works on several OSes is a good thing for future
>> migrations.
> I work for years now on cross platform code. I never needed a whole
> environment. I need Qt and the native development environment, like
> Visual Studio, gcc, Xcode. I don't need KDE on Windows, I don't need
> KDE on Mac. Everything's there already.

Good thing you're flexible and have a broad experience. Not everyone
out there has that and it can be tricky to try to lure those people
away from 10yrs habits.

//Torgil
