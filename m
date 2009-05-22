From: Tim Uckun <timuckun@gmail.com>
Subject: Re: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 22:35:57 +1200
Message-ID: <855e4dcf0905220335n367a065fidc65567119c0a5a3@mail.gmail.com>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
	 <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>
	 <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>
	 <4A1671E5.4030400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri May 22 12:36:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7S6g-00040n-6t
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 12:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbZEVKf6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2009 06:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbZEVKf6
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 06:35:58 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:22903 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbZEVKf5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2009 06:35:57 -0400
Received: by yw-out-2324.google.com with SMTP id 5so983137ywb.1
        for <git@vger.kernel.org>; Fri, 22 May 2009 03:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wbMTrlUGT1XZD7TL2w6YYqnuSaPOC6A6aGJPa4gRjbQ=;
        b=iLQt7w+jOCWfA41x94cRU8ZSBabt/TPLYLw9DQClUiaqs0mtFLD2baHzr9pTQUtHYB
         K6isDY6C+NWt2KBFlQet6aqM0Uw0c5j3UPS9NCkGvm62yaewEVwETxCNWT1pjJoQzy9b
         iCgAkc6uymQbYZORal3J+7b2VoR35BqOYsriw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hZJopkDvWAXd0qcvMuoPrI7E1DP0+3jZ5bplDDmB9DtiS14jFj3un3OnSfVTiP+xDK
         2Vlmvvzdzqv0/nhlqTrYsVL4HfYi9tAiTQ1v22GInStgWEHpC5SRpD0DVWyUPQHnLozt
         U0jdQ2BM4lOU5ts6QVm8En8rcy7IKZp9IuNbo=
Received: by 10.90.120.17 with SMTP id s17mr3044598agc.69.1242988557664; Fri, 
	22 May 2009 03:35:57 -0700 (PDT)
In-Reply-To: <4A1671E5.4030400@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119722>

>> It just worked out that way. =C2=A0I am experimenting with a rails a=
pp and
>> those plugins were pulled from github.
>>
>
> But not, I take it, as submodules?
>

That's right.


>
> Because from git's point of view, they were already managed in a
> separate repository as a submodule. When you have submodules in a
> repository, the parent repository can't (well, won't anyways) track
> files inside the submodule directory, so git ignores everything under
> a worktree subdirectory that contains a .git folder.

I deleted the .git directory in that subfolder but I got the exact
same message. There was a .gitignore file in there so I deleted that
too and still got the same message.    I think since the initial
checkin has the .git folder in it git has already decided it's not
going to track it.

Anyway as you can see from my original post I decided to mv the 'test'
directory instead because it has no .git directory in it.

>

>>
>> I'll have to clean up all those and see if the problem remains.
>
> A better way is probably to import those projects as proper
> submodules so you can update them without hassle later. "git help
> submodule" should get you a long way, but be prepared to study the
> docs a little so you understand the caveats with submodules before
> you use them. For instance, you *will* run into problems if you
> later replace a worktree subdirectory belonging to the parent git
> repository with a submodule, so it's really better to have them as
> submodules from the start.
>

To be honest I am just trying to learn the basics now and would rather
get comfortable with those before I mess around with submodules.

I still don't have an answer as to why the renamed test_new directory
exists master branch and why both the original 'test' directory and
the renamed 'test_new' directory are missing subdirectories.

Until I understand that I won't feel comfortable using git.
