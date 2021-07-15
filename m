Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B5EC07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E000613C0
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhGOQig (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:38:36 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42652 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhGOQif (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:38:35 -0400
Received: by mail-ed1-f49.google.com with SMTP id k27so8990472edk.9
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4Z+DWUtmtEbO8ze6h+qnysgckRw0WoXJSsXV2vp+h4=;
        b=YVhmdJIIpR8Ohn915h77IJMa1XcUCcZftUKhx0ezOhva5uSgql3rtMX5BmUerUxvt1
         GQ0NvR3m4eRnnKVLFCNNs5zjpUsiJumrIIKFMZSJ6TKFPlU+wxdKlnVF+KEn4QGM/SM4
         wMYih+I//smGh9g/Ov6fG2b+AgJdKVSVIIR6Wm7SNOl/EOYAaS9eCRWJFQ2LJU/FQkFS
         3S9cziUUk22vxq/d8gbgkSWlPf+S1DbiPALUj6xbFSMqfu7EF6R71K9m/UB+g21rQB1/
         p/kJlfG427Lx/0uMY1vslUKTY0MX4vK4jga/oyt8kZ/sKnKly9+7h8PLyXFpA6ZtfF8b
         Kbmw==
X-Gm-Message-State: AOAM532HK40UJITw04GKTu19otFlZjHZS6kAEwkJWCXAgIS+Op6KlLtA
        1bhi3orVlJEhrNoeSvBwxUerVTA8EVrFvFxpZXI=
X-Google-Smtp-Source: ABdhPJz6r5b9OzMCKmE6tQTTNRemrUgr/IJ982Agtln7LLIfhRVYU3ZoelI3Z2rA6kpAnuargs4YE9+wvdrxGe9H8TI=
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr8343259ede.94.1626366941717;
 Thu, 15 Jul 2021 09:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmtqpzosf.fsf@gitster.g> <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
 <87czrl0wob.fsf@evledraar.gmail.com> <xmqqk0lrtuh4.fsf_-_@gitster.g>
In-Reply-To: <xmqqk0lrtuh4.fsf_-_@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Jul 2021 12:35:30 -0400
Message-ID: <CAPig+cT24=jy65C1cQ4WarakJHKm4F8_78nDm=jWOnHxfhtcRw@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: recommend gender-neutral description
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 12:25 PM Junio C Hamano <gitster@pobox.com> wrote:
> Technical writing seeks to convey information with minimal
> friction. One way that a reader can experience friction is if they
> encounter a description of "a user" that is later simplified using a
> gendered pronoun. If the reader does not consider that pronoun to
> apply to them, then they can experience cognitive dissonance that
> removes focus from the information.
>
> Give some basic tips to guide us avoid unnecessary of gendered
> description.

Some words seem to be missing from this sentence.

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> @@ -541,6 +541,49 @@ Writing Documentation:
> +      A contributor asks their upstream to pull from them.
> +
> +    Note that this sounds ungrammatical and unnatural to those who
> +    learned English as a second language in some parts of the world.

It also sounds ungrammatical and unnatural to this native English speaker.
