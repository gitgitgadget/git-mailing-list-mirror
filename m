From: Patrick Donnelly <batrick@batbytes.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Mon, 23 Sep 2013 14:20:44 -0400
Message-ID: <CACh33FpP_Afb-9eke8m282saUZEDA_ZVbUQvKc6R3EF3P1ZvTA@mail.gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
	<20130921212904.GA235845@vauxhall.crustytoothpaste.net>
	<CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
	<20130921235647.GC235845@vauxhall.crustytoothpaste.net>
	<523e81f338f1e_547c41e7c166be@nysa.mail>
	<20130922073120.GC13262@paksenarrion.iveqy.com>
	<CAMP44s0Lww+se6iA2NWSwkeuLdR9mc0ppnVBSjWu4d73YeP6oA@mail.gmail.com>
	<20130922081250.GD13262@paksenarrion.iveqy.com>
	<CAMP44s3OYjv2LsU+6FY_qESdCvJcD4zb46aJmKpruof3hYEGzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:20:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOAkf-0000Fm-Hi
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab3IWSUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:20:47 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:55322 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab3IWSUq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:20:46 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so2805793lab.10
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 11:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=g3jhFoGKKQK32MsMc/B4OWgxmoKWKLH7gs/mGLNcuqE=;
        b=c3BYimA74Te8W9lyfSFnVK1D72luT+R/0IS/3WBsTANHPs8hBX4P1Ap7dMrCEn8kKk
         FubnM2pL6sfq7knI8pmR7CcAmKLzcU4XyaKTtb9FkqLtfeBVYSpRYtwzycQEEdW/kxf+
         IkE/uoaiCg8R20SaUVFGMYWdZI03s4qUp8eiWAVmIWEWehGW5bl7Mo7wPfJeYXdOTZWh
         cSEhh3vx63aSKzgDzboTLaa6T+l5yWwFIIAFLKOTDI51U1hOa8DwTGPjfFxVvo63xHJc
         JqJVvPnhQD/lkzyN/PBQlMwZLdu6LWeg9JoOUb9hcuCh1Nkx98v2lQ5gX5WbUzdyRJ3M
         JDYQ==
X-Gm-Message-State: ALoCoQnuPNR0JQvHiFKZqBCdx6J0F0ymE8Zq/8Wac11Br2Ixza0AVxbx8vqCteucIuWVRWw1QUy0
X-Received: by 10.152.120.37 with SMTP id kz5mr21131897lab.21.1379960444789;
 Mon, 23 Sep 2013 11:20:44 -0700 (PDT)
Received: by 10.112.155.137 with HTTP; Mon, 23 Sep 2013 11:20:44 -0700 (PDT)
In-Reply-To: <CAMP44s3OYjv2LsU+6FY_qESdCvJcD4zb46aJmKpruof3hYEGzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235212>

Hello Felipe,

On Sun, Sep 22, 2013 at 4:29 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, Sep 22, 2013 at 3:12 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
>> And see my humble test of what the speedup would be for git-submodule
>> even with a faulty lua integration (still forking... but huge
>> performance boost anyway):
>> http://thread.gmane.org/gmane.comp.version-control.git/228031/focus=228051
>
> I don't see how that is relevant, but I'm certain the same can be done
> with Ruby.
>
>> As you can see a lua integration would increase the git binary with
>> 300kb.
>
> And my patch would increase it 49Kb.

Unless you statically compile in Ruby (which is what the above quoted
300kb implied for Lua, in actually it is less than 200kb). [Also good
luck statically compiling Python/Ruby into an executable.]

> IMO the problem with lua is that it's too simple, it's syntax doesn't
> resemble c, perl, python, shell, or ruby, it's just weird. Also, it's
> much less popular, it's not as powerful, and there isn't a big
> community involved with Git like with Ruby.

*sigh*. At this point you've really cemented your purpose here as a
language evangelist. It's unfortunate I have to reply to dismiss this
FUD (which you complained about earlier, ironically) otherwise
community accepts it as fact ("oh, I remember some guys saying Lua was
a language for idiots...").

Lua is by no means *simple*. Try "small" or "lightweight". Its syntax
is engineered to be readable and amateur friendly. You've placed Ruby
on a pedestal alongside those other major languages but its syntax
doesn't resemble any of those.

>Also, it's much less popular

https://sites.google.com/site/marbux/home/where-lua-is-used

The hallmark of a good embedded language is your users don't even know
it is there.

>  it's not as powerful,

This is really funny to me. Despite Lua's small size, it has lead the
way for modern dynamic language features, such as coroutines, block
level scoping and real closure, incremental GC, a simple and usable C
API (*yes* this is a feature), and a register based VM [1]. It is
consistently placed as the *fastest* dynamic language in existence
[e.g. 2]? The LuaJIT compiler often achieves competitive or better
performance than C [3]. What about this isn't powerful?

[1] Ierusalimschy, Roberto, Luiz Henrique De Figueiredo, and Waldemar
Celes Filho. "The Implementation of Lua 5.0." J. UCS 11.7 (2005):
1159-1176.
[2] http://benchmarksgame.alioth.debian.org/u32/benchmark.php?test=all&lang=lua&lang2=yarv&data=u32
[3] http://luajit.org/performance_x86.html

-- 
Patrick Donnelly
