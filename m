Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18BE61F404
	for <e@80x24.org>; Sun,  8 Apr 2018 19:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDHTbm (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 15:31:42 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:33654 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeDHTbl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 15:31:41 -0400
Received: by mail-pl0-f42.google.com with SMTP id s10-v6so3822059plp.0
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M77B3ms4KyGfbj+g/ug3I6zMO9dn1iNGjsoo5K0tqoo=;
        b=cI7+Ib2gr6ZuVSIUbX7wYZOKRw1SBxPpAoXQX8+Nqx1NMMU3Q6w0J+pXlgD54gm4xM
         zrqQGEioZH/C2MaDTXVVJ0zpCi2hi9q8OWkOTGflAzI4Osmm4ZHcMbTtyzTHa1eI1vJU
         lWKrB2habu95uWPz9fKNXQaQct4CMcPAhjoSIVQ8ulFTa1cfDik9KiIG6v0rXb8+SWbo
         2ZgDMIupMWZXlcjAvbkiKZzhHneKScqVClZ8BpAROapuEudniPajIcFhwJv9FAihIAgr
         zwIYa6Y/JPiumDZW+ZscAJYQksqq/w1vHpl2K3kCra8KDg7DqRtoezYML32VAweSXEOA
         vidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M77B3ms4KyGfbj+g/ug3I6zMO9dn1iNGjsoo5K0tqoo=;
        b=JLcrHRb+xXqQoPaf2qwmH2FDwqChTqz0PCQEoHUhSxvDbHWkKn+/VVrEMh3kr8F7Cj
         BE82K+Z5BRCK29QkIV0PCIr7S22gBspT52gPe9XTcEdMdKoLqPA8JM45ijdHkIFK9lpo
         UTRCT+6dqc9uaYuyl9OerXkI4CM7fMPa6htJedK1EV83KgIpYUx/wZYPzFoasuNz63oq
         nFUJ1RWTY+dP81NGZzdtNoUpdxLJz2Wv26/4HhOF/z8yfhpRkXFb68xmSWVyHdF7lCqM
         e91Q52aftcuPV44TrMoN3GDDt1ufBTUmRhudP/CyPJWtwyWB/QAjy5C5RUqYzEys2l5O
         n0dQ==
X-Gm-Message-State: ALQs6tDNRzFvAuxKGKrI9DHFnXSvhcCNZzoZ1Kj3DvYkhVJwQysaPVqC
        8dc7v3UG/zDzuCD5l/79zDAfmM1SCe0/Ax8Py+M=
X-Google-Smtp-Source: AIpwx48yZs9V88puXtXd4TzNM2aqof0Y7bqt/pGam/cW8rMjoRjG8dGeZRtKCA4tw4CENALZGXtq4wg3a/H4M8BgX5c=
X-Received: by 2002:a17:902:748c:: with SMTP id h12-v6mr6094589pll.264.1523215900298;
 Sun, 08 Apr 2018 12:31:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.149.77 with HTTP; Sun, 8 Apr 2018 12:31:19 -0700 (PDT)
In-Reply-To: <20180406194845.GB11450@sigill.intra.peff.net>
References: <CAJZK4X4-AZ6uEoVbAtQ9ErdJ2guKj9puXcpdX_3igBNPdQNp5A@mail.gmail.com>
 <20180406194845.GB11450@sigill.intra.peff.net>
From:   Satya Prakash GS <g.satyaprakash@gmail.com>
Date:   Mon, 9 Apr 2018 01:01:19 +0530
Message-ID: <CAJZK4X4Y5RqKww3thWBb5hCbSDWuxqDBRbY5EeOAB66ugaHVLg@mail.gmail.com>
Subject: Re: reg. fatal: The remote end hung up unexpectedly on NFS
To:     Jeff King <peff@peff.net>, avarab@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avarab,

I enabled GIT_TRACE, packet, etc. I could not make much sense of the
output. I downloaded git source and started looking at the code.
Yeah, kernel compilation with failovers worked on our filesystem. We
tried xfs test suite with failovers, it worked. Since it's failing
with open source NFS, I am wondering if this even has anything to do
with filesystem.

Jeff,

Thank you for the clear instructions on strace.

Looks like 5 and 6 are two ends of a pipe.

read(5, "\27\3\3\5r", 5)          = 5
read(5, "S\10n\230i\257\27\2\333&\335jou~\3036}S\273\212\250\33\310\216b\253\3505\332\266X"...,
1394) = 1394
write(6, "\2530\253x\27\247iz\246\321*\v\33\306.\221I\36\4\304D\\\360\361\306I\213\304\245m\247\30"...,
1370) = 1370
<... read resumed>
"\2530\253x\27\247iz\246\321*\v\33\306.\221I\36\4\304D\\\360\361\306I\213\304\245m\247\30"...,
5071) = 1370
rt_sigaction(SIGPIPE, {SIG_IGN, [PIPE], SA_RESTORER|SA_RESTART,
0x7f038e8bb890},  <unfinished ...>
read(0,  <unfinished ...>
<... rt_sigaction resumed> NULL, 8) = 0
poll([{fd=5, events=POLLIN}], 1, 1000) = 1 ([{fd=5, revents=POLLIN}])
rt_sigaction(SIGPIPE, NULL, {SIG_IGN, [PIPE], SA_RESTORER|SA_RESTART,
0x7f038e8bb890}, 8) = 0
rt_sigaction(SIGPIPE, {SIG_IGN, [PIPE], SA_RESTORER|SA_RESTART,
0x7f038e8bb890}, NULL, 8) = 0
poll([{fd=5, events=POLLIN|POLLPRI|POLLRDNORM|POLLRDBAND}], 1, 0) = 1
([{fd=5, revents=POLLIN|POLLRDNORM}])
read(5, "\27\3\3\5r", 5)          = 5
read(5, "S\10n\230i\257\27\3]T\0{\232\253\377$\265\277\211o.\314T\315\257\335j\322\367\31o\262"...,
1394) = 1394

>>>>>>>>>>>>> Write preceding the last read has succeeded
write(6, "\237%\204W$\236\177\305@\210+\236\227.\316\226\250\t\256:\27?};\270^A\317\204\222\35]"...,
1370) = 1370
>>>>>>>>

<... read resumed>
"\237%\204W$\236\177\305@\210+\236\227.\316\226\250\t\256:\27?};\270^A\317\204\222\35]"...,
3701) = 1370
rt_sigaction(SIGPIPE, {SIG_IGN, [PIPE], SA_RESTORER|SA_RESTART,
0x7f038e8bb890},  <unfinished ...>
read(0,  <unfinished ...>
<... rt_sigaction resumed> NULL, 8) = 0
poll([{fd=5, events=POLLIN}], 1, 1000) = 1 ([{fd=5, revents=POLLIN}])
rt_sigaction(SIGPIPE, NULL, {SIG_IGN, [PIPE], SA_RESTORER|SA_RESTART,
0x7f038e8bb890}, 8) = 0
rt_sigaction(SIGPIPE, {SIG_IGN, [PIPE], SA_RESTORER|SA_RESTART,
0x7f038e8bb890}, NULL, 8) = 0
poll([{fd=5, events=POLLIN|POLLPRI|POLLRDNORM|POLLRDBAND}], 1, 0) = 1
([{fd=5, revents=POLLIN|POLLRDNORM}])
read(5, "\27\3\3\5r", 5)          = 5

>>>>> Problematic reads
read(5, "S\10n\230i\257\27\4\220\243\375\3772\213?\267\356V\246r\226`\223\253^\310\314\207\222\22%\376"...,
1394) = 363
read(5, "", 1031)                 = 0
>>>>>>>>>>>>>>>

write(5, "\25\3\3\0\32\265(Nk5\330Y\4!\374S\204\377\304\0166j\rV\305;e3\347&w",
31) = 31
close(5)

rt_sigaction(SIGPIPE, {SIG_IGN, [PIPE], SA_RESTORER|SA_RESTART,
0x7f038e8bb890}, NULL, 8) = 0
rt_sigaction(SIGPIPE, {0x441ed0, [PIPE], SA_RESTORER|SA_RESTART,
0x7f038e8bb890}, NULL, 8) = 0
write(2, "error: RPC failed; result=18, HT"..., 46) = 46
brk(0x1597000)                    = 0x1597000
close(6 <unfinished ...>
<... read resumed> "", 2331)      = 0
<... close resumed> )             = 0
read(7, "0000", 4096)             = 4
write(2, "fatal: The remote end hung up un"..., 43 <unfinished ...>
read(7,  <unfinished ...>
<... write resumed> )             = 43
close(4 <unfinished ...>
<... read resumed> "", 4096)      = 0
<... close resumed> )

