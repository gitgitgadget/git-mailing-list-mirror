Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6EC1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 22:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbeGXACx (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 20:02:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35969 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388145AbeGXACx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 20:02:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so658556wmc.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VWYsJ+eHk3uKYx4GP8J1iLlRAibRQpWwcF1hTscolZo=;
        b=IBp/q8b4Ip8wpFAB+kOpYrpQG2/XkgI56CAXGgJ50V8OWh8KqofVR9NucVvNaHePeM
         yM+bHCxJrMw+6PoSmuzB4PRTwqiL7wBTB7d1SCRM9N8/1AksAX8Z90VLExaHQ/cxq+hB
         oELJ0XEKcDV/omsCEu45F5eYEK6l4ANlH1f1rQEUeHsS8wTCNbsL6cYJJsY5/NcUB7y+
         Hqzc89peXGTuIQ8Hiuz8aFvGzyGRAx5pG+87yf/VGmrKJcJjMrnnRn1Sp1UfjMgXVQN/
         HxiXn07zm7iSxsOdqgItg3GgIY9MHDZHZBtO4MX5lC2rXyio7i4vWHq2dyvOcjunrhm9
         Vi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VWYsJ+eHk3uKYx4GP8J1iLlRAibRQpWwcF1hTscolZo=;
        b=Rt0UU3XLXPxC5qKcIZy3x3bUERKO8EGlPNz3KBYg+VvRhUD3pCicKVT5sCbGoqa3xq
         sCzwOQVFWxAyjORtcp/Om2dSCSgnS+bWcOqZfYUMpBop4v98IfZcCsbsHJV39XQ6axLp
         oE9tkEtug7lj9y0jX/5oIpXYP1T2TDc2wd3R53E6q5Zvv61fRz4FCxYJFehBc43Y9n7i
         gwuOlk2myWQfTssONY9Yet7N5Mn2/yOJd+HWXqB4aFhoDLannL2X8b/L1GDkCytDFlVI
         W6V58pxGPmd2NqZOk+Rqz+0RcC8T+jK8j20IyNGqzxb3DuPrUcaaWDhvh3W6/jqNLk60
         Ox1w==
X-Gm-Message-State: AOUpUlFe5P9BtfyNRAuGasHATAO7QeeFdLEOlRrV0sxy9+omZVVOejWz
        iVeUFAQMSKNChlUDYLjrCqY=
X-Google-Smtp-Source: AAOMgpdAlQ8ZrRpR0UxHSefZtaE85uY7Ip6lkp3YPuG9DofhdkF4LxkudCE+AB0iGUDX+nJhjnC5kw==
X-Received: by 2002:a1c:b406:: with SMTP id d6-v6mr467732wmf.126.1532386764389;
        Mon, 23 Jul 2018 15:59:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v188-v6sm38656wme.43.2018.07.23.15.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 15:59:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: mark die strings for translation
References: <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
        <20180723175635.31323-1-bmwill@google.com>
        <xmqqpnzd36hy.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 23 Jul 2018 15:59:23 -0700
In-Reply-To: <xmqqpnzd36hy.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 23 Jul 2018 15:57:29 -0700")
Message-ID: <xmqqlga136es.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Williams <bmwill@google.com> writes:
>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>  fetch-pack.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> I do think this is a good idea, but what release does this target?
> It does not seem to apply to master@{4.hours.ago}, and I do not
> think a change as trivial like this wants to be taken of a hostage
> of _all_ topics that are in 'next'.
>

Answering myself, this would come on top of (and would become part
of) bw/ref-in-want topic, I would think.  And I am perfectly OK for
this change to be hostage of that topic ;-)
