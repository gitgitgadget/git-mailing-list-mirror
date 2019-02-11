Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCFF71F453
	for <e@80x24.org>; Mon, 11 Feb 2019 20:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBKU5c (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 15:57:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33834 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfBKU5c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 15:57:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so342642wrg.1
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 12:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XrTMQl7UJM+cIX2salrRIiW2PnWlRqPDbNLet4td5qs=;
        b=HHO+LOynxks5apy7cjgTSKvQB2lh252ITiaYQxkTB5XabrzKEnH4ikxd8FO0PUK3J/
         WXifbB7z0NZu4/o8DC8UF4iOAsJJ/qSMZNjCKKmxgB4ZkDoJ+E94kdgKSeY/aHuCoj/Q
         oqvR0We+2e5vl7DLwmOee8r8GBrYJm3XDNb6PgGu20tQ0qH2HA11Ac9A+D/9uto25cEM
         3mWtTLuZ4rIE1d05tj8xLismMuIzwcai4cj81YAS45wJPn8l6yiz3+Qou2pB8L7Ze6xj
         fZAckFob8J2oPMYZYjmlGo1jEofPwtQADToErFvyn3Ro2PR2w5cLE667SVkzYmEO0QGA
         0oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XrTMQl7UJM+cIX2salrRIiW2PnWlRqPDbNLet4td5qs=;
        b=CcDuUZvyGNp4gFCld2XIwPxPu6HYLjEZYsnN7QdcVEf1dHZo5yPkCNXRP41QU5gXti
         /v6p8N7r/sPDGGHWlxWoJXHu3VW4ebL7VSK5B0a7q4q4OZ8PLRFIAVcEkz+767Wp55DY
         hV5AGvxVXAcLq6ysxOUmCj5wPnHpR9w1Rx/OecHPlqtTiiOlIqGJG+jwZ/7VCArxl5Lz
         oWCCTJAeyvHQMlgPrGbGZg8+4Feq0lW4q6HMCC5zpWkISfbRI/AD0pJOGaSIyDGdaBC0
         aQB4pT0qfLkSlJzoOOghFE8jmTUhZNJBDHqXoJAzvlPyYOrGSOJF3z6whwOvIwjomozq
         jELQ==
X-Gm-Message-State: AHQUAubL4/HrJbkEpI23IzJPgOGMR1Axuq1VqmmBJ4q/lN8kHN5WY6EL
        y1DWvHHq/gl7EDLlensuRls=
X-Google-Smtp-Source: AHgI3IahYNcfQC2eT2t19cE6LAj+SMf+LLAkgK5ESWg3nkNTURjQRCML5jGWNcqwj+d6LnPwtXAhLQ==
X-Received: by 2002:adf:e706:: with SMTP id c6mr122934wrm.278.1549918650372;
        Mon, 11 Feb 2019 12:57:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y1sm14805470wru.4.2019.02.11.12.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 12:57:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix typos in translatable strings for v2.21.0
References: <20190209213044.29539-1-jn.avila@free.fr>
        <20190211064453.5205-1-jn.avila@free.fr>
        <CANYiYbHoNV+6yi6a75oh2nPpihsqEu0Fq+8R_G6O+XOD5JogoQ@mail.gmail.com>
        <1517c545-0028-56e4-fc58-fb3c6d3551fe@free.fr>
Date:   Mon, 11 Feb 2019 12:57:29 -0800
In-Reply-To: <1517c545-0028-56e4-fc58-fb3c6d3551fe@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
        Avila"'s message of "Mon, 11 Feb 2019 09:50:02 +0100")
Message-ID: <xmqqo97igi12.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël Avila <jn.avila@free.fr> writes:

> On 11 février 2019, Jiang Xin wrote:
>
>> Jean-Noël Avila <jn.avila@free.fr> 于2019年2月11日周一 下午2:48写道：
>>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>>> ---
>>>  builtin/bisect--helper.c | 4 ++--
>>>  builtin/fetch.c          | 2 +-
>>>  builtin/rebase.c         | 2 +-
>>>  3 files changed, 4 insertions(+), 4 deletions(-)
>> This re-roll is v2 (forgot suffix v2 in subject), and LGTM.
>> Difference between v1 and v2:
>>
>>      -              die(_("--reschedule-failed-exec requires an
>> interactive rebase"));
>>     -+              die(_("%s requires an interactive rebase",
>> "--reschedule-failed-exec"));
>>     ++              die(_("%s requires an interactive rebase"),
>> "--reschedule-failed-exec");
> Thanks for reviewing. The first submission was too hasty and did not
> even compile.

Thanks, both.  Will queue.
