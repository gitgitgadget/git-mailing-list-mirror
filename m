From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: build deps
Date: Thu, 11 Oct 2012 17:54:13 -0300
Message-ID: <CACnwZYf56XkqW085HoWhAN2EnjCJd=VYHGAD8fZCCe6_FNhO2A@mail.gmail.com>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com>
	<5072FAD1.1000807@gmail.com>
	<CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com>
	<50735939.10604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 22:54:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMPm7-0000JL-W0
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 22:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759341Ab2JKUyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 16:54:18 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:35308 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759332Ab2JKUyP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 16:54:15 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1551594lag.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RrGgoS8mEYi74jlTvLM8HVD2GqDmjcYifh64wKwaavA=;
        b=eeNR9HXzsFQtP8an6VxbRCXuNoyM3leozKmRmQnOu+TA4AFtO/kdY3Lb+YAylk8XYt
         3ZdZekvRuC4MjLjY3BWE0baTaCi6CQqpbsUtzsJUHdOb6k/7g8JHSj6bqcdJwleXYdM0
         H3D+UyjpU8omzYs0TC3FzDCPpVBo8sR/CStJKt9e+PSJjdyEqRYBOrmxXAiVD1zV9ixt
         USqAXJcFMsKnlumbiOcmJFhDv6YRZ/l9OGEkDED2DdD/kyH3VVsA9CluDlkdkZ0vGW5h
         ZfMIsO+vnQoNHrtTdoqdWSvfJJHmqnDgA7NTUt8hSUL8+n4VEsJt9x7n8stTMWfltHdU
         qKgQ==
Received: by 10.112.24.74 with SMTP id s10mr842871lbf.122.1349988853247; Thu,
 11 Oct 2012 13:54:13 -0700 (PDT)
Received: by 10.112.24.10 with HTTP; Thu, 11 Oct 2012 13:54:13 -0700 (PDT)
In-Reply-To: <50735939.10604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207513>

On Mon, Oct 8, 2012 at 7:52 PM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
> On 10/08/12 17:36, Thiago Farina wrote:
>> OK, after running ./configure I tried the make command again.
>>
>> CC credential-store.o
>> /bin/sh: clang: not found
>> make: *** [credential-store.o] Error 127
>>
>> $ which clang
>> /home/tfarina/chromium/src/third_party/llvm-build/Release+Asserts/bin/clang
>>
>> $ clang --version
>> clang version 3.2 (trunk 163674)
>> Target: x86_64-unknown-linux-gnu
>> Thread model: posix
> Looks like something went wrong with "make" setting PATH. I wonder if
> the "+" sign in your path is somehow messing things up.
>
Would be something that could be fixed in git?

> Are you trying to compile specifically with clang?
Nope, it just happen that I switched to clang because I use it to
compile chromium and I need it to use the chrome_plugin[1].

> If not, maybe try
> unsetting the CC env var, and run configure again?
Just setting CC to gcc works for me. But still, I'd like to be able to
build with clang (may be as you noted is just something with the + in
my PATH).

[1] http://git.chromium.org/gitweb/?p=chromium.git;a=tree;f=tools/clang/plugins;h=8e79d8f35d5ccfee82b6ab8f27ea8b5d820c772d;hb=HEAD
