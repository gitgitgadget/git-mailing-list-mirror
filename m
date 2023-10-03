Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C21E8FDB1
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbjJCUKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjJCUKA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:10:00 -0400
Received: from mail.smrk.net (mail.smrk.net [IPv6:2001:19f0:6c01:2788:5400:4ff:fe27:adaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634C39B
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696363792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwUru6/zPFqYsJXFUfA3VoZue4J4g+tsB4OeEvw4i+E=;
        b=Z1ENujAs7ngKJh2rQ/cp3/uJwT//4eMADp55CllPvjGz1CcG8HYb3ZVuC2vK7s6n6y0FtW
        5Cf7D7PGU3HT4GCpMoxKf9oqXZpXpgzBK8tvS7N90GKq/oALo2txOk/VODbbzny0k34gvG
        rHcJC2Cvtdjsg9IkLBGteCNgjg+9kOlAsjJD8erkrfDZnv7BoKOVOA7riZSJ45om7TR9wO
        3oClYHQa8YuqOTN8RATtD5WmgYhr+DDdmQVlgWBijHvEdgCW/FwA1znhLWmfM+Jw6OhuUY
        JDxZznBoxckL+X0VSVa0yB2mALcf5ciZDGUJiJrd1UDxK2d12HVq/HyPZWGMXw==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 4893290a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Oct 2023 22:09:52 +0200 (CEST)
From:   =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/5] Fix some typos, grammar or wording issues in the
 documentation
In-Reply-To: <CAPig+cR2wgAsGCTphqHsf_pbM0q_xLcMx=acVD6MDKhpEt3HNA@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 3 Oct 2023 14:30:38 -0400")
References: <20231003082107.3002173-1-stepnem@smrk.net>
        <CAPig+cR2wgAsGCTphqHsf_pbM0q_xLcMx=acVD6MDKhpEt3HNA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Tue, 03 Oct 2023 22:09:51 +0200
Message-ID: <20231003220951+0200.221551-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 Oct 2023 14:30:38 -0400
Eric Sunshine wrote:

> On Tue, Oct 3, 2023 at 4:28=E2=80=AFAM =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <=
stepnem@smrk.net> wrote:
>> Fix some typos, grammar or wording issues in the documentation
>
> SubmittingPatches suggests: s/Fix/fix

I think that only applies to subjects of the form "area: description".

Come to think of it, 'doc: fix some typos, grammar and wording issues'
might have made sense to begin with; I don't suppose C header comments
are off-limits to doc:.

>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> @@ -96,7 +96,7 @@ foo.bar=3D ...`) sets `foo.bar` to the empty string wh=
ich `git config
>>  This is useful for cases where you want to pass transitory
>> -configuration options to git, but are doing so on OS's where
>> +configuration options to git, but are doing so on OSes where
>
> Since you're touching this anyhow, it could probably be made clearer
> by simply spelling it out: "operating systems"

Probably.  Checking for other occurrences now I see I haven't done my
homework, anyway: there are "OS's" as plural in config/transfer.txt and
fsmonitor--daemon.h, too.  I'll include those and use "operating
systems" in the next version, thanks.

>>  other processes might be able to read your cmdline
>>  (e.g. `/proc/self/cmdline`), but not your environ
>>  (e.g. `/proc/self/environ`). That behavior is the default on
>
> I wonder if "cmdline" and "environ" would be better spelled out, as
> well, since the examples which immediately follow them give the
> necessary context.

Agreed.

>     other processes might be able to read your command-line
>     (e.g. `/proc/self/cmdline`), but not your environment
>     (e.g. `/proc/self/environ`).
>
> But perhaps that's outside the scope of this patch?

I don't think so; I'll include those.

>> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribut=
es.txt
>> @@ -1151,7 +1151,7 @@ will be stored via placeholder `%P`.
>>  This attribute controls the length of conflict markers left in
>> -the work tree file during a conflicted merge.  Only setting to
>> +the work tree file during a conflicted merge.  Only setting
>>  the value to a positive integer has any meaningful effect.
>
> Or, more simply:
>
>     Only a positive integer has a meaningful effect.

That's better, thanks.

>> diff --git a/contrib/README b/contrib/README
>> @@ -24,14 +24,14 @@ lesser degree various foreign SCM interfaces, so you=
 know the
>>  I expect that things that start their life in the contrib/ area
>> -to graduate out of contrib/ once they mature, either by becoming
>> +graduate out of contrib/ once they mature, either by becoming
>
> You probably want to add a comma after "area".

That would read awkward to me.  How about going the other way,

  I expect things that start their life in the contrib/ area
  to graduate out of contrib/ once they mature

instead?

> Do we want to correct the formatting of this pathname:
>
>     ...in the `contrib/` area...
>     ...out of `contrib/` once...
>
> or is that outside the scope of this patch?

I'd prefer not to: this is a plain-text README, no other markup present,
and I don't think the backquotes would help here.

>> diff --git a/strbuf.h b/strbuf.h
>> @@ -12,9 +12,9 @@
>> - * strbuf's are meant to be used with all the usual C string and memory
>> + * strbufs are meant to be used with all the usual C string and memory
>
> Alternatively:
>
>     strbuf is meant to be used...
>
>>   * APIs. Given that the length of the buffer is known, it's often bette=
r to
>> - * use the mem* functions than a str* one (memchr vs. strchr e.g.).
>> + * use the mem* functions than a str* one (e.g., memchr vs. strchr).
>>   * Though, one has to be careful about the fact that str* functions oft=
en
>>   * stop on NULs and that strbufs may have embedded NULs.
>
> Similar:
>
>     ... and that a strbuf may have...

Hm, not sure about this one.  I think I'd prefer keeping the plurals,
but it's not a strong preference.

>> diff --git a/t/README b/t/README
>> @@ -262,8 +262,8 @@ The argument for --run, <test-selector>, is a list o=
f description
>>  suite to include (or exclude, if negated) in the run.  A range is two
>> -numbers separated with a dash and matches a range of tests with both
>> -ends been included.  You may omit the first or the second number to
>> +numbers separated with a dash and matches an inclusive range of tests
>> +to run.  You may omit the first or the second number to
>
> Not the fault of this patch, but "matches" seems an odd choice.
> Perhaps "specifies" would feel more natural.

Indeed, will fix.

>>  The argument to --run is split on commas into separate strings,
>> @@ -579,11 +579,10 @@ This test harness library does the following thing=
s:
>> -Here are some recommented styles when writing test case.
>
> Do you want to fix the spelling error while you're here or is that
> done in a later patch?
>
>     s/recommented/recommended/

You really had me double-checking both the branch and the patch I sent
here. :-D Unless I'm very much missing something, that line is _removed_
by the patch (seemed redundant given the title immediately preceding
it).

>> - - Keep test title the same line with test helper function itself.
>> + - Keep test titles and helper function invocations on the same line.
>
> This would be clearer if it was switched around. Either:
>
>     Keep the test_expect_* function call and test title on the same line.
>
> or, more verbosely:
>
>    Place the test title on the same line as the test_expect_* call
>    which precedes it.

I'll take your first suggestion.

Thank you for the review!

--=20
=C5=A0t=C4=9Bp=C3=A1n
