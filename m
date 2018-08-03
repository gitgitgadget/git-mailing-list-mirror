Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57FC41F597
	for <e@80x24.org>; Fri,  3 Aug 2018 12:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeHCOw2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 10:52:28 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:54034 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbeHCOw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 10:52:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id s9-v6so6191750wmh.3
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=nhqJAkCeIuwlSkNDRp/txRL4Bob15czKVT5k2qWECks=;
        b=Y8TQgKd0hne/S6cToSUDad8X/qHqLirF0ZjwtqomIQsFhbSwbxTU1+n76U0SvTapve
         AidF0JxUyM4Dmi4hAcilSB8OpnElF2V7ncatL8MVZ7UcOBCa5CHf/Dba9CwL2vJKcEHj
         rNCM2FgXjLXnJX96Q3WZ6ItOJhhcMdqvnOSpGGjo1u3oKqOm6AEK3OxPFq5IPyHgWwHg
         dNgF4+ssnfK+O4waoyBj94T3qK6e/BF7JHtCUysDIWc7n/dQTuefxFlniONYNYB7vWSv
         9Qh2nO2KOqj87xrzgPhkyXxIVGEYyGRupHqxWnh/BLGdJwsEoCfAixiCMp/p4iYZkAod
         yShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=nhqJAkCeIuwlSkNDRp/txRL4Bob15czKVT5k2qWECks=;
        b=VxQ8ofMmQNQWSMY8GkNJ9SGrfS9NsxcorlBmIRuTmNdpmb500bXOZJskGfE0Xqlc6z
         TDGVsLV8XCz9hG91KWQ9T2ldkThwiIGttvebHwPdKhD6s2bYp98/zhSFHV3WcGyNCcsB
         9Tz5xmHXG/Jbtgb42PL2IMdlkNCXsIFXVMbRYh+MI/f69k3SuiM/S6d74zWX2Nz1kfX1
         0jLhFwtMQwaowhJBEpeYZtf3zaQOgycazgwGi6nGsxIxaO5vvlWpBn/sBqGiUUX3a2L7
         j22CeZTOGZNQVT5Cg9FGAMSAlBUucwk8ukKBqh7HvhK0ZwTVjswMs8lgVAjnYJtwTO1b
         cxdA==
X-Gm-Message-State: AOUpUlEwrA2FJHm6ARSRhx+L3SCXm69fDZ/i3EyFlgcDFW9r8hKnt8oJ
        0ARjlC4+z00snLLmhIF7528=
X-Google-Smtp-Source: AAOMgpeJvRMo8gBNVOnfmtq0N5LTNQDlMxA2YHsgZprMNMLe1jNlKV9ze+NOW34IUqH1eL2KGfaxoQ==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26-v6mr5058075wmh.61.1533300973345;
        Fri, 03 Aug 2018 05:56:13 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id q8-v6sm6517750wrj.97.2018.08.03.05.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 05:56:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Liam Decker <ldecker@indeed.com>, git@vger.kernel.org
Subject: Re: Question regarding quarantine environments
References: <CALcD6sYfcaftciYU+2AHpzabyOS9ohRcZoE6LDuMyht+dxktHw@mail.gmail.com> <20180802183924.GB23690@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180802183924.GB23690@sigill.intra.peff.net>
Date:   Fri, 03 Aug 2018 14:56:11 +0200
Message-ID: <878t5ntxqs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 02 2018, Jeff King wrote:

> On Thu, Aug 02, 2018 at 12:58:52PM -0500, Liam Decker wrote:
>
>> I've been working on a git hook in golang recently. However, the library I
>> was using did not support a possible quarantine directory, which I would
>> use for my hook.
>>
>> I have been trying to find out how git finds this incoming directory in the
>> objects folder, as their code simply assumed it resided in
>> .git/objects/<1st byte>/<last 19 bytes>
>
> When you're running a hook inside the quarantine environment, then
> $GIT_OBJECT_DIRECTORY in the environment will be set to the quarantine
> directory, and $GIT_ALTERNATE_OBJECT_DIRECTORIES will point to the main
> repository object directory (possibly alongside other alternates, if
> there were any already set).
>
> Any Git commands you run should therefore find objects from either
> location, but any writes would go to the quarantine (most notably, Git's
> own index-pack/unpack-objects processes, which is the point of the
> quarantine in the first place).

To add to this, one interesting thing that you can do with hooks because
of this quarantine is to answer certain questions about the push that
were prohibitively expensive before it existed, but there's no explicit
documentation for this.

E.g. for a hook that wants to ban big blobs in the repo, but wants to
allow all existing blobs (you don't want to block e.g. a revert of a
commit that removed it from the checkout), you can juggle these two env
variables and hide the "main" object dir from the hook for some
operations, so e.g. if a blob lookup succeeds in the alternate
quarantine dir, but not the main object dir, you know it's new.

>> The solution that I implemented was to check the objects directory for the
>> object, and if it was not there, to look for a quarantine directory and try
>> there. However, that feels fairly inefficient.
>
> That's more or less what Git will do under the hood (though in the
> opposite order).
>
>> For the curious, the library and solution I attempted are both here [5]
>
> Just skimming, but it sounds like go-git does not support the
> GIT_OBJECT_DIRECTORY environment variable.
>
> -Peff
