Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 482D320988
	for <e@80x24.org>; Tue, 18 Oct 2016 17:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758317AbcJRRAm (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 13:00:42 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38724 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756688AbcJRRAl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 13:00:41 -0400
Received: by mail-wm0-f45.google.com with SMTP id z189so4284297wmb.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ioUcpUUa4zTitFURa/BgyBxjeqgX26PEi0W160CJN9M=;
        b=nsSZIoNi5N+9B5YduEvgY3HnpaaZ5YQhVaL4MlhnZS7XUefGwhVy0q4+jy0wVWT0IM
         4W4OMa3jL6UKtJmZRwh1BF5JCyUfrM1x3q1Xj8cLwMeMLBHJLdq9q9MXD7VCOEeuoBQV
         ouuwXtL+oqAq+POmOQQNsnxn51l+Qd5dATg8NGM4qcDeRtOwX8Pe2oVrIPuW9u9GdaAn
         ueT75pO1mbBh9wthTzAjAV5Gfubfw6nLMpwNMGVZIQgcni0kncb9Hf9FcoYU0rUH88nZ
         6LtWvxPm1yUix5Wx/+coXzdNbESOqwV6GmMpwrVNoFLQGTRNuFpZbiJEu57soKx6jpvP
         K2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ioUcpUUa4zTitFURa/BgyBxjeqgX26PEi0W160CJN9M=;
        b=D2upAIagnY3myI2i1UHeY8x/v7drEwAvJ2JPAFMFs0CTTrS/q12wpwoIZJJ8UIrx9C
         305ywICxbApcTVO1wyH1izCMtkIIcgzVWZ28EZq1MEiLULL9EuVkigE1uJQTL9qsW1ai
         XOk3y08M5ua1MDkk4g2G/OUHIC0Imc1DAQEhulQ9hWnugpPYJsH3YFW+YOK5rmc5igCX
         5zy9jquWBDime27DexZHrgYDS/FZXl/HqM8bCMjUA7bJhbjGYfLr9GQrACJjtwmxuIYf
         9XH+RDppr75NfV1dj/ZqD26ZbKvuT8NHm5oH9nAz94EbBaH6lE3fWCaPYvq62iEhLDhz
         llrA==
X-Gm-Message-State: AA6/9RnhkBLoBb/3QBuXfEVt66ftci6IGV5wI4g5YTCAA0O30LuQX+1K3Dvvfe6WFtQaEw==
X-Received: by 10.28.139.14 with SMTP id n14mr1466792wmd.112.1476810039237;
        Tue, 18 Oct 2016 10:00:39 -0700 (PDT)
Received: from p2003005f7d2520fb75ab403d6ee92a34.dip0.t-ipconnect.de (p2003005F7D2520FB75AB403D6EE92A34.dip0.t-ipconnect.de. [2003:5f:7d25:20fb:75ab:403d:6ee9:2a34])
        by smtp.gmail.com with ESMTPSA id io3sm43414852wjb.24.2016.10.18.10.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Oct 2016 10:00:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: git checkout crashes after server being updated to Debian X86_64
From:   Raffael Reichelt <raffael.reichelt@gmail.com>
In-Reply-To: <1c70da04-d26b-f0af-8939-edc96de586d9@web.de>
Date:   Tue, 18 Oct 2016 19:00:36 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE31577A-2172-402B-90AF-683283D26B2D@gmail.com>
References: <6B2BE996-F696-4EB4-91CA-849D40B8802D@gmail.com>
 <1c70da04-d26b-f0af-8939-edc96de586d9@web.de>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-Mailer: Apple Mail (2.3226)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Ren=C3=A8!
file is returning=20

/usr/bin/git: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), =
dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for =
GNU/Linux 2.6.32,  =
BuildID[sha1]=3Dee62e538d6fe6673d3ba49f0e66bfec784cc32bc, stripped

and ulimit is:
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 1
file size               (blocks, -f) unlimited
pending signals                 (-i) 16382
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 512
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) 1800
max user processes              (-u) 42
virtual memory          (kbytes, -v) 786432
file locks                      (-x) unlimited

Support told me git is limited to 600M

Regrads,
Rafael

> Am 18.10.2016 um 18:42 schrieb Ren=C3=A9 Scharfe <l.s.r@web.de>:
>=20
> Am 18.10.2016 um 17:17 schrieb Raffael Reichelt:
>> Hello!
>>=20
>> I have a serious problem with git, After my provider had updated to a
>> X86_64 architecture git crashes with various memory-related errors.
>> This is happening remote when pushing to the repository from my local
>> machine as well as trying it on a shell on the server itself.
>>=20
>> This are the error-messages:
>>=20
>> fatal: Out of memory, realloc failed
>> fatal: recursion detected in die handler
>> fatal: recursion detected in die handler
>>=20
>> or
>> fatal: unable to create threaded lstat
>> fatal: recursion detected in die handler
>> or
>> fatal: unable to create threaded lstat
>> *** Error in `git': double free or corruption (fasttop): =
0x0000000000a8ade0 ***
>> fatal: recursion detected in die handler
>> Aborted
>>=20
>> It=E2=80=99s obviously not a problem of the repository - happens with =
all of
>> them. I think it is also not a question of size - happens with a 80M
>> Repository as well as with a 500M one.
>>=20
>> Any way: did a
>>=20
>> git fsck
>> Pr=C3=BCfe Objekt-Verzeichnisse: 100% (256/256), Fertig.
>> Pr=C3=BCfe Objekte: 100% (56305/56305), Fertig.
>>=20
>> git gc --auto --prune=3Dtoday =E2=80=94aggressive
>> git repack
>>=20
>> Additionally I played around some config parameters  so my config now =
looks like:
>> [http]
>>    postbuffer =3D 524288000
>> [pack]
>>    threads =3D 1
>>    deltaCacheSize =3D 128m
>>    packSizeLimit =3D 128m
>>    windowMemory =3D 128m
>> [core]
>>    packedGitLimit =3D 128m
>>    packedGitWindowSize =3D 128m
>>    repositoryformatversion =3D 0
>>    filemode =3D true
>>    bare =3D true
>>=20
>> I am running
>> git version 2.1.4
>>=20
>> on
>> Linux infongp-de65 3.14.0-ui16196-uiabi1-infong-amd64 #1 SMP Debian =
3.14.73-2~ui80+4 (2016-07-13) x86_64 GNU/Linux
>>=20
>> Anyone out there to help me getting out of this trouble?
>=20
> Git 2.1.4 is the version that comes with Debian stable according to =
https://packages.debian.org/jessie/git, so I guess using a more recent =
version is not a reasonable option.
>=20
> What do "file $(which git)" and "ulimit -a" return?  Do you have an =
x86-64 binary and no unnecessarily low limits set?
>=20
> Ren=C3=A9

