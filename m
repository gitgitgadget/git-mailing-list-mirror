Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F621F597
	for <e@80x24.org>; Thu,  2 Aug 2018 20:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeHBW0h (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 18:26:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42267 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeHBW0h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 18:26:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4-v6so1381500edp.9
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7SryvhJYI6PJl5X9OevzlT+whLDIvPwV9ijnmfU9xR8=;
        b=CpMk2eeyrVZRmmDdH4Dv03tN/ZK/OBmqS38FZWH3A+zC1gXq1Twof3efsLf1sRL9yo
         ACtykZO7yUg3Qmu7wOCEQRHRV1h2kUlW2ZNPJH1Ug9qkhUuGIn1P/F6XwZkhiXq2wDMU
         Q9VJeARt9E3ZzxonDTe9QfaTbam7WX+RX1aBmO3EzCZzgBLKdYZVzLU0Tl3khd6ZhsGj
         b+LulfiMBPtS+/pJZJCyEnzLWrfmFRqd9l/OUEI7YtKnDkwBcHriEqNOh8oSNkJSIVmh
         dTlJaTkvlwFHt7fsxR1qKtqFygfNJiIZUB+ARftGmN9VRP0/HKG39QRVMnWG23dW8kRy
         SzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7SryvhJYI6PJl5X9OevzlT+whLDIvPwV9ijnmfU9xR8=;
        b=ZncKybdIfd6xUSiDAODxYgpj+3fIMSWG94R2BkTMZg5hkNL/5rJUW8/3zrSWLOxl9P
         PciUGEzLCr8BCKMhlHO5XehZXz+rp5xYwk9KJo8Pu17LdeKgHWKFXf+kC6m9V2wHxlSw
         SvDRm33SGyqGN4lsagfi7UKiguh+6J/T918o/QBgILskjSgW+sCCo2ZKYKFPV15HNzAk
         wLsBpqwWv310AKAnfk6rl3/gLPRXvJ1Jj/NpCWIhFz7bYFFApGWrS3n8mTX2PWrYXqaE
         RuIoSE+YXGNa22tywa81BCeHVmWFLdi74f4/NntsrATxry+CBOoynIJi7o1KB6d/qAHn
         O5Ng==
X-Gm-Message-State: AOUpUlHrfbi2MWyrpREy/EKqGMAKIL8sU56SH9gszfvzEv/3vR0o7hDg
        905Yrs4swtX5TpOHi2lzuTs=
X-Google-Smtp-Source: AAOMgpdSWVdJpKhgNEnbHBH1QqRK+evMwMtxe+iU1qoncGy97tNhWZ4agc69mLkGBabQ1BwxWcPdmw==
X-Received: by 2002:a50:a207:: with SMTP id 7-v6mr4763579edl.48.1533242031136;
        Thu, 02 Aug 2018 13:33:51 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id k19-v6sm1375929ede.4.2018.08.02.13.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 13:33:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: Re* [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <xmqq36vw4vu5.fsf_-_@gitster-ct.c.googlers.com>
        <b72e5848-a51d-a62d-2a3c-36ea6b8582d0@web.de>
        <xmqqtvoc3fgl.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqtvoc3fgl.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 02 Aug 2018 22:33:49 +0200
Message-ID: <87effgtsnm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 02 2018, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
>
>> Am 02.08.2018 um 17:44 schrieb Junio C Hamano:
>>> Subject: [PATCH] push: use PARSE_OPT_LITERAL_ARGHELP instead of unbalanced brackets
>>> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> Date: Thu, 02 Aug 2018 00:31:33 +0200
>>> ...
>>> official escape hatch instead.
>>>
>>> Helped-by: René Scharfe <l.s.r@web.de>
>>
>> I didn't do anything for this particular patch so far?  But...
>>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Yeah, I realized it after I sent it out.  The line has been replaced
> with a forged sign-off from Ævar.

Thanks, FWIW that's fine by me, and also if you want to drop this "fake"
patch of mine and replace it with something René came up with (I have
not yet read his 1-6 patches submitted on this topic, so maybe they're
not mutually exclusive).

>>> ---
>>>   builtin/push.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/builtin/push.c b/builtin/push.c
>>> index 1c28427d82..ef4032a9ef 100644
>>> --- a/builtin/push.c
>>> +++ b/builtin/push.c
>>> @@ -542,9 +542,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>>>   		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
>>>   		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
>>>   		{ OPTION_CALLBACK,
>>> -		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>>> +		  0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
>>
>> ... shouldn't we use this opportunity to document that "expect" is
>> optional?
>
> I consider that it is a separate topic.
>
> I thought that we achieved a consensus that making the code guess
> missing ":<expect>" is a misfeature that should be deprecated (in
> which case we would not want to "s|:<expect>|[&]|"), but I may be
> misremembering it.
