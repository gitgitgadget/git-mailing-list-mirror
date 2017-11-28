Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14A020C11
	for <e@80x24.org>; Tue, 28 Nov 2017 01:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbdK1BCr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 20:02:47 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35194 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdK1BCq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 20:02:46 -0500
Received: by mail-vk0-f42.google.com with SMTP id n63so18701633vkf.2
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 17:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qDON9u/AouBVY/hKNts6FNlYwmzcWM3jRKh/DWuqykM=;
        b=iCYstWY62nsCDG3NwpfJwJ1jHqHCBNTXqQo5urwZBVm4ASzpHfCVrPCfbCNI6w67qk
         ADvqDXziIoSMosEjCvupqkx46v6stdPeGt0cN4KxYHAKNFmXeobyLnub1ltecm8PTxKD
         a2kkoTjgUOztYYke7aVNkwS8YAvaVCoKIZfuVzPoHC2od3kCK5VlDZuYB1BAhSZqqpvY
         PaIJgooQBbboKYJSF5kydA1fUQ+FwAjhoKHiDtFXUo8jQeJ4CJiTuqtz8y4SwvkKndUs
         s1y7Wzb+Y9jXF5Zx1BrSUvb58g601ArudwerhaSamdB/UxH0QPO6rDUutsHW8Il/bkiB
         FOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qDON9u/AouBVY/hKNts6FNlYwmzcWM3jRKh/DWuqykM=;
        b=Q5U2i3cyIYwwHWMfHgrQNChDDmjm+SjkvwwFDJsLPzRTTXOUUSCjeUPpE+d7K1TsR+
         S7VoHs9Am2ssk7r9fLlGlUQRSfu4gqQW5MwkfhvjWBG/Z9EnX1H9wi2g8Sf7/sY4VJfs
         GEDWZOiFgEKQOQath0pY5R+aBpNXSpDXB/XTTff+bQ9TMbxttFd7rJ6mbhb8ad1P9zUZ
         bL98j7w95rUKRD4AB6NEFIuumSYyM7QCdORPrkzY9QskY4rKbEVpC5JFHqGaxfhxQt7t
         hkX8+7GbarfCSPfYs5UC1Ezz3bFd78ojzZsq3L6WytJvB2Cj6lP4kIEhx34r0V+P3GBH
         Zb8Q==
X-Gm-Message-State: AJaThX4qVjQL44jejI9j5tYBdQhB+SMoGiUAWJISgtwqsFPZY4iDstVx
        AKVe/f/kIn/2BCxpNpGpMZbZf0fjxQ020y/ke/E=
X-Google-Smtp-Source: AGs4zMb5xu5723Vr19t1WRzCZiKlJKhgTTClNrH2kxTyN1xXmKQlFrNXLu488aFTTJI65uD6wXyNk4cB3pL4JpJjA2A=
X-Received: by 10.31.12.76 with SMTP id 73mr25855566vkm.114.1511830965921;
 Mon, 27 Nov 2017 17:02:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Mon, 27 Nov 2017 17:02:45 -0800 (PST)
In-Reply-To: <xmqqshcz9tqa.fsf@gitster.mtv.corp.google.com>
References: <20171124195901.2581-1-newren@gmail.com> <xmqq4lpgfkyb.fsf@gitster.mtv.corp.google.com>
 <CABPp-BELci79tuiPFVRKQwm_-j6tN-DxqcKsvjD2xG_8ZWNxGw@mail.gmail.com> <xmqqshcz9tqa.fsf@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Nov 2017 17:02:45 -0800
Message-ID: <CABPp-BHt0O_NQtJsAkxxkj0yAvaZDsDtxGJTd9wqmvUOvy7x6w@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: ignore_case shouldn't reject intentional removals
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>>> As a fix, this sorely wants something new in t/ directory.
>>
>> Well, then perhaps I was wrong to submit it independent of my
>> directory rename series.  As noted in the (very lengthy) extended
>> commit message explanation, the assumption the previous code made just
>> happened to work ...
>
> Here is what I wrote in What's cooking draft (which automatically
> gets copied to the merge log message and becomes part of release
> notes when a topic graduates) for this thing.  Am I on the right
> track?
>
>     The code internal to the recursive merge strategy was not fully
>     prepared to see a path that is renamed to try overwriting another
>     path that is only different in case on case insensitive systems.
>     This does not matter in the current code, but will start to matter
>     once the rename detection logic starts taking hints from nearby
>     paths moving to some directory and moves a path that is otherwise
>     not changed along with them.

Yes, though I have one minor nit: I'd prefer "a new path" to "a path
that is otherwise not changed".

(Reason for the nit: "Not changed" to me implies the file existed in
the merge base and didn't change name on either side of the merge,
which in turn implies the directory remains on both sides, which means
there was no directory rename.  Since directory rename detection is
mostly about moving file adds into the right directory, this seemed
like the simplest correction.  There are also transitive renames, but
they're much less common and trying to cover them too might make it
even harder to parse.)

As a side note, the two sentences are a little bit unwieldy to try to
parse.  I couldn't come up with any concrete suggestions to improve
it, so it's probably fine, but thought I'd mention in case others spot
an easy way to simplify it.
