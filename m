From: demerphq <demerphq@gmail.com>
Subject: Re: Sync production with Git
Date: Thu, 9 Aug 2012 06:21:21 +0200
Message-ID: <CANgJU+VNA-Rz_MqfowKjTYQWFeYdfbwJZKvQdfv+Qbu0J6YudQ@mail.gmail.com>
References: <1344431484059-7564617.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: kiranpyati <kiran.pyati@infobeans.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 06:21:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzKFW-0005bl-Rw
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 06:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006Ab2HIEVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 00:21:23 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50621 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab2HIEVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 00:21:22 -0400
Received: by obbuo13 with SMTP id uo13so46316obb.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 21:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m4jyEyICpgj3FwPpEWEA8vdwlpzINca85FGmYXqn07w=;
        b=BXpdhFHhx0CVxjsoUorQ9RnipN/wDvH5ULqD8Gn0sSLpa0nhUGT6Otyuo8ej4pvLhW
         8CF4++ib+wHYCtbsQ390Bql0m+0M4SYAWN/HareLJOuukfHkJHJaEALZqPNgxsPWxqGL
         fTg6BgIeVBA1VTT/uS5M+gydi4PmhkGmrdrWzOdv09b+K5RQj7s0E+mD9ULZ3r3tGCXV
         uWaG9j25eOTUZwz0gZlCcel7AFkeMfTA5a1+vp8ISBJmPryLrnC9aMaCZUaMAmGgIVN/
         jG0mQh0qBGFftlR3QwfEEKi+qd09ceDFdYQbpiWmGGd/GDRTQWDQymkrG9vNlnJDfMsw
         vdvA==
Received: by 10.60.169.134 with SMTP id ae6mr2837470oec.55.1344486081728; Wed,
 08 Aug 2012 21:21:21 -0700 (PDT)
Received: by 10.76.87.68 with HTTP; Wed, 8 Aug 2012 21:21:21 -0700 (PDT)
In-Reply-To: <1344431484059-7564617.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203147>

On 8 August 2012 15:11, kiranpyati <kiran.pyati@infobeans.com> wrote:
> I am new to github,
>
> Earlier we used to manually upload files on the production through FTP
> although git was present on the production. Due to this now git status shows
> many modified and untrack files.
>
> To sync that with git we have downloaded all files from production and
> committed to git. Now git has all files same as production.
>
> We have not pulled on production since last 6 months and because of this it
> shows modified and untracked files.
>
> Now if we pull on the production there any 100% chances of the conflict
> happened on all modified files. As there are hundreds of modified files
> since last since month. Git pull will show conflict to all those files. In
> that case site will get down and we can not afford this.
>
> We want a way to seamlessly sync production and Git.
>
> Can anybody please help me on this?
>
> Thanks in advance..!!

Try git-deploy.

https://github.com/git-deploy

It contains a full work flow management for handling rollouts from git.

Yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
