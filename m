Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3204C1F89D
	for <e@80x24.org>; Fri, 28 Jul 2017 15:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbdG1P0u (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 11:26:50 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32877 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbdG1P0t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 11:26:49 -0400
Received: by mail-oi0-f66.google.com with SMTP id e124so17538902oig.0
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yxjsmc+DcCOJgtPKmp8/PEmstR7xBOfDdSzbbQCuT/g=;
        b=bGWKjfCkN+4by4hstmeOd+vgTtNFrW/S+XR69OBQSdgawcu58RikdZLGancAUHrPSd
         UlxM2oAdsoOC1xmpmhaswWvbBqF9XhB9+cQtncZSRvUdVaYSTcjCV4srUfgWrIPlOxUK
         Io4Z/1bZTLg8xxnUdEdePEsdKVD26TKOsUSNcQyrMANMpQ3ZcGD15joW04r+rLqA0nKB
         ujK827hHRi+kg7qIN/JVdPDL+pqlWe9cmlYZn/fcUs05522EsklLHxNyjs1ebBbs7irG
         7qkAtm41i8+U+ltXXs1qjienJrG3RHOryKHTDCxDW81nICv7cKPLoykvxp3vvktbo1q7
         hoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yxjsmc+DcCOJgtPKmp8/PEmstR7xBOfDdSzbbQCuT/g=;
        b=Wcf0p3TqrahmRKVur/fCJWnfeO4w1LdDID2vi01WTYklRf+Zdbz+XNp/0sNongUbBG
         ZUWfxGea4TcABh0h6SjjXx7tfPq55zYuXMrpX41+dSNLPHoTj/724CoSa3uCOAZpfYFy
         R364K7vPuIuq/516GwZziQTZLy2Z7VdvJP9xh0NeoHiXdqRxyK/D7Q5Zky3MJMziAxWO
         E6in1Zm4NYlQ+LV6oeAqnRcrxAlassDH6QE9U2fqmiCqVWXuMQVI7Rq/9E0K/RWfKDvI
         EpNpoG7m5vyN80GQE8nBGGoGtrm1gpjb73BWQLZPrq2vbV4N1VCKfIwX0T5aglQOhW9Q
         r1sw==
X-Gm-Message-State: AIVw112cEeXmJEVX2WuW1ElNYqL+d3EPp7dZfhITlDqx4kIbcreUv0LH
        mGR/A59R0Wg+vQ==
X-Received: by 10.202.79.84 with SMTP id d81mr6907328oib.50.1501255608508;
        Fri, 28 Jul 2017 08:26:48 -0700 (PDT)
Received: from [10.3.3.91] ([12.5.200.156])
        by smtp.gmail.com with ESMTPSA id r136sm8614718oie.20.2017.07.28.08.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 08:26:47 -0700 (PDT)
Subject: Re: requesting permission to use some Git for Windows code
To:     Brandon Casey <drafnel@gmail.com>,
        Philippe Joyez <philippe.joyez@cea.fr>
Cc:     Joris van der Hoeven <vdhoeven@lix.polytechnique.fr>,
        git-for-windows@googlegroups.com,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <a730cebb-1782-f32b-0b7c-253bd61475d6@cea.fr>
 <alpine.DEB.2.21.1.1706281259170.84669@virtualbox>
 <CA+sFfMcAtStAfoc6Zaq7zW3cmYLu1QMX9_mmrRWe=M_GJYDeyw@mail.gmail.com>
From:   Marius Storm-Olsen <mstormo@gmail.com>
Message-ID: <d8fc1fdb-f326-d71d-f496-8293ed14bf68@gmail.com>
Date:   Fri, 28 Jul 2017 10:26:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CA+sFfMcAtStAfoc6Zaq7zW3cmYLu1QMX9_mmrRWe=M_GJYDeyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ditto, on any of my portions, if any left :)

-- 
.marius

