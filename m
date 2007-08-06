From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Mon, 6 Aug 2007 16:30:57 +0200
Message-ID: <e7bda7770708060730t7c0713c4m6abe42d929d847b0@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <46B2D4D9.4020103@trolltech.com>
	 <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
	 <Pine.LNX.4.64.0708031334530.14781@racer.site>
	 <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com>
	 <Pine.LNX.4.64.0708032231320.14781@racer.site>
	 <e7bda7770708031716i61f80d89o8970b3236a961613@mail.gmail.com>
	 <Pine.LNX.4.64.0708040123560.14781@racer.site>
	 <e7bda7770708051641h15bd38abo659e74322e6232c0@mail.gmail.com>
	 <Pine.LNX.4.64.0708060054020.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 16:31:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II3bv-00070p-5I
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 16:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762627AbXHFObB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 10:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762191AbXHFObB
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 10:31:01 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:30538 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762184AbXHFObA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 10:31:00 -0400
Received: by nz-out-0506.google.com with SMTP id s18so441594nze
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 07:30:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nX8iN+DH6zX1S/NmdxaNQtWnmE/jjfUX7ogx9Iu8r5o5QXJ4a/RQB7Fh25hSdtkgOYGT2W4IitjC7DNsFevnMJcAyPmt8Syel+HZVb/sy6ERBAUVW0LwGyrpVOWkpSEWPCVpGzV3klYUd6BOWc6YAyKg0GuexslHvOincipzryw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BlNGqWv3J3dyoGgHgHCkpm8UL9Ip2NNmtucGymtY5S4+VDl0SGyVk6DzjHxJhC0tw6e/gV7xxshsr39xsgdm2VCjRUIBl6kV/B4RDT3KcQA/1lFMCIV9eMd44H/PSbEDchcmwQUTydbQxJ776jMYGQas4ir7I2e/adlMDD4ch9g=
Received: by 10.65.74.9 with SMTP id b9mr8939180qbl.1186410657545;
        Mon, 06 Aug 2007 07:30:57 -0700 (PDT)
Received: by 10.65.141.5 with HTTP; Mon, 6 Aug 2007 07:30:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708060054020.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55152>

On 8/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> NOTE: earlier installers included msys-rxvt.bat.  I now _know_ for a fact
> that a lot of things are strangely broken under Rxvt.  For example,
> creating an ssh key, of all things.

> > > > 2. rxvt-terminal had some freezes

> Those "freezes" were due to the fact that Rxvt incorrectly updates stderr
> in a blocking way, or not at all (don't know which).  There are more
> things that do not work in Rxvt, and only after trying the same in cmd
> (which I do not like for various reasons) I found out that rxvt.exe is at
> fault.
>
> I would be glad if somebody managed to compile rxvt herself and fix all
> those bugs (see http://code.google.com/p/msysgit/ for a short list of the
> most pressing issues I found).  As it is, I have enough work to do with
> the rest of msysGit, and for the moment, I can at least work in cmd.  Even
> ssh push works.
>

It looks like rxvt is evil. I'll try to get other terminals working
like that one Marius suggested. Although msys/bash makes up for most
of the annoyances I dislike the cmd-terminal to the point that it's a
real issue for me [deep settled in my neuron configuration].

> > > > 3. "gitk --all" said "Error reading commits: fatal: write failure on
> > > > stdout: Invalid argument"

> I have to wonder how you called it... From msys.bat, cd'ing into a valid
> repository, I had no issues whatsoever.

I called it from rxvt. I tried it now under cmd and it's all good. Did
you try rxvt in this case?


I notice that with your net installer (great job btw!), I get the
msysgit.git reop under /.git and the mingw.git repo under /git/.git
but there is no /git in /.gitignore. Is this overlap intended?  Isn't
this a case for submodules?

//Torgil
