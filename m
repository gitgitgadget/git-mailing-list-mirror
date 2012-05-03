From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 16:09:15 -0000
Message-ID: <e7c7047452954a4b80f5fd436103cb11-mfwitten@gmail.com>
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
Cc: Rich Pixley <rich.pixley@palm.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	<git@vger.kernel.org>
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Thu May 03 18:13:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPyep-0004Nb-5v
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 18:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab2ECQN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 12:13:27 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55959 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab2ECQN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 12:13:26 -0400
Received: by eekc41 with SMTP id c41so582778eek.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=4LmCHYoQv1wBr1N1lEQWRkC1zWigGrqywhFvJUsVojw=;
        b=kPZM1HtPnusosYk59ILPh+ij+Pg+OthBSrrU8oxP+epSIoeOinMmXFRV1Cu5CL9bxN
         Omvg9gJhRBqwhikU4tI6ktVcA55NyP4bACjY3M2jt3qPsgiTXmKoA5Tc43xYSoen81t8
         R3CrUNQaN3V54f67JSfD/8l5BGrC9KoyruM+mGUKedYWb2tePIPEQaindjedg1fSEdfV
         kpYe24z6oXL+QZdvBbkXnApEvQeG7v1KBiioh2R2ND7aB86Lfj7QiUoEMLmDL24b9PgX
         l0RGZbbDKf865heAlWgA5OOGGO5a7ug/iQ8K9v/Tp2vAzJQh7L1P6sP6JSe5Ju+IcY3t
         DXOA==
Received: by 10.14.207.9 with SMTP id m9mr406916eeo.52.1336061605384;
        Thu, 03 May 2012 09:13:25 -0700 (PDT)
Received: from gmail.com (politkovskaja.torservers.net. [77.247.181.165])
        by mx.google.com with ESMTPS id p57sm27494886eei.8.2012.05.03.09.13.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 May 2012 09:13:24 -0700 (PDT)
In-Reply-To: <63c4e1944dcfd03e8c9ff324080ff62f@ulrik.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196918>

On Thu, 03 May 2012 14:23:59 +0200, Hallvard Furuseth wrote:

> On Wed, 02 May 2012 15:21:29 -0000, Michael Witten wrote:
>
>>On Wed, 02 May 2012 16:21:07 +0200, Hallvard Breien Furuseth wrote:
>>> And in a bare repository:
>>>
>>>     git init --bare foo.git
>>>     cd              foo.git
>>>     git remote add bar ../bar.git
>>>     git fetch      bar
>>>         --> adds bar/master etc.
>>>
>>> For some reason, 'git clone --bare' does not treat the cloned
>>> repository the same way - it just copies it under refs/heads/
>>> instead of refs/remotes/, without even adding it as a remote.
>>
>> What do you mean?
>
> I mean 'git clone --bare bar.git foo.git' does not give foo.git
> a remote named 'origin' with a branch origin/master.  Not sure
> if there is a _simple_ way to do it well either.  init + fetch
> above does not try to hardlink objects/packs like clone does.
>
>> (...)
>>   $ git init bar.git; cd bar.git
>>   $ echo a > a; git add a; git commit -m a; cd ..
>>   $ git clone --bare bar.git foo.git; cd foo.git
>
>    $ git branch -a
>    * master

>From `git help clone':

  --bare
      Make a bare GIT repository. That is, instead of creating
      <directory> and placing the administrative files in
      <directory>/.git, make the <directory> itself the $GIT_DIR.
      This obviously implies the -n because there is nowhere to
      check out the working tree. Also the branch heads at the
      remote are copied directly to corresponding local branch
      heads, without mapping them to refs/remotes/origin/. When
      this option is used, neither remote-tracking branches nor the
      related configuration variables are created.

namely:

                                  Also the branch heads at the
      remote are copied directly to corresponding local branch
      heads, without mapping them to refs/remotes/origin/. When
      this option is used, neither remote-tracking branches nor the
      related configuration variables are created.
