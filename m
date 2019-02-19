Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,RCVD_IN_RP_RNBL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE65E1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 22:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfBSWiI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 17:38:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43990 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfBSWiI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 17:38:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id d17so9323626wre.10
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 14:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fTnf3eXE6rIsE/1imd0wN4bK9/V/APCc6Gb8GMPQS0I=;
        b=kCUXdqUpd3eNW1u8EwRVG87IoH0wMXopQ2+8yY8ae1eW0wKDI+q8QiYxN2KTUvervL
         8/hrVDWMfI4w6qB+2hQgMRkFyDW6c8MMlYPQmugJdUmseufNWVOVYJIPNOj0jMm4PHh9
         nBRbH/gD9QNnczOahk7ec8i3amhU5dby/XCzEJyxrRBtyUAhsACZW3Bu2Hozx4YX/qax
         LoMzGY4N62VQKWWTI0K5ZmNYKlMaGi+aeP457dcYy+zVx34LJezk/oUuUNX9CNv1ZXaY
         p78np8AHmUv5dHxj9i/M8sNpotKk04I+gN4FFdh1nV/YioI2eImfiSZqYsnQupcuhW8c
         oTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fTnf3eXE6rIsE/1imd0wN4bK9/V/APCc6Gb8GMPQS0I=;
        b=lhO1H8xIQiodFo+OAIer2aIl4K2DiaJLDx8BTUi+V+Lkf5WhMJTB1mjsq0t/fg2mH7
         z3He7TZA/mc+F9FnM9sUBRFQzsGurEfERCbyGbzSouZ8NfD3DPIReSMet/lbHF65Sr/L
         CLDZn6BaqNBb2qXmf1taI5TUje5wPA0xWBvG5Xs1R8cRv4o6o3ZlrnrenQK3VOBnpYMr
         nyaMI0tcjawbrawfAkKMl3KtyhOepdPpw3Vh1lUAlCN6zCPqy9tjHVz8Ysmmt3r39e/b
         HpVLurX3noJ9Vn+5nB530UFzIl89+U9pkaY1eysGny6n/5BXltwyRiWjFonRvz/57t5Q
         Ez9w==
X-Gm-Message-State: AHQUAubUFybMnsYAPvCuGUnwpPFP6oO6imFUrn/C+qhj0PlbK0Kr2FRj
        OkQB3sfL7pPTANtNuktK3Tn6f+p5
X-Google-Smtp-Source: AHgI3IYpFxI/VYO0592M7uJjlOMd5GGivSpW4zvUtKtY5j9zKoWW5uiRdnXGy2Oh0uQyS0apOvMB+A==
X-Received: by 2002:adf:f543:: with SMTP id j3mr21309042wrp.220.1550615886274;
        Tue, 19 Feb 2019 14:38:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y185sm3954442wmg.34.2019.02.19.14.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 14:38:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Re: [PATCH v2] merge-options.txt: correct wording of --no-commit option
References: <5C6BAA4E020000A10002FBFF@gwsmtp1.uni-regensburg.de>
        <20190219170709.25463-1-newren@gmail.com>
        <xmqqk1hv1sms.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGGujXxdmdv0P+TwHwwKaK2maA6rJ7=WpiJYq7ZZivkpw@mail.gmail.com>
Date:   Tue, 19 Feb 2019 14:38:05 -0800
In-Reply-To: <CABPp-BGGujXxdmdv0P+TwHwwKaK2maA6rJ7=WpiJYq7ZZivkpw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 19 Feb 2019 14:31:50 -0800")
Message-ID: <xmqqo977z9o2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>   $ git checkout master^0
>>   $ git merge --no-commit next
>>   warning: defaulting to --no-ff, given a --no-commit request
>>   Automatic merge went well; stopped before committing as requested
>>   hint: if you'd rather have a fast-forward without creating a commit,
>>   hint: do "git reset --keep next" now.
>
> Good points.  I thought of this last one before sending, though
> without pre- and post- warnings/hints; without such text it definitely
> seemed too magical and possibly leading to unexpected surprises in a
> different direction, so I dismissed it without further thought.  But
> the warnings/hints help.
>
>> I do not have a strong preference among three (the third option
>> being not doing anything), but if pressed, I'd say that the last one
>> might be the most user-friendly, even though it feels a bit too
>> magical and trying to be smarter than its own good.
>
> I also lack a strong preference.  Maybe mark it #leftoverbits for
> someone that does?

This definitely is outside the scope of the documentation update.
