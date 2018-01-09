Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18D21F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934855AbeAISuN (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:50:13 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:40081 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbeAISuM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:50:12 -0500
Received: by mail-qk0-f169.google.com with SMTP id d18so9428056qke.7
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 10:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nrP5T0DN7K16F8N8iPriZTGk/sVmZckrdaRTEibCXZo=;
        b=FSOnYHzdp4zM/TKO8ANbiJMcBSkMn9jbAF+fF8WMg0xTZGFvLLEGa13kg6WJEYYq6d
         gGwj2C0f2YrhKE6XtJoC0YU6247hnw4vAwAKpPTRWYj452oD6L70T5Kpek7UJQIth7kh
         O0pZSEcXVUNFB9YGxt5sIn6AWkgsfNcPyjkWCfPEYl8BnZSWVGLEUwbMxJ1gJFnwboG0
         5RUbdKb2Y7hYTeMOj8rmXrsEa4wnOBGNomGA7xlUjKjWDfuMPqpmq5JCRKv0AEIwZUMJ
         g5P/qQ0j4+qfa4V+akpXUur/DYR5RbIcC78t/5cTGuOGIZxLTn8bXI9eQN423fPx7OzV
         gwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nrP5T0DN7K16F8N8iPriZTGk/sVmZckrdaRTEibCXZo=;
        b=Ke/QZ+bX8kUmIEyOhAnaNemNSaFma0w32kkC8mDxZw8I5v/1+kjZQSHJk64Qk0JBqG
         PotyREalLHzQCa5VFzKmi75FIP8j+er+nzVP/XGRigHkLvI1TWF7b31UmmeF6dUvsaMB
         WSfHcf0aO/EgIqR3svlQEgMxcm8y+E0oCGw9KOSwIq6oTGRX7MQMioNh2CzVLBGewpRt
         hblNFFei2uAE+jWVw+GPR7Z/Vb9+AaDdw5FmdDK0AJV2WA2Oz43sKnEZr2fsku42ksl2
         rMD9iRx/Jejx4rTTBRGkzXucbqt4ygctCw4ccgodf0xRHWiPEgmaLttNEuMBlZzgVBmZ
         JD7g==
X-Gm-Message-State: AKwxytfHeS6IdcibXhvJTaeOFrLwSqJPbqunrtGKfJ+1fHLbv4gi65mi
        mx8OZtzTox7C+I+9zoFXxTjrBLlVJapalraI2coPEA==
X-Google-Smtp-Source: ACJfBoulWEp0ESHG6M2amTcrJlOcq4UbASFycWL7YnvmiGbB8zpntcQkFSXOk3eiLvAxMa8Q2Eh5KIxWb+1K//G7pW4=
X-Received: by 10.55.19.162 with SMTP id 34mr22720882qkt.40.1515523811275;
 Tue, 09 Jan 2018 10:50:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 9 Jan 2018 10:50:10 -0800 (PST)
In-Reply-To: <64503247-66ad-03cf-26ba-3383337971b5@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <CAGZ79kZ-UNCyCzmg=5PQ_p5xbmCp7HUc0=TXNBxwTjZDCnJtBg@mail.gmail.com> <64503247-66ad-03cf-26ba-3383337971b5@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Jan 2018 10:50:10 -0800
Message-ID: <CAGZ79kZ97-sLS4mP28rLoMqf2z8KU0FZ5=fcogynYQKdxji=ng@mail.gmail.com>
Subject: Re: [PATCH 0/8] Doc/submodules: a few updates
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 9, 2018 at 9:06 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Tuesday 09 January 2018 12:38 AM, Stefan Beller wrote:
>> On Sat, Jan 6, 2018 at 10:46 AM, Kaartic Sivaraam
>> <kaartic.sivaraam@gmail.com> wrote:
>>
>> While small patches are really appreciated for code (bisect, automated
>> testing, and
>> the general difficulty to reason about code, as a very small change
>> may affect the whole
>> code base), I am not sure if they benefit in documentation.
>> Documentation is a rather
>> local human readable thing, so by changing one sentence we don't
>> affect the understanding
>> of documentation at a completely unrelated place.
>>
>> Also it helps to read more than just sentence fragments, i.e. I tried
>> looking at the
>> whole paragraph for review. May I suggest to squash them all and
>> resend as one patch?
>>
>
> I wouldn't mind that. I thought it might be easy to find to find the
> parts I changed when the patches are small. So, I sent them without
> squashing them together. In case you feel it's not worth, let me know so
> I'll squash them in.
>
> BTW, in case I did squash them in, would it be nice to keep the commit
> subjects of the current patch series as bullet points in the unified
> commit message?

Sure.

>> I wonder if this indicates a lack of documentation when the active
>> flags were introduced.
>> They are found in 'man git config', but maybe we need to spell them
>> out explicitly
>> in the submodule related docs.
>>
>
> Possibly. So, why not in Documentation/gitsubmodules! Here's a replaced
> version of that paragraph,
>
>     * The configuration file `$GIT_DIR/config` in the superproject.
>    Typically this file is used to specify whether the submodule
>    is recursed into at all via the `active` flag for example. A
>    submodule is considered active if `submodule.<name>.url` is set
>    or if the submodules path is present in `submodule.active` or
>    if `submodule.<name>.url` is set.

I wonder if we'd want to give an example later, and first describe the
mechanics precisely:

   The configuration file `$GIT_DIR/config` in the superproject.
    Git only recurses into active submodules. A submodule is
    considered active (a) if `submodule.<name>.active` is set
    or (b) if the submodules path is matches the pathsepc in
    `submodule.active` or (c) if `submodule.<name>.url` is set.
    (c) is a historical artefact and will be ignored if the pathspec
    set in (b) excludes the submodule. For example:

    [submodule "foo"]
        active = false
        url = https://example.org/foo
    [submodule "bar"]
        active = true
        url = https://example.org/bar
    [submodule "baz"]
        url = https://example.org/baz

    In the above config only the submodule bar and baz are active,
    bar due to (a) and baz due to (c). Another example

    [submodule "foo"]
        active = true
        url = https://example.org/foo
    [submodule "bar"]
        url = https://example.org/bar
    [submodule "baz"]
        url = https://example.org/baz
    [submodule "bob"]
        ignore = true
    [submodule]
        active = b*
        active = (:exclude) baz

    In here all submodules except baz (foo, bar, bob) are active.
    'foo' due to its own active flag and all the others due to the
    submodule active pathspec, which specifies that any submodule
    starting with 'b' except 'baz' are also active, no matter if the .url field
    is present.

>>> 2.
>>>
>>>  man git submodule
>>>
>>>        update
>>>            ...
>>>
>>>            checkout
>>>                ....
>>>
>>>                If --force is specified, the submodule will be checked out (using git checkout --force if appropriate), even if the commit
>>>                specified in the index of the containing repository already matches the commit checked out in the submodule.
>>>
>>> I'm not sure this is conveying all the information it should be conveying.
>>> It seems to making the user wonder, "How at all does 'git submodule update --force'
>>> differs from 'git submodule update'?" also "using git checkout --force if appropriate"
>>> seems to be invoking all sorts confusion as "appropriate" is superfluous.
>>
>> When "submodule update" is invoked with the `--force` flag, that flag is passed
>> on to the 'checkout' operation. If you do not give the --force, then
>> the checkout
>> will also be done without --force.
>>
>
> If that's the case then shouldn't the "if appropriate" part of "(using
> git checkout --force if appropriate)" be dropped? That seems to make it
> clear, at least for me. Or is intended as '--force' will not be passed
> to git checkout all the time?
>

Yes, essentially we only pass the force flag when we were given the force flag
("when appropriate" :) Not sure how to say that otherwise. But dropping sounds
good)

Stefan