Last read from pipe (fd 5) was a partial read. Write has succeeded on
the pipe but read failed, that's strange. In this case, it doesn't
even look like the write was interleaved.

Thanks,
Satya.

On Sat, Apr 7, 2018 at 1:18 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 06, 2018 at 11:55:51PM +0530, Satya Prakash GS wrote:
>
>> We have a distributed filesystem with NFS access. On the NFS mount, I
>> was doing a git-clone and if NFS server crashed and came back up while
>> the clone is going on, clone fails with the below message:
>>
>> git clone https://satgs@github.com/fs/private-qa.git
>>
>> remote: Counting objects: 139419, done.
>> remote: Compressing objects: 100% (504/504), done.
>> Receiving objects:   7% (9760/139419), 5.32 MiB | 5.27 MiB/s
>> error: RPC failed; result=18, HTTP code = 200 MiB | 96.00 KiB/s
>> fatal: The remote end hung up unexpectedly
>> fatal: early EOF
>> fatal: index-pack failed
>
> Curl's result=18 is CURLE_PARTIAL_FILE. Usually that means the other
> side hung up partway through. But given the NFS symptoms you describe, I
> wonder if fwrite() to the file simply returned an error, and curl gave
> up.
>
>> On NFS server crash, it usually takes a minute or two for our
>> filesystem to failover to new NFS server. Initially I suspected it had
>> something to do with the filesystem, like attributes of the file
>> written by git weren't matching what it was expecting but the same
>> test fails on open source NFS server. While clone is going on, if I
>> stopped the open source NFS server for 2 minutes and restarted it, git
>> clone fails.
>>
>> Another interesting thing is, if the restart happens within a few
>> seconds, git clone succeeds.
>>
>> Sideband_demux fails while trying to read from the pipe. Read size
>> doesn't match what is expected. If there are 2 parts to git clone
>> which is fetching data and writing to local filesystem, is this error
>> happening while trying to fetch ? Since it succeeds if the restart is
>> done immediately, has this got something to do with the protocol
>> timeouts.
>>
>> Please advise on how to debug this further.
>
> If you're on Linux, strace could show you the write error. Unfortunately
> it's a little tricky because the http bits happen in a sub-process. But
> try:
>
>   cat >/in/your/$PATH/git-remote-strace <<\EOF
>   #!/bin/sh
>   protocol=$(echo "$2" | cut -d: -f1)
>   exec strace -f -o /tmp/foo.out git-remote-$protocol "$@"
>   EOF
>   chmod +x /in/your/$PATH/git-remote-strace
>
>   git clone strace::https://github.com/whatever
>
> My guess is you may find a failed `write()` in there.
>
> -Peff
