Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044D320188
	for <e@80x24.org>; Fri, 12 May 2017 08:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbdELI4o (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 04:56:44 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34946 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdELI4m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 04:56:42 -0400
Received: by mail-io0-f176.google.com with SMTP id f102so36246667ioi.2
        for <git@vger.kernel.org>; Fri, 12 May 2017 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5r/ogSykKnGySkzggrvCOS0JM3Vf+pu7LGvMtgMBZg0=;
        b=ENuEJuhOU2xP+2SUj4lr11ebbIzRSf0eFqfqD67UAHOmV6sb9BV4CSPJKzTM/aQedm
         nIlVn3eYZAmd4k9RQ5ScECXxdB4Bjlf64vvSkhTrM/0VUSR3mIU9sgWghCLB20OrDWT7
         FgeqeWihLucj9k7S0aE2D3x2DfyUuARjrunJewp+WZJvWY27CTI3+4iL8fQrEegtGleY
         Z3YMPJtUfgfEiyUAvZHvc9RfhC4ZyVdMY/JChTvFAq+jmvGpdOrrEg7Njc9fEa+awx5J
         bJoPfd8KeOOLI3UxNIjyCuGtdVaxBHu0oMC5guTq+/7N4hn5Tm08ukCvpOBUUFHL0WN9
         jfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5r/ogSykKnGySkzggrvCOS0JM3Vf+pu7LGvMtgMBZg0=;
        b=huoQieB3KDlgKkMXkvcu25mDmOl2MZxyupvs9OmL48Ns1mcjL7prXrAeOnnJE9hXFo
         eocX6pxap0CIu4qONeLaG6pdgOHrbFQaVOQFbZHsBtMwBSEJLEHI1Bjow6AAGJXlmw+/
         8bGeUT5AOPCTcKUdgZnYNL43UBMhRWLChOhvWF89Rf/FvLFYi9r8DBAyyIINSxp3aJ0r
         HcewZjw+vNf516ynbYY65HXJrZvLoW31mNoksymJK/A1325ZOIzMJAilsCY1OmJs8b5A
         hsVAOSEHw9u09rEHxJyAp1PqALc3mtq8hFlD+NoZc0XuNJcmSZBEzLwpR/jafhR6qS2b
         RSnA==
X-Gm-Message-State: AODbwcCZ2toFgBnEO5WrpaiaZZl25PCeLFLfA9gMSv4R4NCH8CBMm0Cu
        Xb2dp+ylBJLLx3djh4ujV4KJ7Nunew==
X-Received: by 10.107.201.131 with SMTP id z125mr2330709iof.160.1494579401515;
 Fri, 12 May 2017 01:56:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 12 May 2017 01:56:20 -0700 (PDT)
In-Reply-To: <xmqqlgq25us5.fsf@gitster.mtv.corp.google.com>
References: <xmqqpofe60dy.fsf@gitster.mtv.corp.google.com> <CACBZZX700n_nFvYxy0Z4M2cUqaOF0bNhLxJ9XJYGNDu8bk5HNg@mail.gmail.com>
 <xmqqlgq25us5.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 12 May 2017 10:56:20 +0200
Message-ID: <CACBZZX4jffaMFSUqgALetO4N1h8sgTm+4KFn_9qT5Rp3F25fSw@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #04; Fri, 12)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, May 12, 2017 at 8:43 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>> * ab/grep-preparatory-cleanup (2017-05-12) 15 commits
>>>  - grep: add tests to fix blind spots with \0 patterns
>>>  - grep: prepare for testing binary regexes containing rx metacharacter=
s
>>>  - SQUASH???
>>>  - grep: add a test helper function for less verbose -f \0 tests
>>>  - grep: add tests for grep pattern types being passed to submodules
>>>  - grep: amend submodule recursion test for regex engine testing
>>>  - grep: add tests for --threads=3DN and grep.threads
>>>  - SQUASH???
>>>  - grep: change non-ASCII -i test to stop using --debug
>>>  - grep: add a test for backreferences in PCRE patterns
>>>  - grep: add a test asserting that --perl-regexp dies when !PCRE
>>>  - log: add exhaustive tests for pattern style options & config
>>>  - test-lib: rename the LIBPCRE prerequisite to PCRE
>>>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
>>>  - Makefile & configure: reword inaccurate comment about PCRE
>>>
>>>  (what is queued here is only the early part of a larger series)
>>
>> What's the reason for only queuing it up to this point?
>
> No particular reason other than there is only so many hours in a day
> and running out of time reading and queuing patches.

Makes sense, just wondering if I should send the full thing as a v2 or
split it up. I'll just send the full thing.

>>> * ab/compat-regex-update (2017-05-12) 3 commits
>>>  - DONTMERGE compat/regex: make it compile with -Werror=3Dint-to-pointe=
r-cast
>>>  - compat/regex: update the gawk regex engine from upstream
>>>  - compat/regex: add a README with a maintenance guide
>>>
>>>  Update compat/regex we borrowed from gawk.  It seems that some
>>>  customizations we made to the older one were dropped by mistake.
>>
>> Do you prefer that I pick up JS's "compat/regex: fix compilation on
>> Windows" patch & re-send, or for you to add that on top after that
>> discussion is resolved?
>
> The tip one is what I did only to see if that is the only reason why
> Windows build is failing, without knowing Dscho did essentially the
> same one hours before.  I'd prefer to drop it myself, and ask you
> and Dscho to work the solution out, as I am farther than Dscho to
> the machinery that can be used to validate the fix ;-)

*Nod* will re-submit a version that works & incorporates that fix.
