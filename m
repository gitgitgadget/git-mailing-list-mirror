Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795CF1F42D
	for <e@80x24.org>; Wed, 23 May 2018 11:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932564AbeEWL5V (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 07:57:21 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:42749 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932485AbeEWL5U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 07:57:20 -0400
Received: by mail-ot0-f170.google.com with SMTP id l13-v6so24824389otk.9
        for <git@vger.kernel.org>; Wed, 23 May 2018 04:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x5blT+c6kYAf/6makyll/VdXgKnack2oCzXeKIjLGJE=;
        b=RftunxyztfWKF9dbLLvftRlx3ZmbapiCLiZjZ5ouTsNexg5oReQDGyIJ78PCPKGh1+
         W/qysLAuiGLw8MpTcFXmXGwZvHQ8RP+eEfDc3CDKtehK7cRTgt4iMa9PyRhH0cAIVWOM
         g1HNGjVtyi2tp+BWrCS6UxV3/UqFnw78bwblD2JyoyUDaWvm9N9bfUNW5uYhBpFggCEa
         M403q80CZWUv773DPHVFME5aaUgj9jbK1wZf2T4gmy4N/7I3HgIR0oxXKOfbf79bJO5q
         iG+Aubs5c/XXnzsx90e1XmnzS7UXz7jus8wKFllSIlNVhFw9vRcY9L16NiZ+ieO02J9+
         BJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x5blT+c6kYAf/6makyll/VdXgKnack2oCzXeKIjLGJE=;
        b=OINMwcGbIhSrc7VFqWqc8TrWgzdORy7UgqyQA9GUBQyOY8qROqHI6LSor1m3UhAzUH
         Ve6ClHBQ7mv2yHFoYWXLEsjtLk8JORFUSR0eswKyI63XdPNYpkWI27b6Fjm9kTDkRHF7
         KIzrqIQ6jbFVPFMnup6NU7IZ+/708t8DnDBI8gsyYXGmLPTOV/7XjItJLPrBdklz0hQ4
         XzOTcNoGc7LinSw6F/v4EtlOumVQiqTncn2pMEG6v5QJcjILo1qWTWf+Usif7crMzD6A
         air1+epnxoHJNfTtWcf54RN/InNH3g68xkFJpPB9/7Xt3PLn2RtKLVYOC4yknU5ubpFl
         tELg==
X-Gm-Message-State: ALKqPwcKe8YukFi54wT2khy1J6x2KBAZDBwbZdiugLz4hP9Rpgh/bjzu
        btap7tKLW1m/ZjQURbXZGZrK/P/XVE6TEwAI0xEzLg==
X-Google-Smtp-Source: AB8JxZpC9VlYGWgrVbW5awKta4OWMP+i8qY6JLU0iSJ4vJk0k8DAhqfKN3PrdkkQAXXvSmlw52S6HAgOqcYme5dhOFI=
X-Received: by 2002:a9d:1bc7:: with SMTP id v7-v6mr1445699otv.344.1527076639625;
 Wed, 23 May 2018 04:57:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:d50:0:0:0:0:0 with HTTP; Wed, 23 May 2018 04:57:19 -0700 (PDT)
In-Reply-To: <20180523061652.GA13157@sigill.intra.peff.net>
References: <CAN_7rfcZHkbfaVO5A989Dza-zu7eRSPTKag9pcyB4v9=HWbKKQ@mail.gmail.com>
 <20180523061652.GA13157@sigill.intra.peff.net>
From:   Chris <jesdisciple@gmail.com>
Date:   Wed, 23 May 2018 06:57:19 -0500
Message-ID: <CAN_7rfdoJOgD0GYg_E8EW+VgXrxNpdx8GsVa=wa1tAbDZ2C+3w@mail.gmail.com>
Subject: Re: git push => git: 'credential-winstore' is not a git command.
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Peff. I should have thought about the configuration
hierarchy... This evening I need to do some trial-and-error with the
three credential entries that found.
Want what you have,
Chris


On Wed, May 23, 2018 at 1:16 AM, Jeff King <peff@peff.net> wrote:
> On Sun, May 20, 2018 at 10:17:54AM -0500, Chris wrote:
>
>> git config --global --unset credential.helper
>>
>>
>> This did help me, because previously Git was trying to authenticate me
>> with the Microsoft account I use to log into my Windows, which is
>> unrelated to the account I need to use to push code. And it removed
>> one of the two "git: 'credential-winstore' is not a git command."
>> messages I was receiving.
>>
>> But I still get one of them, so I tried reinstalling Git for Windows
>> with the credential helper disabled, but that didn't help. Then I ran
>> this command:
>>
>> git config -e
>>
>>
>> And couldn't find any mention of [credential].
>
> That command will only edit the local repository's config file. You may
> have other config for your user (--global) or for the machine
> (--system).
>
> Try:
>
>   git config --show-origin --get-regexp credential.*
>
> to see any related config you have, and which file it comes from (you
> can also just do "--show-origin --list" to see all of the config).
>
>> What can I do to get rid of this annoying message (and, for all I
>> know, potential symptom of a larger problem)?
>
> I don't know enough about Git for Windows packaging to know whether
> you're supposed to have the winstore credential helper installed. So it
> could be a symptom of some kind of installation problem. But in general,
> a missing credential helper isn't a big deal (it just means that Git
> can't ask it for a credential and will end up prompting you or using a
> different helper).
>
> -Peff
