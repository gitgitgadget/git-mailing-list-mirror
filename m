Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CAAE20951
	for <e@80x24.org>; Fri, 17 Mar 2017 21:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdCQV1G (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 17:27:06 -0400
Received: from mout.web.de ([212.227.15.3]:60413 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbdCQV0M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 17:26:12 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M40na-1byoFa2CRO-00rVtq; Fri, 17
 Mar 2017 22:07:40 +0100
Subject: Re: fatal: Could not get current working directory: Permission denied
 | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     Stefan Beller <sbeller@google.com>
References: <elvahoiwfqayelbskykd@qjih>
 <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
 <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <ogwsaxvtiqlsiwojzxul@owpk>
 <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de> <tskgutqgpyszzedvyfra@prol>
 <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de> <ffntuqzgjgcfhebokbty@eduj>
 <7f25def4-9943-ae59-a649-b4348a79890e@web.de>
 <f6588ace-eecc-118d-ef26-70bc21dcc4d4@web.de>
 <CAGZ79kbpPBN21mbN2F20ikr6dXrKEcY=msqymaG8TOujeQF0jw@mail.gmail.com>
Cc:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <250f6b35-03c3-1fa8-8b6b-dfdc42660d8c@web.de>
Date:   Fri, 17 Mar 2017 22:07:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbpPBN21mbN2F20ikr6dXrKEcY=msqymaG8TOujeQF0jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:iGmQaMmS7Z3GbpAuuVlH9TIaDjuzMR4baBcM01qZFgrKnX6NjK6
 GRfykvWIzWAbsHwQk4+xahDGTtAXtKZrIrQykS5W2loWqRsmmTmQOKsu/F7/9PFlHiZv0s9
 tpmJt//S+OsdMWScjIXo6l/AKuy8bw8ZsugwAVk5i+PBdr/FS4fjAhCAWdd5JpChdEKxAgJ
 cofJJ1Sgf3IsJ63W2dW0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H4Wen7p/Gb4=:z+22cIL8etA+/+8B2KVHMj
 295sXY6bO/T3d5D8hxvFNpBZc6O65LkPXYfXVhnqWnhuLGkUVeXkLjPVWRYtGnyTC41J1lXvg
 RoFu/BOhNTGJidrb6DpUxuzT/NqhovjWKgE9dK8gBrUuencuOBKQcoOAYERIxFfPzcXadIIbZ
 Sut5sKtpzv269fr4YCvyqVG1oto+WeZ2y/gbl744TF1N4gI1nZOInRBN2aNoF0DIhHaxXqnm7
 h9fCdP1n1kIHuLk8FJUB1dkgFJTetPzDFbVsXBdm9kvJOEoA5VT5YQ7a5PyypxUt0G8v9pgXf
 LczbpE7Y4Axv4DNiGucBg3RR3S0Qc81BwoiktOFY204Ks78qWhXyjhXb36W7u6QDOLbpM/tmA
 BWKtmEqqeOnWnGYy4ox+3lMJQR40Cj95uKFAZkvoPxqOnQXsuCsOyAf2GeUvtI/ySE52RwXvf
 gd/ejEZadzVhfFrpLIzaRDjjKNm2pc+oB50WTMHl9ws+UAXaKBfA67DsJ3yHkAJCobB4LF3iW
 MOxpjFIxuamR7SH0CE0vznacnF4sWtutL9x4fFQXWNwaf+xO2sFysViiU9K0DUtqNwsxb4tXv
 3G+Bizi/S33XuMhW+45QSCZ5rihwJR/u8Y0LYoLMmAq5p2vctnXC7ruTnFdSORqEKGi3dhuKl
 asC0ieXp/pBAkTBFW1kWk+OiTcvFUeZdzn43q23oPnxgUFkh+w7YMAo3nPDuVfEQE2mCAYCqh
 nJoAj1snGa6DClxBuaQVoSRe+TEHFG5tDq8yH0adqxfC9GaEDqo8FRA4FW0mJZaGIo/6iaxRZ
 rhnANhe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.03.2017 um 20:45 schrieb Stefan Beller:
> On Fri, Mar 17, 2017 at 12:34 PM, René Scharfe <l.s.r@web.de> wrote:
>> Am 15.03.2017 um 22:30 schrieb René Scharfe:
>>> Am 15.03.2017 um 10:44 schrieb Zenobiusz Kunegunda:
>>>> $ git bisect bad
>>>> 7333ed1788b4f2b162a35003044d77a716732a1f is the first bad commit
>>>> commit 7333ed1788b4f2b162a35003044d77a716732a1f
>>>> Author: René Scharfe <l.s.r@web.de>
>>>> Date:   Mon Jul 28 20:26:40 2014 +0200
>>>>
>>>>     setup: convert setup_git_directory_gently_1 et al. to strbuf
>>>
>>> That's what I half-suspected, and I think by now I got an idea.  Here's
>>> a test program:
>>
>> And here's a patch for letting strbuf_getcwd() use the same getcwd(3)
>> extension that pwd(1) uses.  It avoids the need to guess the path's
>> length and thus reduces the chance of stumbling over strange error
>> codes.  I wonder if it helps in your case.
>>
>> René
>>
>> ---
>>  strbuf.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/strbuf.c b/strbuf.c
>> index ace58e7367..4c02801edd 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -442,6 +442,14 @@ int strbuf_getcwd(struct strbuf *sb)
>>  {
>>         size_t oldalloc = sb->alloc;
>>         size_t guessed_len = 128;
>> +       char *cwd;
>> +
>> +       cwd = getcwd(NULL, 0);
>
> from my local man pages:
>
>   As  an extension to the POSIX.1-2001 standard, Linux (libc4, libc5,
> glibc) getcwd()
>   allocates the buffer dynamically using malloc(3) if buf is NULL.  In
> this case, the
>   allocated buffer has the length size unless size is zero, when buf
> is allocated as big
>   as necessary.  The caller should free(3) the returned buffer.
>
> This sounds specific to Linux (though I am reading Linux man pages,
> which claim this; Also it seems I might have misread it as it also states
> "The pathname is returned as the function result and via the
> argument buf, if present.").

I'm only interested in FreeBSD for now, as that's the platform Zenobiusz 
reported the issue on and I haven't been able to reproduce it, so this 
is still a bit exploratory, but hopefully getting closer.  This 
extension is used in the first version of pwd(1) in FreeBSD's repo, 
comitted 1994-05-26, so it was supported there basically forever.

The oldest version I found that's using the extention is NetBSD's 
pwd(1), which was committed 1993-03-21 and carries a SCCS timestamp of 
1991-02-20.  Visual Studio .NET 2003 supports it as well.

> Looking further:
>
>   These functions are often used to save the location of the current
>   working directory for the purpose of returning to it later.  Opening the
>   current directory (".")  and  calling  fchdir(2)  to return is
> usually a faster
>   and more reliable alternative when sufficiently many file descriptors are
>   available, especially on platforms other than Linux.
>
> Not sure if that opens another door here?

Reducing the use of absolute paths may be a good idea in general, but 
that would probably require major changes.  And Windows doesn't seem to 
offer fchdir() at all; I don't know if it has an equivalent function 
that could be used to build a replacement.

René
