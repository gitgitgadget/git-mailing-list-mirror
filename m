Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C26FF1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 12:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeKRWXw (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 17:23:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47050 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKRWXw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 17:23:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so470720edt.13
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 04:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XM+RXugQTHLjFHoxVW/YKNd4zmVnq55hK7K0ZtjDodo=;
        b=cffU9jCN/iCPD5xrlCRpbfq1qg50jsqQPB6rTwqjl0FAhgtYUsTsKGEuA4ytpO+icN
         jUSX0hLmgIZa13QGkJazH2lYx6fg1nFoq/9xeAkFeICD7mzZpbXlRmm9ZcLngIX5ziQm
         IKmvy2Beh59jZgxOSbWE9PwrvXq6837tJhct396HJeaHQwlHOoTcL0W5mqPT7iAdwY6G
         /Sz8PMRfzeflqYVDv3WoHlrZ2qfzD3WgNqyE+Kv+nssrM2LQ/LsZ3AXClO+MLq1ZCuQ4
         yoEN+o62XIj2kT1T8+py1VcsjOd1EZjl44qv0iU5QU0bemBjiVdc1w4PkRn5nHXzxyER
         NpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XM+RXugQTHLjFHoxVW/YKNd4zmVnq55hK7K0ZtjDodo=;
        b=MEGKnQBDm6lTYTJf6Tes0aUHQxwtdvqN4dPguEPy+87CfVxIGpGrUSrI3Bs68kHYYP
         gA85UP8zARat5moz94xZ5gqLoJ5OQ9PjKNbr7R096rqdUatlf8+ovo+KfiMSK/GVDxVb
         rKXdmGRFNppD3l75TGxvoxl1Hydf5BNSt++51SmYL/h2Ii4R8wNUUpFpOI7uEJSD+PkD
         +zSxhiANUHYorcBSihY4msf61nVE2GBijm5yEWXKAxbTEHviHFRxH1kketoGRo1mxQXx
         dLsU0ycXJG/zDNHBz4dymeqhEtYxa5Ib9MHNU1pFOSfWqyPB3x8j2geBc9bk8gSb0Dxm
         D4eg==
X-Gm-Message-State: AGRZ1gIpJW7W0vOzkNol9HkJmhDj8dLQHJVybrP54Afv1e5RXFLWeqvp
        tTTORQihEXJBhstkImYTrP4=
X-Google-Smtp-Source: AJdET5ep7ZARQGbaNzGFQifOEe0Pk/LHlJ3S//Xz34ry3DpYvbr6s3i/Pa5zWiGvA7qt5ZDZxAMrCw==
X-Received: by 2002:a50:a8e5:: with SMTP id k92-v6mr17019829edc.2.1542542621793;
        Sun, 18 Nov 2018 04:03:41 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id d5sm4131606edb.48.2018.11.18.04.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 04:03:40 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
References: <20181116173105.21784-1-chriscool@tuxfamily.org> <xmqqpnv4gigi.fsf@gitster-ct.c.googlers.com> <CAP8UFD0f_oD2cm61exc9mCczD59ze0Qj1cHGn-MvtSMWNXA+gg@mail.gmail.com> <xmqqftvzhn22.fsf@gitster-ct.c.googlers.com> <87ftvz1k5u.fsf@evledraar.gmail.com> <xmqqsgzyg8ux.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqsgzyg8ux.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 18 Nov 2018 13:03:39 +0100
Message-ID: <87efbi1tk4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 18 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> Do you mean that you don't agree that following should always create
>> both "foo" and e.g. ".git/refs/heads/master" with the same 644
>> (-rw-rw-r--) mode:
>>
>>     (
>>         rm -rf /tmp/repo &&
>>         umask 022 &&
>>         git init /tmp/repo &&
>>         cd /tmp/repo &&
>>         echo hi >foo &&
>>         git add foo &&
>>         git commit -m"first"
>>     )
>>
>> To me what we should do with the standard umask and what
>> core.sharedRepository are for are completely different things.
>
> Ahh, of course.  If you put it that way, I do agree that it gives us
> a valid use case where core.sharedRepository is false and the umask
> of repository owner is set to 022 (or anything that does not allow
> write to group or others, and allows read to group) to let group
> members only peek but not touch the contents of the repository.
>
> I think I was distracted by the mention of ore.sharedRepository in
> the proposed log message.

Thanks. I'll submit a v3 with a less confusing commit message.
