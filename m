Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6ECC1F829
	for <e@80x24.org>; Tue,  2 May 2017 08:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbdEBIYO (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 04:24:14 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34062 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdEBIYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 04:24:11 -0400
Received: by mail-io0-f181.google.com with SMTP id a103so147627563ioj.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 01:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rtYHJ9W5SfRiIQY2gMgl8qWGc8nkwS8lG99Kmv5DjaA=;
        b=jg1MFG30UlQIENXqmNufYU4ua7R38fp5ZLOj/NPAGQHneGV/M2SWdcSohERyKQzcPj
         XIEp9W9gK/aDMHGe13pIatrnJ7WmQcf/mqcwX6FS6AB9t1ZhReNY3CjQqwT4YrrLhEG+
         /3JJHi/UtXDok9PtOn+EBUTGKmMslFlRDSEa8s8urr8yXxiCONRXx0OYEJDJ/czcp8rY
         WgKGT4Vuju9+fzCSg4nhHjC9DtWw/1nwomqys5BPaob0XOfaPlu+BWS0XhDk4DyIhg6j
         TeaBoAy0/1JkzIE2WfQqy8lj4JvRXVk3g2MJ5DzA0cJiXlGAL411Z6//wB5JittaJmPK
         wU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rtYHJ9W5SfRiIQY2gMgl8qWGc8nkwS8lG99Kmv5DjaA=;
        b=BIrrglZznDgsYQCbmZM+vkXK5SdraJnRx2ABVlkNbQdebhNq4NZbdeouW/WqoIyygi
         DI5qhTZlpw+YhUzgKe87WLhTOplV7/todsxZ2xZrk44iRysITb46JZwTQ1wsmJvBS52V
         gLZVxBZT4VJIFSe1CJul434hjTqTF9JuEt9hFUDsEC037bLnwsRrjshBnk3OjxXl+B6H
         eZnLrplCnRFVb/BgSeCR8ogqvkctFQgGCKTxpS/DGchCOQob9Bbw+K8kgLG6aogItD/B
         rd/nwAnCuawWog1Rpp7sXhaJJWD9ABsZReOnIi+3Ghl0NCjvh3XTllM3lh+bIlnGmCpW
         zRnQ==
X-Gm-Message-State: AN3rC/4W9kkp2n/pHG/kc5Kx0tOHRvOjjBXhmQcEJjeaUanbt85leZ1m
        RUHxv68xI9KiTIAWrdT/XOaxqo7p2Q==
X-Received: by 10.107.178.129 with SMTP id b123mr25766341iof.50.1493713447802;
 Tue, 02 May 2017 01:24:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 2 May 2017 01:23:46 -0700 (PDT)
In-Reply-To: <xmqqa86wgo33.fsf@gitster.mtv.corp.google.com>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <CACBZZX4ty91vh=ykMtpF0pV8Ru3BKWBXyQYsFRdPkKkxMd8pzw@mail.gmail.com>
 <xmqqa86wgo33.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 2 May 2017 10:23:46 +0200
Message-ID: <CACBZZX5N0L_M9b4RTRLSvcA2u69H=s=S-VEc-Nr71wW6Scyjvw@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #01; Mon, 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 1:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> * ab/grep-pcre-v2 (2017-04-25) 20 commits
>>>  - SQUASH???
>>>  - Makefile & configure: make PCRE v2 the default PCRE implementation
>>>  - grep: remove support for concurrent use of both PCRE v1 & v2
>>>  - grep: add support for PCRE v2
>>>  - grep: add support for the PCRE v1 JIT API
>>>  - perf: add a performance comparison test of grep -E and -P
>>>  - grep: change the internal PCRE code & header names to be PCRE1
>>>  - grep: change the internal PCRE macro names to be PCRE1
>>>  - test-lib: rename the LIBPCRE prerequisite to PCRE
>>>  - grep: make grep.patternType=3D[pcre|pcre1] a synonym for "perl"
>>>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
>>>  - log: add -P as a synonym for --perl-regexp
>>>  - log: add exhaustive tests for pattern style options & config
>>>  - grep: add a test for backreferences in PCRE patterns
>>>  - Makefile & configure: reword outdated comment about PCRE
>>>  - grep: remove redundant `regflags &=3D ~REG_EXTENDED` assignments
>>>  - grep: remove redundant regflags assignment under PCRE
>>>  - grep: submodule-related case statements should die if new fields are=
 added
>>>  - grep: add tests for grep pattern types being passed to submodules
>>>  - grep: amend submodule recursion test in preparation for rx engine te=
sting
>>>
>>>  PCRE2, which has an API different from and incompatible with PCRE,
>>>  can now be chosen to support "grep -P -e '<pattern>'" and friends.
>>
>> That squash looks good to me.
>
> Thanks.
>
> That is not a particulary helpful comment, by the way.  I can help
> topics by contributors by queuing emergency fix at the tip to make
> ones that do not build correctly buildable and testable (which is
> what the "SQUASH???" commits are about), but I'd rather not see me
> forced to find among 19 commits which one is broken and needs the
> hotfix squashed in myself.

I'm happy to change what I'm doing to be more helpful, but it's not
clear to me from this & the context what that would be.

* I sent a v4 that had this bug in <20170425210548.24612-6-avarab@gmail.com=
>
* You pointed out that initialization bug in response
* I sent a v5 of just that patch (not the rest of the series) in
response to that in <20170426074856.29903-1-avarab@gmail.com>
* You replied in <xmqq1sser7ty.fsf@gitster.mtv.corp.google.com> in a
reply I (probably mis-)read as "no worries, I'll just squash the fix
in"

So now a ~week later in WCIG you've taken the series but added that
squash instead of using my v5 of that one patch, that looks good to me
(i.e. your hotfix does the same thing as my v5) but you don't think
that's a helpful comment.

So what would you like to have happen instead? If it's easier I could
just re-sent a v6 of the whole thing and we could do away with this
squash/replace-one-patch dance.

>>> * ab/grep-threading-cleanup (2017-04-16) 8 commits
>>>  - grep: given --threads with NO_PTHREADS=3DYesPlease, warn
>>>  - pack-objects: fix buggy warning about threads under NO_PTHREADS=3DYe=
sPlease
>>>  - pack-object & index-pack: add test for --threads warning under NO_PT=
HREADS
>>>  - tests: add a PTHREADS prerequisite
>>>  - grep: skip pthreads overhead when using one thread
>>>  - grep: don't redundantly compile throwaway patterns under threading
>>>  - grep: add tests for --threads=3DN and grep.threads
>>>  - grep: assert that threading is enabled when calling grep_{lock,unloc=
k}
>>>
>>>  Code cleanup.
>>>
>>>  Needs review.
>>
>> Between these two series there's 27 patches, and I understand it's a
>> bit of a PITA to review/get comments on it.
>>
>> Anything I should be doing differently here other than just waiting
>> for 2.13 to come out so they can be cooked further & merged down to
>> next & then master if there's no objections?
>
> There are topics that need fresh eyes to be reviewed by other
> contributors, so perhaps you can help unblock them by reviewing,
> while they pick lints from yours?

*nod*
