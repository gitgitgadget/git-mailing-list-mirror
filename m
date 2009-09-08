From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH] Add more instructions about how to install git.
Date: Tue, 8 Sep 2009 16:56:03 +0200
Message-ID: <237967ef0909080756g579f5359te7da19fded27596f@mail.gmail.com>
References: <1252386686-15689-1-git-send-email-tfransosi@gmail.com>
	 <81b0412b0909072244k21a4ddf6vdc38d9f713a4a084@mail.gmail.com>
	 <vpqhbvekldk.fsf@bauges.imag.fr>
	 <a4c8a6d00909080724q1c792f6bs641ea9d000d08b5a@mail.gmail.com>
	 <4AA66C54.4060101@viscovery.net>
	 <a4c8a6d00909080752p5b663fc8r8bf1c60023ef39b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 16:56:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml27A-0003ij-W8
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 16:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbZIHO4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 10:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbZIHO4D
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 10:56:03 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:64084 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbZIHO4C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 10:56:02 -0400
Received: by ewy2 with SMTP id 2so2845078ewy.17
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=9Dgpz65ZkjoUptNehr1TW8Hdbgfh6yBeI415fqmG/EI=;
        b=PgfPXUkr0x6e9ZSbtas52+Xx8IPG+f/en+SPtHto0inaSRNkFag/AHKk6rJKZkCgZ2
         s8vG+WBwUdwoi8jA4Mr6IltNitkMtonOVZZOKNprfyVCvWHhDddUy3LhEIL1LtktTXn0
         r1wiryRj97wVcGZRhBqSysqbXeNSy16XOSyUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=p5BCjwFgvAdPbT5HCuM+PelbJrt+hwvqoJealXYIdMkYAXQnJins7JwYRqVcef8sMD
         KXSXVAwSzvVQ9aQWVJfYsn4hWcnYM/Ji71IHDOMYso01xsrULHJR69E8obNH79a+PdHq
         66zNCxCTDKtrrHwYjoyGTxW2zzG5K3vlIrTUg=
Received: by 10.211.147.25 with SMTP id z25mr3333372ebn.84.1252421763533; Tue, 
	08 Sep 2009 07:56:03 -0700 (PDT)
In-Reply-To: <a4c8a6d00909080752p5b663fc8r8bf1c60023ef39b4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128012>

2009/9/8 Thiago Farina <tfransosi@gmail.com>:
> On Tue, Sep 8, 2009 at 10:38 AM, Johannes Sixt<j.sixt@viscovery.net> wrote:
>> Thiago Farina schrieb:
>>> I tried to being more explicit about what the new users has to do. The
>>> first instruction that the text says is: "Normaly you can just do
>>> "make"".
>>> But the new user, cloning git won't have a configure file, so he can't
>>> just do "make".
>>>
>>> And then, the text says: "so you can write instead". This brings me to
>>> one alternative (not what I really should do), when in fact it should
>>> be (I guess) the first instructions that new users need to follow.
>>
>> Then guessed wrong. You really only have to say "make". The use of
>> autoconf and ./configure is purely optional and not necessary.
> I don't think so.
> Running only "make".
> $ make
> GIT_VERSION = 1.6.5.rc0
>    * new build flags or prefix
>    CC fast-import.o
> In file included from builtin.h:4,
>                 from fast-import.c:143:
> git-compat-util.h:129:25: error: openssl/ssl.h: No such file or directory
> git-compat-util.h:130:25: error: openssl/err.h: No such file or directory
[snip]

You need to edit the Makefile if your system needs tweaks, there are tons
of comments.

> Running configure and then make
> $ make configure
> GIT_VERSION = 1.6.5.rc0.dirty
>    GEN configure
> $ make
>    CC fast-import.o
> In file included from builtin.h:4,
>                 from fast-import.c:143:
> git-compat-util.h:129:25: error: openssl/ssl.h: No such file or directory
> git-compat-util.h:130:25: error: openssl/err.h: No such file or directory

You forgot to run configure.

> Now autconf, ./configure, make.
> $ autoconf
> $ ./configure
> configure: Setting lib to 'lib' (the default)
> configure: Will try -pthread then -lpthread to enable POSIX Threads.
> configure: CHECKS for site configuration
> configure: CHECKS for programs
[...]
> checking for mkstemps... no
> checking Checking for POSIX Threads with '-pthread'... yes
> configure: creating ./config.status
> config.status: error: cannot find input file: config.mak.in
> $ make
>
> Now it compiles everything.

-- 
Mikael Magnusson
