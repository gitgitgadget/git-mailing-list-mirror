Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0763C1F744
	for <e@80x24.org>; Sat,  2 Jul 2016 08:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbcGBIBv (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 04:01:51 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35594 "EHLO
	mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbcGBIBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 04:01:50 -0400
Received: by mail-it0-f42.google.com with SMTP id g127so34371765ith.0
        for <git@vger.kernel.org>; Sat, 02 Jul 2016 01:01:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I/flQz7GsSQpyFdprDO0Bnu2urE5Mb14ZExUuJ5fjjE=;
        b=E8Go4VJ7Mv2zyXVkELHvLmOjqiY5qMBdn/en2KFJQZs5qBe+mbdz9sn5yiSogypYMd
         3zXaNIbIBJD88Na8xCCA5dq1mzOWh/meTIhlXFGvpa4TKQCk/pGXpmzuXr7q9qDw3mKE
         OxeB1HJVkFeQ4wJ7vuC2EI3/waJ8yvnYROP9SUwNmZ9SM4TuU505fy609GRh8mahxvih
         bPI29qXMcJVzv4V8R9sC0MMf8o+8mAI+qdf0nTl9pgxInegzuS+/2/NFhn5YUMGoRfSE
         0sgzxlE48UFRPm2yfM2YNhNNm7dPfhfqRAawvl8o2CDJYmRLpBAv1HBqn0WeeyBd3q2l
         ZLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I/flQz7GsSQpyFdprDO0Bnu2urE5Mb14ZExUuJ5fjjE=;
        b=I8CZMS/Lcd0Bu8eXaJhefDlI8tf8re1/Q9yDlwW9t9XqvhPZFheb0bPSNAB1ODc4Zg
         VBNF4MdMK0zpyNSaRCIYrTM2gUlZiQ2imnwqHqRH1+WYbOBYkPPM0A6JgF7vmLhqUg9i
         zdmwruBLuBKNdQwbynPeo9bUpcOdEzIKsHmLhu5GX8EsYXMpkCCBTMkgGvy1ZpCi4/Mn
         /E8XNIiiqVS9EGgxJCIr6YifOSC2inAnOZgQCTw/DK26zYTHJ1TbA9BGqExxKRWnVnXr
         9XOASo4UaL8iq49Q7KMRMm9xcBg0WWQeKyZ6QUL9E67VI6IdOisYenCbiCy4pC//M915
         Flug==
X-Gm-Message-State: ALyK8tIa0eByuE1Y6MIUnPALNJLXr7PaHYwPyORcFBNUHvn947ngAR5yKb2zyJfcsJnCRrXJQRpRqjEa8vmVFw==
X-Received: by 10.36.80.139 with SMTP id m133mr1865654itb.63.1467446509668;
 Sat, 02 Jul 2016 01:01:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 2 Jul 2016 01:01:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607020924410.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
 <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
 <CACsJy8A1ZU8VgBYmQAVC6LmXMVgt5CgvC_w0Y7Y6oX88RFO3dw@mail.gmail.com> <alpine.DEB.2.20.1607020924410.12947@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 2 Jul 2016 10:01:20 +0200
Message-ID: <CACsJy8CobWYjpjkkaG=wFK+zUyF3Z9CtFku7eprnX=_08y6KpA@mail.gmail.com>
Subject: Re: [PATCH 1/9] Report bugs consistently
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 2, 2016 at 9:25 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Sat, 2 Jul 2016, Duy Nguyen wrote:
>
>> On Wed, Jun 29, 2016 at 1:36 PM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>> > @@ -955,9 +955,8 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
>> >
>> >                         if (!sha_eq(a->sha1, b->sha1))
>> >                                 result.clean = 0;
>> > -               } else {
>> > -                       die(_("unsupported object type in the tree"));
>> > -               }
>> > +               } else
>> > +                       die(_("BUG: unsupported object type in the tree"));
>>
>> As a message targeting developers, we do not need to mark this for
>> translation. There are a couple other _() in this patch that should be
>> removed as well.
>
> Yes, Hannes already pointed that out.

Ah.. sorry I didn't read the whole thread.

> My answer is the same: it is not the purpose of this patch series to fix
> this, and therefore it retains the previous behavior.

You're changing the string and adding more work to translators. So
either leave the string untouched, or drop _().
-- 
Duy
