Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36CD61F597
	for <e@80x24.org>; Fri,  3 Aug 2018 15:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeHCR1D (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 13:27:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39558 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbeHCR1D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 13:27:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so5775977wre.6
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4X9lUz0LRWi/dhHNOPmYfW6Qv5IUw2nHK4b0lRncdhE=;
        b=djLiL4uQpGlDW4MGS/yu28I0o+/Blj7NNNyEB7PVoqpqfzfupun43RQzh11gFRYOtE
         0CsG4oCohIfJIeFj/LVLqaQflu8obgPMGnB5IpkhI1fxCnscRpuhpi62NGU3zqe3uXEt
         io+JIL31GZelLU5Ll+pZR7eXqxYmKbbvTAKUnyeLumULWmQznkCT06sH3T3O0kCZAhEX
         fGZ8GGu0u0pQwYQ41pTZWF8ZyvS2eiGK5sHREpMqK8JZ2z98PvMImTmUF32ekyIYDrOJ
         0OEm1Vxow59xz5yvjchos9HGSTXMLeyhxXnZnNitzy8i2LZ9WzH2xqJtXOylV7gGVl0i
         SFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4X9lUz0LRWi/dhHNOPmYfW6Qv5IUw2nHK4b0lRncdhE=;
        b=lVAYk+6CYprwAItVyj+ueurktlWyl/eOgQZwFmfuPkyv3QiHwweMam9Q7tK6utMDQu
         5zHQb/zdkQThfayVZFEv2Voy2JcrWbVP6WO7Kp/FONJTfaa7SFOL21tumOoXiAUBDkRg
         oIwz/bJJhQMzmoI8lk/KvAJt7YVNXxY8PzuCcso6/eghS31Jp3JMoKhZSmxv9OaDoDLN
         KIeMLtF2nA23+3HUkB5xej+g3io5Td5FyZ8/59sGgjgWZAFkppdf9USOCa3kj15aIzFR
         GQDJ8CcdmIADcEDt57F66zlr6AIA9yYpHPM1BHCGdDhe/lXxCaLROPzx3OkQ5VV0rMTk
         2Pgg==
X-Gm-Message-State: AOUpUlHRiodq0KoURf54ocRbCIAqFUBU9sdFoPRK0yYcxVjQK4zCSwJ7
        apisNhqf0nKoC3OTP/LntX2MoXuN
X-Google-Smtp-Source: AAOMgpfM0EG8qwZpzd4pE2bMWUVRJB1AIPtLjvY1QX67spwhIJuFqmDNQGZ20g8+a0WEbPyTvKTYMg==
X-Received: by 2002:adf:b786:: with SMTP id s6-v6mr2801209wre.247.1533310213077;
        Fri, 03 Aug 2018 08:30:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k3-v6sm5697967wme.44.2018.08.03.08.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 08:30:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <xmqq36vw4vu5.fsf_-_@gitster-ct.c.googlers.com>
        <b72e5848-a51d-a62d-2a3c-36ea6b8582d0@web.de>
        <xmqqtvoc3fgl.fsf@gitster-ct.c.googlers.com>
        <87effgtsnm.fsf@evledraar.gmail.com>
        <xmqqr2jgzess.fsf@gitster-ct.c.googlers.com>
        <3120e9b3-f3e7-465c-63c3-084d3f010e1e@web.de>
Date:   Fri, 03 Aug 2018 08:30:11 -0700
In-Reply-To: <3120e9b3-f3e7-465c-63c3-084d3f010e1e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 3 Aug 2018 06:42:30 +0200")
Message-ID: <xmqq600r1n98.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 02.08.2018 um 22:36 schrieb Junio C Hamano:
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>> 
>>> Thanks, FWIW that's fine by me, and also if you want to drop this "fake"
>>> patch of mine and replace it with something René came up with (I have
>>> not yet read his 1-6 patches submitted on this topic, so maybe they're
>>> not mutually exclusive).
>> 
>> I think the 6-patch series supersedes this one.  Thanks anyway.
>
> Actually no, I specifically avoided touching builtin/push.c because this
> patch already handled it; it should still be applied before patch 6 from
> my series.

You're of course correct.  Thanks.
