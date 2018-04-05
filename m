Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A611F424
	for <e@80x24.org>; Thu,  5 Apr 2018 09:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeDEJnI (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 05:43:08 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41442 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeDEJnG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 05:43:06 -0400
Received: by mail-vk0-f67.google.com with SMTP id m69so12086747vka.8
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y1a9570NitEQzIb9Z/CSo0UbdE6twaidTUM5am0502s=;
        b=uyr1zr1lafaRRG9ht+6Hx/VmpTw0lWL4SMXkEb7zkcHg0fI/fI2cnBEFCLq5Co+2wv
         dfu0Kty9AL2bW2pdpIlbnddM6pd3v1j0qCWQZbXlJU7Sraxc1hI+eeJ+caS6hfk1bGvo
         YNSLp64x4VugRKwKqach1ppUY4MqwOCm/AWZq1KyovoBppMKc3D1oF8UwN0go7M/rKaD
         bGvUDD061M12DW4qccAoxZLBXyBhXQq1qM84IJqmvr2RgRiPquZF0pFM9HaxxA9MdFL9
         LnvEnfOhoJi2AxWk6Jb/0NC8gYx+/tuo1Gypo2+B58RU8cjYmzRoa0Bj/HtdonEMA20o
         ZfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y1a9570NitEQzIb9Z/CSo0UbdE6twaidTUM5am0502s=;
        b=hMKjC3pjLUPo5P2R2WzvGAGH8E/icpXasHRDqjbGJvHpGxezKz1VfOYOCZHuAaYRc7
         BnxBStAONurSRBIiA9hsaHnLzs9OX7uVN6gCAg00ovb19CY5T5hPYuTOBLty0jmutHzq
         Mp+9THHXa2RWvEiaJTcLHBuOXjGJmlOrhJORf13/ShOLm/aWjYE0NDna/ZtCJwJIQJT7
         8qHMNwJBoC4nm7rgDwv6bFgebxTK9XRyyPieZXAM8a6juFAMbjNT48CI2G8rS5bmeM3N
         kv3Z+ZKeT/Oe3zd4CHN5jEuUslwbxItA2teCmc05i+9V+cszeoCo47R9BeW42NFfDSgP
         Zf1Q==
X-Gm-Message-State: ALQs6tDcl36GAK5LTtFHb6ifo9K01+n4aVsW9HYagG779osxEbqQ1Dmc
        xi65fiQGyhbh7E5jb5bDuD1A5Wzj3kBVcgyBcEw=
X-Google-Smtp-Source: AIpwx4+Cxmd6pPVu2YTt50a+7IZIZNJ55l986A8N5tz/RDyu6iFi5eZbG0KOgtw90fwZLftzxVPnjT+hHau4Nzkx77E=
X-Received: by 10.31.107.15 with SMTP id g15mr12886142vkc.2.1522921385625;
 Thu, 05 Apr 2018 02:43:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Thu, 5 Apr 2018 02:43:05 -0700 (PDT)
In-Reply-To: <87605616vr.fsf@evledraar.gmail.com>
References: <0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com>
 <87605616vr.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 5 Apr 2018 11:43:05 +0200
Message-ID: <CAM0VKj=45wL7PyC-9-KE0drE=0UozoPKOmKbf9-caubfC2p_TA@mail.gmail.com>
Subject: Re: [PATCH] specify encoding for sed command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Stephon Harris <theonestep4@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 8:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Apr 05 2018, Stephon Harris wrote:
>
>> Fixes issue with seeing `sed: RE error: illegal byte sequence` when runn=
ing git-completion.bash

Please:
  - prefix the subject line with "completion:".
  - nit: replace "running" with "sourcing".
  - wrap the body of the commit message around 70 characters.
  - sign off your patch; see Documentation/SubmittingPatches and 'git
    commit -s'.

>> ---
>>  contrib/completion/git-completion.bash | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion=
/git-completion.bash
>> index b09c8a23626b4..52a4ab5e2165a 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -282,7 +282,7 @@ __gitcomp ()
>>
>>  # Clear the variables caching builtins' options when (re-)sourcing
>>  # the completion script.
>> -unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\=
)=3D.*/\1/p') 2>/dev/null
>> +unset $(set |LANG=3DC sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA=
-Z0-9_]*\)=3D.*/\1/p') 2>/dev/null

I was wondering how could you see an error message from 'sed', when the
stderr of the whole thing is redirected to /dev/null.  It turns out that
such a redirection doesn't affect the stderr of the commands executed
inside the command substitution:

  $ echo $(echo foo ; echo >&2 error) 2>/dev/null
  error
  foo

Interesting, I didn't know that.

> This is getting closer to the issue than your previous patch, but
> there's still some open questions:
>
> 1) What platform OS / version / sed version is this on?
>
> 2) What's the output from "set" that's causing this error? Do we have an
>    isolated test case for that?

A quick internet search suggests that this error message tends to appear
on Macs, when its 'sed' encounters an invalid UTF-8 character in its
input.

> 3) There's other invocations of "sed" in the file, aren't those affected
>    as well?

The two 'sed' invocations in _git_stash() are suspect, as they process
the output of 'git stash list', which includes the stashes'
descriptions, which can contain whatever the users wished to store there
(though they would probably get a "Warning: commit message did not
conform to UTF-8" message from 9e83266525 (commit-tree: encourage UTF-8
commit messages., 2006-12-22) when doing so).

The 'sed' invocation in __git_complete_revlist_file() is suspect as
well, as it processes the output of 'git ls-tree'.  Pathnames can
contain anything, and while 'git ls-tree' quotes pathnames with
"unusual" characters, I don't know whether it quotes all characters that
can possibly upset Stephon's 'sed'.

What about 'awk' on Stephon's platform?  We already have one 'awk'
invocation in __git_match_ctag(), which we use for 'git grep <TAB>' and
'git log -L:<TAB>'.  That 'awk' script uses a regexp to match the symbol
name in a ctags file; does any programming language allow such unusual
characters in symbol names?

What about 'sed' and 'awk' scripts that don't use regexps at all?  (I
intend to add such an 'awk' script in a day or two...)

> 4) Any reason we wouldn't just set LC_AlL=3DC for the whole file? I see w=
e
>    already do it for our invocation to "git merge".

That would perhaps be the safest thing to do...
But how can we set it for a whole file, when the file is not executed as
a script but sourced into the user's shell environment?
