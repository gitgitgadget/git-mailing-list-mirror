Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A1B20401
	for <e@80x24.org>; Wed, 14 Jun 2017 08:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbdFNIBy (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 04:01:54 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35701 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdFNIBx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 04:01:53 -0400
Received: by mail-pf0-f174.google.com with SMTP id l89so80501653pfi.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z2sD9hF75P9JRmDS2ATGbb8ZFJy6m/7L0UyvKDvhLaA=;
        b=VqtMRVO/Eb/26lDbhZO7g/kWE4YQ2hbTCyw3B/IaIg07LV/XolNkNsA51pK016sg71
         Nz281iFs1EZ2HYW4HFe0gxYluVqv4TZz7SKVbVOJqC3wOGR/zvecP4Ux0wiuvJK91/2Q
         7wn5PII6FlJyfDs6dbgbHfEfpy3kqFBn5hBOml2B6hADSTyCwxOs9L7BoDMEubG8IbFR
         0eyDwPTo2S0py7nRvDTAfqkPjVhKpe5QEieIgFCaTk0nHrohXBNl/09LZogNljtFO8dI
         Ja/7XnkpHWqb3oEGutG4kXFkf1vpEpJpF2NQ73vzkjP8peHBLT3gKDKZi1+d/GeI05Wn
         HV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z2sD9hF75P9JRmDS2ATGbb8ZFJy6m/7L0UyvKDvhLaA=;
        b=VMUU7h5Iog+DNb8Odatuwn11p2Cdx327UO7vmx2otnrv32ZLTCtuh1GxwlgLTi4h4O
         Vwy8kN4RvfuNQIGy+frLNX9lT5HM6jesb8iFjC/Iei7zapV0XDdJE5gTLUXZvMj/fnUg
         +sPQzOwaJDf+4cGKlqCwHr94lR7nDMa5f2N10aM5B8yaulX0Clc8XJnmrdBOBHExKu8+
         5pKIeIp6kam4sA7BQ/K/zlVfCeVofhr0elklFulcdxH3xGVee6o4RAYJ3sHp5dDX9gFD
         l3dLJ7Txr76khlhfBX62RhUN4gEvLXcOtEYETctKYidaQzrtpHRuaJijDhK2+LQtCSDG
         vi1A==
X-Gm-Message-State: AKS2vOzk5rbbuWWGY0cftba6RkMn3uceauX0KIN6xC03N0XCQrDYqh9F
        D0KQQEtfVZkrOprq5p3tV+a3Cv+lUQ==
X-Received: by 10.98.1.72 with SMTP id 69mr2883939pfb.124.1497427313014; Wed,
 14 Jun 2017 01:01:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.182.236 with HTTP; Wed, 14 Jun 2017 01:01:32 -0700 (PDT)
In-Reply-To: <xmqqfuf37q2q.fsf@gitster.mtv.corp.google.com>
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
 <0102015ca23f054b-b7c281d9-c9e0-4691-bfa9-8c46fb77dfc7-000000@eu-west-1.amazonses.com>
 <xmqq60fz95sb.fsf@gitster.mtv.corp.google.com> <xmqqfuf37q2q.fsf@gitster.mtv.corp.google.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Wed, 14 Jun 2017 10:01:32 +0200
Message-ID: <CALiud+=mE77ak2x9KHWHW1oumAecyBN8R+J8dnUw+fUnyurrVQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] branch: add a --copy (-c) option to go with --move (-m)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 7:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sahil Dua <sahildua2305@gmail.com> writes:
>>
>>> Add the ability to --copy a branch and its reflog and configuration,
>>> this uses the same underlying machinery as the --move (-m) option
>>> except the reflog and configuration is copied instead of being moved.
>>>
>>> This is useful for e.g. copying a topic branch to a new version,
>>> e.g. work to work-2 after submitting the work topic to the list, while
>>> preserving all the tracking info and other configuration that goes
>>> with the branch, and unlike --move keeping the other already-submitted
>>> branch around for reference.
>>>
>>> Like --move, when the source branch is the currently checked out
>>> branch the HEAD is moved to the destination branch. In the case of
>>> --move we don't really have a choice (other than remaining on a
>>> detached HEAD), but it makes sense to do the same for --copy.
>>
>> I strongly disagree with this "it makes sense to do the same".  It
>> would equally (if not more) make sense to keep the HEAD pointing at
>> the same.
>>
>> Personally, I may use this feature if it didn't move HEAD, but I
>> wouldn't if HEAD gets moved.  But that may be just me.
>
> Ah, that came out to be stronger than I intended.
>
> While I do prefer "the HEAD is not moved by this command---if you
> want to move to the newly created branch after copying, check it out
> yourself" a lot better than what the patch does, I do not think I'd
> care so strongly that I'd reject this patch series unless the
> behaviour is changed.
>
> But I do react strongly to an unsubstantiated claim "it makes sense
> to do the same".  I can buy "We anticipate that in 50% of the case
> users would find this branch switching annoying and in the other 50%
> of the case, users would find it useful; since we need to pick one,
> we just randomly decide to do the same as --move", though.

Okay, "it makes sense to do the same" was not the best way to say it.
Basically what it meant was that considering there are conflicting
opinions about how --copy should work with respect to checking out
branch automatically, it makes sense to do it the same way as --move
just to come to a conclusion. If we get user feedback that a lot of
users find it annoying, we can make it work the other way around
(without checkout branch automatically).

I will fix the commit message to explain this in v2. Is that okay?
