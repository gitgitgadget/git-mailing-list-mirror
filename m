Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9DC2036B
	for <e@80x24.org>; Fri,  6 Oct 2017 11:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdJFLEz (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 07:04:55 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:53793 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdJFLEy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 07:04:54 -0400
Received: by mail-pg0-f41.google.com with SMTP id s2so1597643pge.10
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 04:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LQKROZvbPxzpD7ebeXiuxQ+TDdVR1VNNxBPx1+L5ITw=;
        b=iyk+S45Xw7u0F2wOQMrOkLY36vI8ckhSvsCQRXz0ivn3fjTLpSVdQ0+zoaebUxaon9
         wa7fA2NvzppjYd4fuulRS4ek3tXdsAS/YSBk9xHdOW0r6+9k5zgvjj10By3WddJ1jlYF
         6CbGs9dssqBYjVu3Gd9SWYj1oiy1w9gi3O1MUJNUHgLq/UZ0RASIg4e7mMq34pLBwtRK
         vC4mMiFHsrfg+2VxuvA/JO1ep6M022jnmYOXdTZv/nvA9Fgt0DkaA59qOobthAyEEiRj
         9BYXkYNxRlnFdyqKScUI1spj1X8zOYQcYH/IzdFu8n9RoQHQ+4jk4RCRigSXk0ggD5Xx
         CB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LQKROZvbPxzpD7ebeXiuxQ+TDdVR1VNNxBPx1+L5ITw=;
        b=noZgfWON0jtGdqpbAGyaupcdIu0hI+bWjoh8yRHZkWYFRXUAjcOBPDHe+NhsYGaQyd
         DIr0KQivmQQ92tGdRfm2hZzQ7N/LpMgi/Zpuf6RePSYhRx1A3U8kYErB+KAHRRhmIDGj
         9h+BqXVtDna390Q5AEnmLMjNe0hRum21Sru4HtqJp9tVTFpx7eKzyvRLRcraYElyDnC0
         VHp6d9Y0RCeeF/n8yM9y+SjUL2519ZwIv5uJZ/BTRJNwighSUHQ5MtHFVQCoF42Kx4Uz
         bPuH/qLGe2YABfF0tUHdv73i3Nhni6YC7Faxufo3Jj2cHbxdLbkJwTTE4ysE3RnNkUAE
         VuTw==
X-Gm-Message-State: AMCzsaV94g5S31mFxasOUn6AHEdewzrZT7n53g1o8AbQSfuoxPyQpWDY
        Hgju2gTz1s8WR5YVsz6NDoe1O+rXjvw5wXHVEb0=
X-Google-Smtp-Source: AOwi7QBwG8VRDSiFcY59hkkc28lB6Ell+COFjwGJ5Pd0Dm6XLNUNohAQL/He3F/kZIcddIn5JLvr0d318glakLKDP08=
X-Received: by 10.84.252.152 with SMTP id y24mr1703470pll.392.1507287894219;
 Fri, 06 Oct 2017 04:04:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Fri, 6 Oct 2017 04:04:53 -0700 (PDT)
In-Reply-To: <xmqqefqhyqyg.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
 <b5fc950e4594fb9dec07ec8872c0df8514d149ff.1507228170.git.martin.agren@gmail.com>
 <xmqqefqhyqyg.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 6 Oct 2017 13:04:53 +0200
Message-ID: <CAN0heSojqHEQQfwUaGuLH2TjN+aHSFHg4WAvcd5Ksnxd-54YMg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] read-cache: leave lock in right state in `write_locked_index()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 October 2017 at 04:01, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> v2: Except for the slightly different documentation in cache.h, this is
>> a squash of the last two patches of v1. I hope the commit message is
>> better.
>
> Yeah, it is long ;-) but readable.

"Long but readable"... Yeah. When I rework the previous patch (document
the closing-behavior of `do_write_index()`) I could address this. I
think there are several interesting details here and I'm not sure which
I'd want to leave out, but yeah, they add up...

Martin
