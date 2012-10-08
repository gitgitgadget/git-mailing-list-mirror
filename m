From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: build deps
Date: Mon, 8 Oct 2012 18:36:55 -0300
Message-ID: <CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com>
	<5072FAD1.1000807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 23:37:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLL0f-0003U0-38
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 23:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab2JHVg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 17:36:58 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:49712 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab2JHVg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 17:36:57 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2577856lag.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nH8rbgENYRR1knvBc39H2WoOFvFQ2aoDnHwKDQhB3aM=;
        b=nXYMeaE5AlXZx9+G+bthTZnMOVjH4UHh5oDMlVNgJjdlawaH9bylKkApETA4l8kFfo
         KanNZ2cjZbovvXGh0F7Zv0v1oEonuMLvnXYSCisr/bZMoGAMT4fYZnbGKShJ6ggy2j7J
         twBm15XsQLoZN3EUJAbkkvMQJxksd0fn406tivZBDrsWWjAQSSa9x05rOLg7J98aAdGp
         sMqneq3jGk+yktSjUIJzNnGsXQyLguzBdHiz8PZMk/lExmLo6rkzo+rvwvgmttAwGwWp
         6MsVH7WEMOFg2MjgSHMt93D/F34i5S2UTbPvgU6z+yYKwZzHm+QVOcbfs0Vz0rkIvY4T
         2VAg==
Received: by 10.112.23.36 with SMTP id j4mr7266231lbf.71.1349732215484; Mon,
 08 Oct 2012 14:36:55 -0700 (PDT)
Received: by 10.112.24.10 with HTTP; Mon, 8 Oct 2012 14:36:55 -0700 (PDT)
In-Reply-To: <5072FAD1.1000807@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207273>

On Mon, Oct 8, 2012 at 1:09 PM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
> On 10/07/12 20:39, Thiago Farina wrote:
>> When trying to build from source but it's failing:
>>
>> $ sudo make prefix=/usr/local all
>>     LINK git-credential-store
>> gcc: @CHARSET_LIB@: No such file or directory
>> make: *** [git-credential-store] Error 1
> Did you run the "configure" script?
Hum, I haven't.

Now I did.


> In the source folder, do you have either file "config.mak" or
> "config.mak.autogen" ?
After running ./configure, now I have.

> If you do, try removing them, and compile again.
> Which version are you compiling?
$ cat GIT-VERSION-FILE
GIT_VERSION = 1.7.12.84.gefa6462

> Did you get the source files from tar?
> Or from git?
From git (git://git.kernel.org/pub/scm/git/git.git).

OK, after running ./configure I tried the make command again.

CC credential-store.o
/bin/sh: clang: not found
make: *** [credential-store.o] Error 127

$ which clang
/home/tfarina/chromium/src/third_party/llvm-build/Release+Asserts/bin/clang

$ clang --version
clang version 3.2 (trunk 163674)
Target: x86_64-unknown-linux-gnu
Thread model: posix
