Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9422035F
	for <e@80x24.org>; Tue, 25 Oct 2016 18:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754720AbcJYSNh (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 14:13:37 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35837 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753299AbcJYSNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 14:13:37 -0400
Received: by mail-qk0-f174.google.com with SMTP id z190so265223233qkc.2
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y7XE/NhUrwVjt+/WkaagD13BgGo7N5DxbIJN6KKUWuo=;
        b=SwskVf1ehclT1ZmVqB3sqiFsWvhXIzyjiogddlxzAlH41GOkBUOkl9vN2eygPnMvAS
         QaYIrfnv5ohNuc1MgNfEOMranamx02jW+X+eb77QCDRFd4/Rk2RpaElM9Wh9WZ1ilOPb
         xLyZBCyGOvBQNp1zUHaS0E0oXVoh8Q+qaL4wDsL6tJa8lXH33wLbhRMP4yt1Hyam+nON
         GohZFaZHWYJNvvbGwWaudSma1sii1i2zUQVzbv02PK0b6wUR9shKzsekzFPKEVhBgYU1
         Sn0wtooDVQqOuHmrvgXsPwi0d8BZXDxWbAswwkkMVFIuKGFHIST2fCigIYWV7LiPBlcq
         A78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y7XE/NhUrwVjt+/WkaagD13BgGo7N5DxbIJN6KKUWuo=;
        b=Y44AkDDEJgiZPEjT0oispw3balpDR0FHcoscB4w2xpCHiRm73H1fZghgk7iT9Z24VZ
         HqWPtGDfa5CUqMyZHRBEjcfy7ug0k/vPPSzpS9IdloutCXqHmJsqQ3Oh9E2MZdCC2+2a
         NYwbQQ9Jeea8hlSUsSeaKsi/rVvSnPd+xaaP+MGodlAU6noTDw3bYvf7EciNW4tDVbyi
         SlOZVDNYiJ/NzsX705qH05mSu1Q3jFx/jEeI6gAI8G0Aw7AN+Y04hgmgYS+AAcwPi8Rn
         8GIy7Rk+YGniYUWKjxjAZjjqRNlR3tIte8cTW857eDUykj1T4VHM8SZPKWepAuwm7w8B
         SQZQ==
X-Gm-Message-State: ABUngvfRJlVy9kXTrn8sXcMC62/IeuWUQM/YxwMaUyu4ebYvUvc1YApcjjhCgf4I4ST9V7zz5Bz2pUiMDQjnp9Q2
X-Received: by 10.55.64.80 with SMTP id n77mr22529392qka.173.1477419215921;
 Tue, 25 Oct 2016 11:13:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 25 Oct 2016 11:13:35 -0700 (PDT)
In-Reply-To: <xmqqoa28s63l.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sz5tetv.fsf@gitster.mtv.corp.google.com> <CAGZ79kbtyuSXDiyi2eY6HKCAwEiKgk2KmNakSn=f+RiXCAC1bA@mail.gmail.com>
 <xmqqoa28s63l.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Oct 2016 11:13:35 -0700
Message-ID: <CAGZ79kb2XD8+y-Y_oiwSj3DsXjmTS=bd6fj5dn9NADmvDO5xtQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2016, #06; Mon, 24)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 10:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> One of the initial ways to work around the bugfix was to
>>
>>     git clone . root # <- add in this step and it works again.
>>     git clone root super
>>
>> but instead I will do the preparation for the 'super' project not
>> in '.' but in 'root', just called differently ("super_remote" ?)
>>
>> An additional new test for cloning from '.' will be introduced, too.
>>
>> I plan on working on that with highest priority for git after finishing
>> some attr stuff that I currently have open. So expect a patch (or two)
>> this week.
>
> Hmph, I personally would prefer to defer the "correct behaviour for
> /." part for the next cycle, which is why I wrote:

Ok. The first 2 patches are in good shape for this cycle, though.
And the /. thing will wait until next cycle then, i.e. I can drop priority
as I wish

>
>  - the "off-by-one fix" part of sb/submodule-ignore-trailing-slash
>    needs to be in the upcoming release but the "trailing /. in base
>    should not affect the resolution of ../relative/path" part that
>    is still under discussion can wait.  Which means we'd need a few
>    more !MINGW prerequisites in the tests by -rc0.
>
> at the beginning of the message you are responding to, and I also
> thought that was consistent and in agreement with what you said
> earlier in <CAGZ79kaq85c1Gk1aRSrdQGp1Nm9p6tN0jXbFvTN0v+9ehooxYg@mail.gmail.com>
>
>> On Sat, Oct 22, 2016 at 10:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> >
>> > There isn't enough time to include this topic in the upcoming
>> > release within the current https://tinyurl.com/gitCal calendar,
>> > however, which places the final on Nov 11th.
>> >
>> > I am wondering if it makes sense to delay 2.11 by moving the final
>> > by 4 weeks to Dec 9th.
>> >
>> > Thoughts?
>> >
>> > Speaking of what to and not to include in the upcoming release, we
>> > do want to include Stefan's off-by-one fix to the submodule-helper,
>> > but that is blocked on Windows end due to the test.
>>
>> I'd be happy either way, i.e. we could revert that fix and make a release?
>> AFAICT, Windows only has broken tests, not broken functionality with that
>> submodule bug fix.
>
> to which I responded in <xmqqpomp33km.fsf@gitster.mtv.corp.google.com>

and you said:
> It of course needs help from
> Windows folks to validate the results.

So maybe instead of adding !MINGW we rather want to apply
https://public-inbox.org/git/2908451e-4273-8826-8989-5572263cc283@kdbg.org/
instead for now?
