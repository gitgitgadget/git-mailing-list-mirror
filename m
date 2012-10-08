From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: build deps
Date: Mon, 8 Oct 2012 18:37:38 -0300
Message-ID: <CACnwZYe5CR-1m4rfCcaLsh4rGDx_8kRNCPK31=AepqocG_Lwzg@mail.gmail.com>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com>
	<5072FAD1.1000807@gmail.com>
	<CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 23:37:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLL1K-0003n1-2y
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 23:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab2JHVhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 17:37:41 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:40537 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab2JHVhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 17:37:39 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2578293lag.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0JUq2ZpSC89PLmbd5ZQTs2/EmyEheWCzUBm7PZGD6UE=;
        b=AKw3d7fGplM2r+hW0tMF9J0sk2CPDPoT26/v0rhHrSTuxfEZ/JxOImUWwkZSZ1M+I9
         H2FN5GI3AA0VAcLLcjmvUDQ2KObdakJu86EGEed0+12NPXt2RrHoDQo72cD452XtSjiZ
         AxDjQ7yI8Zx2v2hpJ/97UGprLL+R8vYc+AbvuIUI6DMBMgZ2YgJ/9r8xsqB60P3ty6hR
         IjSAUHu2ulE5PHDebYAilI3Do8Xa9w4jJ/tuuCPboNKh344KNvhDQS98d6DTukW1rx0z
         SnA4mnfUXrqEd/Wnq2Kr6ykZxfQVGstmjFr765pjApYiJK4O7JcbIlcs7pjjQPBmU1fz
         yzhw==
Received: by 10.152.148.195 with SMTP id tu3mr14722423lab.16.1349732258288;
 Mon, 08 Oct 2012 14:37:38 -0700 (PDT)
Received: by 10.112.24.10 with HTTP; Mon, 8 Oct 2012 14:37:38 -0700 (PDT)
In-Reply-To: <CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207274>

On Mon, Oct 8, 2012 at 6:36 PM, Thiago Farina <tfransosi@gmail.com> wrote:
> On Mon, Oct 8, 2012 at 1:09 PM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
>> On 10/07/12 20:39, Thiago Farina wrote:
>>> When trying to build from source but it's failing:
>>>
>>> $ sudo make prefix=/usr/local all
>>>     LINK git-credential-store
>>> gcc: @CHARSET_LIB@: No such file or directory
>>> make: *** [git-credential-store] Error 1
>> Did you run the "configure" script?
> Hum, I haven't.
>
> Now I did.
>
>
>> In the source folder, do you have either file "config.mak" or
>> "config.mak.autogen" ?
> After running ./configure, now I have.
>
>> If you do, try removing them, and compile again.
>> Which version are you compiling?
> $ cat GIT-VERSION-FILE
> GIT_VERSION = 1.7.12.84.gefa6462
>
>> Did you get the source files from tar?
>> Or from git?
> From git (git://git.kernel.org/pub/scm/git/git.git).
>
> OK, after running ./configure I tried the make command again.
>
> CC credential-store.o
> /bin/sh: clang: not found
> make: *** [credential-store.o] Error 127
>
> $ which clang
> /home/tfarina/chromium/src/third_party/llvm-build/Release+Asserts/bin/clang
>
> $ clang --version
> clang version 3.2 (trunk 163674)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix

Also:

$ echo $CC
clang -B/usr/local/gold/bin
