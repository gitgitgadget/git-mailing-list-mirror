Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E441F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 15:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbdH2Pn3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 11:43:29 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34817 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdH2Pn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 11:43:28 -0400
Received: by mail-io0-f196.google.com with SMTP id c18so4099641ioj.2
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SKjaht2ydaLU01gTfoaZJxutCPtZFvzZhJnoLuyCshQ=;
        b=FaPiDtyscEfRGsm9HnTveFWtC9bxxrZhDmaycprvvUhwCuXHfBmIbtlMIahY0tzrcz
         i9pt4t148H7snU+oiYkYWwNK03/YtgWt10HsvIBAAU0hojtc7CZs3jSZGbzMS91uXVtW
         LXVwcw32FZ6Ao1ml1gUvwu1RcLiTKSmRdLJ5Dtv/EaHfROoRGj1szLnUEPdBMKVsshrf
         AgQkBcSRh/YILRcddbTujepr9B9iykZEva0CpFEfzOzws7LRDTP8ZLVmMuxxPm/Yowtm
         Wy7tBC7b6i+l2kkmlKIZhfWZK+Clg14GRVFUS8AzOJ7YvHKSj5SYo1bVFSlt5c02sA1a
         APBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SKjaht2ydaLU01gTfoaZJxutCPtZFvzZhJnoLuyCshQ=;
        b=lyV7aohFBd6lK53atVJsj0dm+xp6nDvnXY93jqfJU2oCc0CTh0vVVYUJPGnOXl3lsy
         kUDwu/lTvz1xvaSh+M72u28yLyelf2XBMjJoTu2FQrIcTJ3xxGoL/tD1dPPph+RVUe+J
         JVFWcqJfBG0PKvwBuM8J2huUId6dN2GkTgMDi1NtWPLuHqYF878Vn2h1+nwqoUAGf2Km
         7N/ioEYKAgTk9hsBq89kDfm+YOwKB9Jjqd2cAIFs5RcAoH3QPGG6e9VT7KVF3eeRx270
         wXmRfUk/kjqq4lt915kzC4doYFU8ybrGjk6Lp1ZmKyUe90g82wjcz80eAfOXbIw7V5gE
         ySJg==
X-Gm-Message-State: AHYfb5jBLT8J9+hYgJp+ZpW6f17TWHk/sZsVNpxdkEhcUkHv9hL6xb52
        AEyu7dM5Bkq7q7w6s67t7obwYkYAvA==
X-Google-Smtp-Source: ADKCNb7NA4p3+FyhQqnDQ4ILCb+GofxdepvXJhzkxQ2RyzcW5t7v9FGI5pKmM5tXBT+yZUxMczUmzWUOXxk4JI9Ha/A=
X-Received: by 10.36.253.194 with SMTP id m185mr4545977ith.136.1504021407951;
 Tue, 29 Aug 2017 08:43:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.115.202 with HTTP; Tue, 29 Aug 2017 08:43:27 -0700 (PDT)
In-Reply-To: <e15513eb-aed9-8bd3-794d-009a91c1d20e@gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-36-chriscool@tuxfamily.org> <e15513eb-aed9-8bd3-794d-009a91c1d20e@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 29 Aug 2017 17:43:27 +0200
Message-ID: <CAP8UFD2VFsJWyP1TWLS15wYz2vQxHd4hG5Bdbo9-B45Q-onG2w@mail.gmail.com>
Subject: Re: [PATCH v5 35/40] Add Documentation/technical/external-odb.txt
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2017 at 8:59 PM, Ben Peart <peartben@gmail.com> wrote:
>
> On 8/3/2017 5:19 AM, Christian Couder wrote:
>>
>> +Helpers
>> +=======
>> +
>> +ODB helpers are commands that have to be registered using either the
>> +"odb.<odbname>.subprocessCommand" or the "odb.<odbname>.scriptCommand"
>> +config variables.
>> +
>> +Registering such a command tells Git that an external odb called
>> +<odbname> exists and that the registered command should be used to
>> +communicate with it.
>
> What order are the odb handlers called? Are they called before or after the
> regular object store code for loose, pack and alternates?  Is the order
> configurable?

For get_*_object instructions the regular code is called before the odb helpers.
(So the odb helper code is at the end of stat_sha1_file() and of
open_sha1_file() in sha1_file.c.)

For put_*_object instructions the regular code is called after the odb helpers.
(So the odb helper code is at the beginning of write_sha1_file() in
sha1_file.c.)

And no this order is not configurable, but of course it could be made
configurable.

>> + - 'get_direct <sha1>'
>> +
>> +This instruction is similar as the other 'get_*' instructions except
>> +that no object should be sent from the helper to Git. Instead the
>> +helper should directly write the requested object into a loose object
>> +file in the ".git/objects" directory.
>> +
>> +After the helper has sent the "status=success" packet and the
>> +following flush packet in process mode, or after it has exited in the
>> +script mode, Git should lookup again for a loose object file with the
>> +requested sha1.
>
> When will git call get_direct vs one of the other get_* functions?

It is called just before exiting when git cannot find an object.
It is not exactly at the same place as other get_* instructions as I
tried to reuse your code and as it looks like it makes it easier to
retry the regular code after the odb helper code.

> Could the
> functionality of enabling a helper to populate objects into the regular
> object store be provided by having a ODB helper that returned the object
> data as requested by get_git_obj or get_raw_obj but also stored it in the
> regular object store as a loose object (or pack file) for future calls?

I am not sure I understand what you mean.
If a helper returns the object data as requested by get_git_obj or
get_raw_obj, then currently Git will itself store the object locally
in its regular object store, so it is redundant for the helper to also
store or try to store the object in the regular object store.
