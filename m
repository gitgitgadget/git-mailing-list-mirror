Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0805A1FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 09:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbcLHJYX (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 04:24:23 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33880 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbcLHJYV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 04:24:21 -0500
Received: by mail-io0-f196.google.com with SMTP id r94so2178216ioe.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 01:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xaHON3W3635MvlRpP7clJP7GbZ3WQqOlkKIUAhFYH7Y=;
        b=Y4FPYoi0Zu7u33f5aBKwn8KX66fMrCe5NgQPrt4BtQcylkMTlFSOgMfB/RvolO96J5
         8+HfflvZmqYcPMV0+t5E1dCgWEgt8syvBWDpZnYzCDZjx9vw6+DDSYVqnLTOEetBitIQ
         5jUQSxtsOr46Y1hc73CXsG3W5Rig18+yRPieMKdh9LeVzgj7M3mTk6PWp/vBAZlA2Agt
         2olK87vEaOb+ozV2g1oi7rHVFbxY7gAnszzwDXYh0E1GgTqYdDChWpielVHodYfNTaSU
         ZxoDUvZl0NIGrc5wgQyA6Ku3TLK1jCDiawL4HyYSA1+R4YUdbmZMz8Gi8Hr9G3MvVr0/
         FSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xaHON3W3635MvlRpP7clJP7GbZ3WQqOlkKIUAhFYH7Y=;
        b=bDXKBfPgsTYNq7iZ6fOEELr2YxyMz6M/wkq/TCLFOeO38x+fKIcxUHeYefxf8DM45s
         HWlrgkPCcmwJvWDe1wALo5XiGK6ZmvETB7VWwinLu1Rx/958JFLE6VYgqCunpxWh5lA3
         Mhwzfg7D5//gNVaFw0DCPOa/kYw3Y+adX1BGhJz0nr8+RLzaUqYdCuPPbXcBe7X5GWlp
         w7R4Bay+ph8/MoISMv4zfFMCfEmXLbgvt2hFNpBf5V+7Dmgr+H/tGe7AGv2ZLuJ2LhXw
         8lF0rzf1Fr/VP81n9na819McM0tEhK2U24unK+PiDeXKEMDVLsmjmDuA18jNwJC/eF4W
         THow==
X-Gm-Message-State: AKaTC03nbZXjFHm3mUvXxw5EBTcI98blDXA5+LZ6bS0dSWqAmRan1RLnesCOrcTz/OpXp8LQrOnl6BAuLciOow==
X-Received: by 10.107.132.74 with SMTP id g71mr63730519iod.19.1481189060653;
 Thu, 08 Dec 2016 01:24:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 01:23:49 -0800 (PST)
In-Reply-To: <20161207232724.GI116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-17-git-send-email-bmwill@google.com> <CACsJy8ChJ_H3gDOuKVYGAKYumG0u2WkBVpNr_3ePyAJ9NojvEg@mail.gmail.com>
 <20161207232724.GI116201@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 16:23:49 +0700
Message-ID: <CACsJy8BFkB1Ga3PJ-QccVUoE2L14CB2g4MoapVu-QFi3c9CQQw@mail.gmail.com>
Subject: Re: [PATCH 16/17] pathspec: small readability changes
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 6:27 AM, Brandon Williams <bmwill@google.com> wrote:
>> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
>> > @@ -362,8 +368,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>> >         } else {
>> >                 item->original = xstrdup(elt);
>> >         }
>> > -       item->len = strlen(item->match);
>> > -       item->prefix = prefixlen;
>> >
>> >         if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
>> >             strip_submodule_slash_cheap(item);
>> > @@ -371,13 +375,14 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>> >         if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
>> >             strip_submodule_slash_expensive(item);
>> >
>> > -       if (magic & PATHSPEC_LITERAL)
>> > +       if (magic & PATHSPEC_LITERAL) {
>> >                 item->nowildcard_len = item->len;
>> > -       else {
>> > +       } else {
>> >                 item->nowildcard_len = simple_length(item->match);
>> >                 if (item->nowildcard_len < prefixlen)
>> >                         item->nowildcard_len = prefixlen;
>> >         }
>> > +
>> >         item->flags = 0;
>>
>> You probably can move this line up with the others too.
>
> I didn't move the item->flags assignment up since the code immediately
> following this assignment deal with setting item->flags.  I made more
> sense to keep them grouped.

It's probably why I put it there in the beginning :) Yes let's leave
it where it is then.
-- 
Duy
