Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E0A1F461
	for <e@80x24.org>; Thu, 16 May 2019 08:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfEPIbQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 04:31:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52416 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPIbP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 04:31:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so2637880wmm.2
        for <git@vger.kernel.org>; Thu, 16 May 2019 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1aGMLSSUkR5M/bomTJTT+0JF6t5TjtDgZ9JDOLp8H3I=;
        b=STyu/qNjvS0G2ollJ9mhiusAhSdiQwh3eZBMUAZ/YDIwWUEbZV3/gEAtOV7Jyl0QjT
         K9wChkD8ScZqcyTPA/uO/U8ojW4eX6adwWZKcj+D64dYyGrBeCRBAkwm3dwNmGvNutqD
         xW1gwkDJOy71NMtLMk44Ft9wAGDLZeGmsmrUt9u3dvjqOIBtRP9KNdOsELRRtKOmxZTc
         cOlr4hKlGt4u0P4Ut4b4BJ9pf9NAcl+FMOJ92WqR690ORxttSebDiVFjC/z/81vukclO
         2L5cC91XHfZdzoHNS9gdZOn8K/nXnRTUH0+iUDPBcD/dZsbkcaHKeD3SpWGAmHp3u7M1
         fKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=1aGMLSSUkR5M/bomTJTT+0JF6t5TjtDgZ9JDOLp8H3I=;
        b=sa5gbdPz0LYF7uMQkRbunlWWrc6+xvQbdmLt3AZaXjklqTrUdvU+LQwASH3Ic+C5UI
         KaqStu+Hk+IrZDLC9FEYx/rLnYv8LBp7NUgDIPLOrL8GAfkyiVxm4tySX/IIpst+Ad+4
         8RM6mxKfJzw5ckW+zW3g0ksN259WbLjJ5tUxo07snX7Vah1ydkPd539piknGk5OV4b+L
         X1AMQIx433pRoFXExIxzCYk+mx0Q2j4LbSxzhikW5OpUCd4UvaNuc33nVVjMOLEnAhBT
         y/gwZ6fsSoeoXeLa3i3mcZgBG/40S+wb5uV+BIH21q69ZB7XG1cGEIApTkPtwIu+w6fj
         ii7w==
X-Gm-Message-State: APjAAAW1yGBdnDzAYuD9UtE+BZIk04w9oplKUhq31O6ViQGTwYEz0Val
        EHOcZktE8mDIi4t5DJxWEc0=
X-Google-Smtp-Source: APXvYqxD1SIdAJc/yObcUKJ0seGwVDsy5j8ZgsPp2aYx9yEUSrBSS/pwyde3NDIQgUDBFY/xlZ1YOg==
X-Received: by 2002:a1c:b743:: with SMTP id h64mr26508252wmf.16.1557995472245;
        Thu, 16 May 2019 01:31:12 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id x5sm5045245wrt.72.2019.05.16.01.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 01:31:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Osipov\, Michael" <michael.osipov@siemens.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1dc: update from upstream
References: <3cabed9e-3949-93cc-2c9c-500a9cd9d4cd@siemens.com> <20190513221701.1837-1-avarab@gmail.com> <09f64da1-b8aa-3cd7-89d7-475b8722e176@siemens.com> <87a7fovsz8.fsf@evledraar.gmail.com> <6aabf669-a73f-d23d-8d65-8b96eefbae4b@siemens.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <6aabf669-a73f-d23d-8d65-8b96eefbae4b@siemens.com>
Date:   Thu, 16 May 2019 10:31:10 +0200
Message-ID: <87y336vm0h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 16 2019, Osipov, Michael wrote:

> Am 2019-05-15 um 13:48 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Tue, May 14 2019, Osipov, Michael wrote:
>>
>>> Hi,
>>>
>>> Am 2019-05-14 um 00:17 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> Update sha1dc from the latest version by the upstream
>>>> maintainer[1]. See 07a20f569b ("Makefile: fix unaligned loads in
>>>> sha1dc with UBSan", 2019-03-12) for the last update.
>>>>
>>>> This fixes an issue where HP-UX IA64 was wrongly detected as a
>>>> Little-endian instead of a Big-endian system, see [2] and [3].
>>>>
>>>> 1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/855=
827c583bc30645ba427885caa40c5b81764d2
>>>> 2. https://public-inbox.org/git/603989bd-f86d-c61d-c6f5-fb6748a65ba9@s=
iemens.com/
>>>> 3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/50
>>>>
>>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>>>> ---
>>>>
>>>> n Thu, May 09 2019, Osipov, Michael wrote:
>>>>
>>>>> Hey there,
>>>>>
>>>>> Am 2019-05-09 um 09:32 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>>>
>>>>>> On Wed, May 08 2019, Osipov, Michael wrote:
>>>>>>
>>>>>>> Hi folks,
>>>>>>
>>>>>> Hi see Documentation/SubmittingPatches for how to submit patches inl=
ine
>>>>>> instead of as attachments.
>>>>>
>>>>> Do you want me to resend the configure.ac change as per wiki article?
>>>>> I can also create a PR on GitHub. I am happy with both as long as I
>>>>> don't have to retain the patch for myself only ;-)
>>>>
>>>> Yeah that patch to git.git should be done separately. I see your PR
>>>> went in upstream, here's a patch to update our code to match.
>>>
>>> To avoid misunderstandings, I have factored out the Git patch and
>>> created a PR: https://github.com/git/git/pull/608
>>
>> Thanks. If you want to submit it for inclusion you'll need to submit it
>> as a patch here to the ML as described here:
>> https://github.com/git/git/blob/master/Documentation/SubmittingPatches
>>
>> Or you can use this pull-request-by-proxy thing:
>> https://gitgitgadget.github.io/
>>
>> Or if you don't want to deal with any of that crap just say and I'll
>> E-Mail this to the list for you. Just want to give you a chance to do it
>> :)
>
> Yes, please do so. It seems like our corporate mail relay server does
> not allow sending emails outside of our dns namespace. I get bounces
> from mailer daemon.

Hi. No problem, but I just noticed your commit is missing a
signed-off-by (required for inclusion in git.git), please "git commit
--amend -s" it and re-push that PR, then I can pull it from there.
