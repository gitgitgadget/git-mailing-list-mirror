Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD1A1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 19:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeKBEmu (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 00:42:50 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33667 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeKBEmt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 00:42:49 -0400
Received: by mail-ed1-f50.google.com with SMTP id f1-v6so69358edi.0
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0VsjxweFEPOlgDeWl2jWCAbt1Sg3Ry7TsXaJqTtzvY0=;
        b=tnNlIBLinRPWnVDiR8oruMaRzXq4kh1Fg2j7fkbc1A/LpJCLorWPU/9o/hQSGiA+xq
         86T9EnDORCi2jQwBOFNHXBtRzbkxU6VWbNENCGQ2w69aexPI7kOb3+9rlwcNpcNMHR/j
         Xb8AUrRaBwQADcexZo59c9gLkzbNouSbKTWWPk4IPeXu5LHy/lMK/G7NkYb35PlKjWqR
         9V0KxZrK5Ks54SkWnq9PndxxyOIEwtcIDbd0tWG3NHQF7k7TZaMUqcPY21PZx5N0/yDi
         RdbYbLtsO0Ug8SEjIRcGSxtFVNLjM/69Dhv+Cn25wuekRlVkbnj/N01+vFzFtFGjsMWw
         Iutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0VsjxweFEPOlgDeWl2jWCAbt1Sg3Ry7TsXaJqTtzvY0=;
        b=Ph+9g+WRQaoAx+fi72UHzhrMSj5a+UlcLqRqx8YOORYDwO/f+cBVSYaLW0Zq6aYfKD
         3lzuYqFdhs609ix3tBQK9fBlVTZ1/BaVrffZNSz264hmRDzC7yKMkQnr9MnB5RyZLr4u
         6ixeiCIYrq9u4hk2Q93ZYnVzU3cGpFwjPQiFeN9Jqcjs8kbNofAQNrCm9cIsmLCMbOl5
         OzJzrY5ogpo9GwYu/np/QFTmp6u05Ud8Hztk4aX1x+s9/zYqmcGgjEvf97lAbkhYSaPI
         sMTC0k0hudmB85auae2Z4Hlcb5kXoj7IgspOIuH+8PUhIgG9+S5E0ec5LOz6GiZ/1xXA
         BXpQ==
X-Gm-Message-State: AGRZ1gLcSXPQEUOrDOqWl5YdYpLEvJsPLkJs+XQRtYsc97T6g/mGU22X
        jr+wjjXvqO+lRnZ+MIxytl13MhUS8ts=
X-Google-Smtp-Source: AJdET5do4Zz81tj1xRLj/R3efjCOvpXI3kLPOy8bt/Ljf5f2lyv7HZKhjVGGNo9E5ngzYkNqLeBkdw==
X-Received: by 2002:a17:906:55a:: with SMTP id k26-v6mr4894275eja.218.1541101106316;
        Thu, 01 Nov 2018 12:38:26 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id z12-v6sm4611588edr.56.2018.11.01.12.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 12:38:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: ab/* topics
References: <xmqqd0rpt8wy.fsf@gitster-ct.c.googlers.com>
        <8736slkqmu.fsf@evledraar.gmail.com>
        <xmqq8t2dsz8x.fsf@gitster-ct.c.googlers.com>
        <CACsJy8B4KtVHkFPKzt66JzfTp1sOL=MKNGdJuWW45vX1ht2PqA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8B4KtVHkFPKzt66JzfTp1sOL=MKNGdJuWW45vX1ht2PqA@mail.gmail.com>
Date:   Thu, 01 Nov 2018 20:38:24 +0100
Message-ID: <87h8h08u6n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 01 2018, Duy Nguyen wrote:

> On Thu, Nov 1, 2018 at 3:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>> > Could you please pick up
>> > https://public-inbox.org/git/20181024114725.3927-1-avarab@gmail.com/ ?
>> > It seems to have fallen between the cracks and addressed the feedback on
>> > v1, and looks good to me (and nobody's objected so far...).
>>
>> If this is the runtime-gettext-poison thing, this did not fall thru
>> the cracks---I didn't get the impression that "no objection was a
>> sign of being excellent"; rather I recall feeling that you were the
>> only person who were excited about it, while everybody else was
>> "Meh".
>
> I would be more excited if the scrambling patches go first (*)

Sorry to be so unexciting :)

I've sent a v3 in
https://public-inbox.org/git/20181101193115.32681-1-avarab@gmail.com/T/#u
which which hopefully addresses the concerns you & SZEDER had.

> and then we start to make "make test" poisoned by default. Scrambled
> output is still very readable and it will make people not forget about
> grepping translated stuff the wrong way. Of course *i18n* functions in
> the test suite need to be updated to to grep/compare for real, not
> just exit early like they do now.

I think now that this is a runtime option we'd instead just do stuff
like:

    GIT_TEST_GETTEXT_POISON= git ... 2>err &&
    grep str err

Which has the advantages of:

 1) You can grep for error messages you find in the code and find tests
    that check for them.

 2) When you run the tests and something goes wrong, it's not some
    scrambled output, so you can quickly e.g. search for that error in
    the code / on Google without needing to hunt for some "how did I
    disable the scrambling again...?" knob.

After all, the entire point of the facility is to catch us updating
strings which have existing tests without "GIT_TEST_GETTEXT_POISON=" (or
test_i18n...), but once we find those (with my patch) we can just
selectively turn the whole thing off.

> (*) The pseudolocalization idea is also good, but printing unicode by
> default may be a bit of a stretch. Not everybody is running the test
> suite with a unicode-capable terminal.
