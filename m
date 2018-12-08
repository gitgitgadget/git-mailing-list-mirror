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
	by dcvr.yhbt.net (Postfix) with ESMTP id E4FCA20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 12:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLHMSv (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 07:18:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35528 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeLHMSv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 07:18:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so5828837edx.2
        for <git@vger.kernel.org>; Sat, 08 Dec 2018 04:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wC0WFIYP8ZSRE5sX/CmZOQDZIhxrwv3pFXMnluwMijw=;
        b=Iq8Rfxl1bzCbSsuENrggKPyhHCvptO8vkXUKFrMFizGV0/0bVluZnJFbfimPJ8oBa9
         monXeyFL+1JWf6+9N66+qeNbmn7j+y/vIWgoMChU94UmcT5CEoU97Bp36zCygAzfu0Nu
         ODBOCKSTNsNEikCHDxy3VTWBs6gYtHlGvNqvNdvb1sHY+z2BkvdwRLUBMSGoCVz2JlpA
         m5/o+blowwaO1RonBIFJ/kqhp4As8dtfDlSeV8tNwbO9lbGBwzq2yF3lcQg1iOITH6Pm
         gs2l5YqpNo0NXycc/Oh1LGlx0RSYuEYBCNBJV0bQBtWcF5/dHTtauzeknv6f1Y1LFvye
         5a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wC0WFIYP8ZSRE5sX/CmZOQDZIhxrwv3pFXMnluwMijw=;
        b=AhBYXxwIF0EZFeSgt5dbtB7LBzs5ZqC1u3lnIfbYhm4CqQXXj491i2pJVn36fiVSEZ
         svhWbQ6hw4gjguIVTiyAc7kLgWRaPFHMyVQyGxM2AuUe9IpGi7wXTEERqoHZZNAq3sNk
         V0sNcKgY/fnfEAfm1e4s2vDAWBzIXdYdp9L5AOf4/xkiJokCrV1A2cDMqxA+a3hbZVps
         BDdcaxcE3U7x1Bgb7BxtTY+ksz2A415KoJYiIJlozouvd+ey0Q6UXST8R/W3JbomfCCL
         ACVeSqtO+jmR+Xw50wmHWMXswPqyQQ3urvkoCjxNz72s6dtmEjO8JzxzY7/T9DumLOu9
         +2qA==
X-Gm-Message-State: AA+aEWY7NWZfz2jG4Z0qjMtRhfQD0Zs1lu7NKH7NHs9nK+9Bo/0We3rs
        58qOCxf+2xefGMfp3Jka+Hs=
X-Google-Smtp-Source: AFSGD/VtLjBZNrNqg1vzosB0T/xwwVKrpWVUT7kYqrLdW+SeD6UBPl3W6tIaH9V354dniR3Zkly4zA==
X-Received: by 2002:a17:906:6308:: with SMTP id p8-v6mr4548590ejk.100.1544271529322;
        Sat, 08 Dec 2018 04:18:49 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id c23-v6sm974761ejb.62.2018.12.08.04.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 04:18:48 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>, bwilliamseng@gmail.com,
        git <git@vger.kernel.org>, bwilliams.eng@gmail.com
Subject: Re: [PATCH] mailmap: update brandon williams's email address
References: <20181207205621.49961-1-bwilliams.eng@gmail.com> <20181207214013.GA73340@google.com> <CAGZ79kYrgpZDqAhg8c11V_qJTCzzw4-qrVN2z_Y_OAeCbWU6dQ@mail.gmail.com> <xmqq5zw48s9q.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq5zw48s9q.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 08 Dec 2018 13:18:44 +0100
Message-ID: <87sgz8xlcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 08 2018, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Dec 7, 2018 at 1:40 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>>>
>>> Brandon Williams wrote:
>>>
>>> > Signed-off-by: Brandon Williams <bwilliams.eng@gmail.com>
>>> > ---
>>> >  .mailmap | 1 +
>>> >  1 file changed, 1 insertion(+)
>>>
>>> I can confirm that this is indeed the same person.
>>
>> What would be more of interest is why we'd be interested in this patch
>> as there is no commit/patch sent by Brandon with this email in gits history.
>
> Once I "git am" the message that began this thread, there will be a
> commit under this new ident, so that would be somewhat a moot point.

"Get to the top of 'git shortlog -sn' with this one easy trick" :)

(The patch makes sense, good to see you back on-list Brandon)
