From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 16:44:04 -0000
Message-ID: <f16516bc77a645e4b0d6b5d2f42090d3-mfwitten@gmail.com>
References: <4F9F128C.5020304@palm.com>
            <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
            <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
            <20120501111415.GD5769@thunk.org>
            <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
            <4FA02830.3040407@palm.com>
            <86havzoi8h.fsf@red.stonehenge.com>
            <4FA04D02.6090702@palm.com>
            <86mx5rmx32.fsf@red.stonehenge.com>
            <4FA055D0.7040102@palm.com>
            <86aa1rmvhb.fsf@red.stonehenge.com>
            <4FA05E9F.9090709@palm.com>
            <85ff02fc05e4a52ee0b1f1922f774a8d@ulrik.uio.no>
            <947c3d6ae263495985543764a57c3fbb-mfwitten@gmail.com>
            <63c4e1944dcfd03e8c9ff324080ff62f@ulrik.uio.no>
            <f66919ac273fd1c90839e5556f126960@ulrik.uio.no>
Cc: Rich Pixley <rich.pixley@palm.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	<git@vger.kernel.org>
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Thu May 03 18:46:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPzAW-00050b-Du
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 18:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab2ECQqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 12:46:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36286 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab2ECQqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 12:46:07 -0400
Received: by pbbrp8 with SMTP id rp8so2705128pbb.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=A55wet8R8B57r7BkNoWJ5Qe4nsM8yYWdrBM0Sz571ec=;
        b=l3fL/NZepjhm7AV/sYrOVxtxHkaSogzIaqhBpuWcreuN45VzdTUjKpWDtmc2zHN+Vz
         jtRkO+wj0E/VeINiTi8IpZ0YKwhlhVzmK/r3clcgPRGVWzxP8EYmx+tqe/BnU3KwPt6v
         wZHc3BlEB9w+Xwd5WIvSgikadgC44YICR+0FvaJM2hh7Ui06lw2TZ8zx2QqGEUDZio31
         OyI3uyoaDTU/+Fbuzmm9AWb016zkJ49PD6z0eDAEt3suuo6cwPK5gECkGEFuEOUTDBaP
         2keVE9lBrUEF0sp4TicfItRK0FpqoSI7rv3UBkLqL0AW7wGstNXQaygEG0ouzaVisv59
         mnCw==
Received: by 10.68.223.67 with SMTP id qs3mr9356279pbc.142.1336063567241;
        Thu, 03 May 2012 09:46:07 -0700 (PDT)
Received: from gmail.com ([216.17.101.125])
        by mx.google.com with ESMTPS id d4sm5771718pbr.32.2012.05.03.09.45.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 May 2012 09:46:06 -0700 (PDT)
In-Reply-To: <f66919ac273fd1c90839e5556f126960@ulrik.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196920>

On Thu, 03 May 2012 18:20:43 +0200, Hallvard Furuseth wrote:

> On Thu, 03 May 2012 16:09:15 -0000, Michael Witten wrote:
>
>> On Thu, 03 May 2012 14:23:59 +0200, Hallvard Furuseth wrote:
>>
>>> I mean 'git clone --bare bar.git foo.git' does not give foo.git
>>> a remote named 'origin' with a branch origin/master.  Not sure
>>> if there is a _simple_ way to do it well either.  init + fetch
>>> above does not try to hardlink objects/packs like clone does.
>>>
>>>> (...)
>>>>   $ git init bar.git; cd bar.git
>>>>   $ echo a > a; git add a; git commit -m a; cd ..
>>>>   $ git clone --bare bar.git foo.git; cd foo.git
>>>
>>>    $ git branch -a
>>>    * master
>>
>> From `git help clone':
>>
>>   --bare
>>       Make a bare GIT repository. That is, instead of creating
>>       <directory> and placing the administrative files in
>>       <directory>/.git, make the <directory> itself the $GIT_DIR.
>>       This obviously implies the -n because there is nowhere to
>>       check out the working tree. Also the branch heads at the
>>       remote are copied directly to corresponding local branch
>>       heads, without mapping them to refs/remotes/origin/. When
>>       this option is used, neither remote-tracking branches nor the
>>       related configuration variables are created.
>
> Yes, I know.  I just don't know why.

I imagine that the purpose behind a bare repository is really just to
provide a repository into which objects may be pushed and from which
objects may be fetched, and that's it; it's sole purpose is to act
as a point of communication. Cloning a repository with --bare is
meant to simplify the task of setting up a bare repository with
some initial content.

Fortunately, we're talking about the history of a revision control
system. I found this with `git blame -L70,76 71821351^ git-clone.txt':

  commit 4fb66a62eeb7bfec115cd0058d7a05ab62fc23e7
  Author: Junio C Hamano <junkio@cox.net>
  Date:   Sun Jan 22 17:27:52 2006 -0800
  
      clone: do not create remotes/origin nor origin branch in a bare repository.
      
      It is simply pointless, since no merges will ever happen in such
      a repository.
      
      Signed-off-by: Junio C Hamano <junkio@cox.net>

That certainly corroborates the limited purpose of a bare repository.
