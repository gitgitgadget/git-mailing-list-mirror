Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B96B1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 18:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757961AbeD0Sn6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 14:43:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42331 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757751AbeD0Sn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 14:43:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11so2081955pfn.9
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eODiWgS0wBfnAv2O+kcSzpXdvsFToYX5PO9is8p2VBA=;
        b=H+ejn2zPlDDgjBtVpxwB1l014xj93zfqE4mq/5da5B02vdEz9oETXI5uCDX78KxlBO
         7tWAZBEeKZnFe3iyvdtB9j7W1sqzXt+kgHgEEtNUCQjJeWXKEHe2sK5v9j31NhbZLHsF
         ThI5gKEPXMPEq04Kzg+rpHYJ5+cNJ57M+jnMW3Xz/zszq8nsFer41afcoLxD3nTzbTWa
         SJjg5nHpGcfrHzSbsGYKZ3OgmD65c/q0SbA0Rtg3OLgwAjx14tgaZ4r6VkZm0cOTBGI7
         9T/3Amha08eQxW/OL+FcbcqoWAxpFwRymvVTPCjWYkQCy2nIsJZWHhjwlssM4XdE1DOI
         jNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eODiWgS0wBfnAv2O+kcSzpXdvsFToYX5PO9is8p2VBA=;
        b=i7rt/1vMGEkDt0ZMB2hGnOO3w6rE/MJhIUMF81O1ULA7cgJ/c0FpEZv9vR++2fEbt9
         KMKOd8+wYSDfzMrC0jKYVT0oPxhwzj0iU5tnCGwdAjhK1Lx56KIloPcTlnQjSQi8G+qZ
         KgodYc9NP42igMlHbDA6FGQpC5grnLewiudWFsP3npVtwfkQC9u93RTJrGyAKDrVREIf
         C/y66JGWjHbI5t8+pGW0hLyuQGK/ev6UzDycSLkKUY2r82rpNOGENsDk3UIC/aS7nUHX
         DHy8p0YSRKW9X80rhvraNXSTRfrEx5htEN131onuNh3+9nS7Az2YUJWSZ0LQvl6tokXM
         P9hA==
X-Gm-Message-State: ALQs6tAj1W7++uj0fXggRaSz8y7kVdx8CTryKwMCJFg0kn1XlOd+Hmx1
        StD6nua0YYyKBl1jJHN9pHVlHKQApPG1CD92QtE=
X-Google-Smtp-Source: AB8JxZoVNVwCcKEizx9UmdKTRKRv7sU493yMrvsDTjTAwUV7L4oullKbaU9JvMRJEVtvjIfLuTizPQOUxKtJxhDX8kc=
X-Received: by 2002:a65:63ce:: with SMTP id n14-v6mr3093487pgv.316.1524854636485;
 Fri, 27 Apr 2018 11:43:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Fri, 27 Apr 2018 11:43:55 -0700 (PDT)
In-Reply-To: <bb44e716-a57b-71fb-4446-20809ddb73d1@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180427170440.30418-1-asheiduk@gmail.com>
 <20180427170440.30418-3-asheiduk@gmail.com> <CAPig+cTM1J35hvwYwj9BOkFxw0tGQJFZjPL_WnCa=wDxzYzj0g@mail.gmail.com>
 <bb44e716-a57b-71fb-4446-20809ddb73d1@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 27 Apr 2018 20:43:55 +0200
Message-ID: <CAN0heSqSu0g=3V6MueOQaYKv-HWDbXDBwrEQ=o3r4v_xa1xWkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] doc: align 'diff --no-index' in text with synopsis
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 April 2018 at 20:40, Andreas Heiduk <asheiduk@gmail.com> wrote:
> Am 27.04.2018 um 19:33 schrieb Eric Sunshine:
>> On Fri, Apr 27, 2018 at 1:04 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
>>> The two '<path>' parameters are not optional but the option
>>> '--no-index' is. Also move the `--options` part to the same
>>> place where the other variants show them.
>>>
>>> All three items are already correct in the synopsis.
>>>
>>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
>>> ---
>>> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
>>> @@ -13,7 +13,7 @@ SYNOPSIS
>>> -'git diff' [options] [--no-index] [--] <path> <path>
>>> +'git diff' [options] --no-index [--] <path> <path>
>>> @@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
>>> -'git diff' --no-index [--options] [--] [<path>...]::
>>> +'git diff' [--options] --no-index [--] <path> <path>::
>>
>> Not a problem introduced by this patch, but shouldn't this say
>> "[options]" rather than "[--options]"? Since the aim of this patch
>> series is to clean up botches and normalize documentation, perhaps it
>> could also fix this oddness(?).
>>
>
> Well, in the SYNOPSIS it is always `[options]` for all variants but in
> the DESCRIPTION it is always `[--options]` for all variants. Fixing the
> other variants would stretch the "subject" line of the patch a little
> bit to far ;-)

Hmm, I do not think it's always though. It's pretty consistent in its
inconsistency, but "git diff [options] <blob> <blob>" goes the other
way. Maybe that's patch 1/7...