On 7/28/2017 00:31, Brandon Casey wrote:
> Hi Philippe,
>
> Please feel free to use my portions of the mentioned works under the GPLv3.
>
> -Brandon
>
> On Tue, Jul 25, 2017 at 6:53 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Philippe,
>>
>> I am not quite certain whether I have replied to this earlier or not.
>> Under the assumption that I did not, I'll send this mail; Cc:ed to the
>> mailing lists as discussed privately.
>>
>> On Fri, 23 Jun 2017, Philippe Joyez wrote:
>>
>>> This message is to request the permission to use code chunks from Git
>>> for Windows in GNU TeXmacs <http://texmacs.org/>, to which I contribute.
>>> The main developer of TeXmacs is Joris van der Hoeven (in cc).
>>>
>>> Context:
>>>
>>> Just like Git, TeXmacs originated on *nix platforms and was subsequently
>>> ported to windows using MinGW. Naturally, some issues we have in that
>>> port are the very same Git for Windows has faced.
>>>
>>> One specific problem you have solved and that TeXmacs still hasn't, is
>>> dealing with unicode filenames. By taking relevant pieces of code in Git
>>> for windows, I could easily come up with a patch that enables TeXmacs to
>>> handle unicode filenames in windows.
>>>
>>> Now, the problem is that Git code is GPL V2, while TeXmacs is GPL V3:
>>> Incorporating my patch in TeXmacs' trunk would be a violation of GPL
>>> V2... /unless/ we are granted the permission to do so by the authors of
>>> the code. This is precisely the reason for this message.
>> It is great that you can make use of the code!
>>
>> As to the licensing problem, I agree it is a hassle. The biggest obstacle
>> is that you have to have the consent of all the authors.
>>
>> You hereby have mine.
>>
>>> The chunks of code we would like to reuse are from these Git for Windows
>>> files:
>>> git-compat-util.h
>> This file is quite large, maybe you can cut down on the authors to contact
>> by restricting the `git annotate`/`git log`/`git shortlog` calls to
>> specific parts, using the `-L <start-line-no>,<end-line-no>` option?
>>
>>> ctype.c
>> $ git shortlog -nse ctype.c
>>       5  Junio C Hamano <gitster@pobox.com>
>>       4  René Scharfe <l.s.r@web.de>
>>       2  Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>>       1  Ben Walton <bdwalton@gmail.com>
>>       1  Brandon Casey <drafnel@gmail.com>
>>       1  Gary V. Vaughan <git@mlists.thewrittenword.com>
>>       1  Linus Torvalds <torvalds@linux-foundation.org>
>>       1  Namhyung Kim <namhyung@gmail.com>
>>
>> I *think* Ben Walton's change (189c860c9ec (kwset: use unsigned char to
>> store values with high-bit set, 2015-03-02)) is not copyright-able, as it
>> only changes the type from signed to unsigned. But I am not a lawyer ;-)
>>
>> Likewise, Namhyung Kim's change (1a191a22959 (ctype.c only wants
>> git-compat-util.h, 2012-02-10)) only changes which header is included.
>> That seems to be a too-obvious/too-trivial change to me.
>>
>> Also, it looks as if removing a comma as was done in 4b05548fc05 (enums:
>> omit trailing comma for portability, 2010-05-14) by Gary V. Vaughan would
>> not merit any copyright.
>>
>> If in doubt, you could simply take the version of ctype.c with those
>> changes reverted as basis of your work.
>>
>> You still have to get the consent of Junio, René, Duy, Brandon and Linus
>> to relicense the file's contents.
>>
>>> compat ¬
>>>     mingw.c
>> I count 35 authors other than myself for that file... Maybe you can narrow
>> down what you need?
>>
>>>     mingw.h
>> Still 29 authors other than me...
>>
>>>     win32.h
>> This is more manageable, as it only saw three authors. But then, you could
>> simply reimplement the functionality, it's just two functions, and I do
>> not think that get_file_attr() is implemented in the best way: we have a
>> function called err_win_to_posix() in compat/mingw.c which is much more
>> complete.
>>
>> Having said that, err_win_to_posix() is still not implemented in the best
>> way. The best way is to abuse Windows' own (undocumented) _doserrmap()
>> function along with the information in the header files winerror.h and
>> errno.h to generate the mapping. Those two files, as per mingw-w64's
>> headers, have the very nice preamble:
>>
>>          /**
>>           * This file has no copyright assigned and is placed in the Public Domain.
>>           * This file is part of the mingw-w64 runtime package.
>>           * No warranty is given; refer to the file DISCLAIMER.PD within this
>>           * package.
>>           */
>>
>> Therefore, the result has no copyright assigned and is placed in the
>> Public Domain and we can do the very same, too.
>>
>> As I wanted to have a Windows error -> errno mapping that I could
>> relicense as I see fit, anyway, I took this as an excellent opportunity to
>> generate exactly that.
>>
>> Please find the header attached. Here is how I generated that header file:
>>
>> -- snip --
>> cat >/tmp/generrmap.c <<EOF &&
>> #include <windows.h>
>> #include <stdio.h>
>>
>> static void map_code(unsigned long code, const char *id);
>>
>> int _main(int argc, char **argv)
>> {
>>          printf("/* This file has no copyright assigned and is placed in the "
>>                  "Public Domain. */\\n"
>>                  "\\n"
>>                  "#ifndef WINERR2ERRNO_H\\n"
>>                  "#define WINERR2ERRNO_H\\n"
>>                  "\\n"
>>                  "static int winerror2errno(long code)\\n"
>>                  "{\\n");
>> $(sed -n 's/^#define \([^ ]*\) __MSABI_LONG([1-9].*/\tmap_code(\1, "\1");/p' \
>>          </mingw64/x86_64-w64-mingw32/include/winerror.h)
>>          printf("\\tdefault: errno = EINVAL;\\n"
>>                  "\\t}\\n"
>>                  "\\n"
>>                  "\\treturn -1; /* Typical return value when errno was set */\\n"
>>                  "}\\n"
>>                  "\\n"
>>                  "#endif /* WINERR2ERRNO_H */\\n");
>>          fflush(stdout);
>>          return 0;
>> }
>>
>> /* Undocumented function in the MSVCRT */
>> extern void _dosmaperr(unsigned long code);
>>
>> static const char *errno2constant(int err, const char *id)
>> {
>>          switch (err) {
>> $(sed -n 's/^#define \([^ ]*\) \([0-9]*\)$/\tcase \2: return "\1";/p' \
>>          </mingw64/x86_64-w64-mingw32/include/errno.h)
>>          default:
>>                  fprintf(stderr, "Unhandled err: %d (for %s)\\n", err, id);
>>                  exit(1);
>>          }
>> }
>>
>> static void map_code(unsigned long code, const char *id)
>> {
>>          errno = 0;
>>          _dosmaperr(code);
>>          if (!errno) {
>>                  fprintf(stderr, "Unhandled id: '%s' (%ld)\\n", id, code);
>>                  exit(1);
>>          }
>>          if (errno != EINVAL)
>>                  printf("\\tcase %s: errno = %s;\\n",
>>                          id, errno2constant(errno, id));
>> }
>> EOF
>> gcc -g -nostdlib -o /tmp/generrmap.exe /tmp/generrmap.c -lmsvcr120 &&
>> /tmp/generrmap
>> -- snap --
>>
>>>     win32 ¬
>>>          dirent.c
>>>          dirent.h
>> I encourage you to have a look whether you really need that full-fledged
>> functionality.
>>
>> For vaguely related work, I recently reimplemented this differently, for
>> use in BusyBox-w32, where we really only need to have the file names. The
>> implementation is a lot cleaner, and I am happy to relicense this to
>> whatever license you see fit (even BSD):
>>
>>          https://github.com/git-for-windows/busybox-w32/commit/b76eee3aca
>>
>>>          lazyload.h
>> This one was authored by me, and I am happy to relicense it to GPLv3. Or
>> whatever license, really.
>>
>> Ciao,
>> Johannes

