Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E46E1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 16:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHBSPR (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 14:15:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46557 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeHBSPR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 14:15:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id h14-v6so2699982wrw.13
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QiJD2RmXmlyFbBy6y/4Om1v07Bvwijg/5lQBAiZC+aw=;
        b=Y/D6jnJkHd7t4U4xKa+FoDbAQ2GRGIf5CLI2U5Qj2H+1d0C/yeoMcMDGYqs2CIDCuZ
         okR5RuMjTQu3euXCPWLTAAMbDA7DPTRLQkJp6GHmadmFk6CtLUzFVXL7aI/VLlt2VySU
         xMoHesKJXcx8I/3YxdKiLiAe1eJpgF6kKkmda//fTT4Hi3GGgXV9RUworJaI9q0F9J6v
         /HS4pV3AH1cXvVFy77B01WVv2HzDxPwBP4D0TSIozVszVRn/kf2PIv177z+TazTmU8Zw
         aRLSAaak0N3/+TWbqw3kRRcWoN35RvmjBlR226KT/KgEKv8PS9VgBtKng+OKh2nNGYwk
         4jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QiJD2RmXmlyFbBy6y/4Om1v07Bvwijg/5lQBAiZC+aw=;
        b=Id3nbjC/nw7zYIO0ffQibZZR1vvsRjuwd2WCfE+QHgOS5mZ+Gz0gNWO/8TmQaGSlAQ
         B/CXjXDji9EtAsIr83oD/Ca3ZcFRefD4MRr89L5yuxkuIpeELpCTh5Csv36HMYSet2k4
         SY1qso8ukhGDf4BjiEh2SBmesVo6z+/pXyqcxEx28LVhutJ6GLbZ07bvg1zmWqOjl/aA
         fUXfbr7/VCGEvVrVUkCGqQruEq9000Az0vNiuecji8FSv9z2Dca5lFP3Pwopq6w55WOz
         zaMRW2QdxLYSk+i4kant3eEtswJOqtxdLXxAuK7eaYnDMDdAYxiYS3/RYp690JTpezrW
         mmpw==
X-Gm-Message-State: AOUpUlFDF0eCMGmLw72SQpa5xi5CVb5X9k1xOhoFdEYoy7grl35D1dXV
        frJn9vva/ZgG7zcmvHaI2W4=
X-Google-Smtp-Source: AAOMgpd58/KqHpCqTen2AfWZEMI4PsYoLkSigRxyQTif88AcY186hwgvFAE1/CC0oSo7i5nq35VZYg==
X-Received: by 2002:a5d:694e:: with SMTP id r14-v6mr103370wrw.278.1533227003967;
        Thu, 02 Aug 2018 09:23:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a2-v6sm2432461wmb.6.2018.08.02.09.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 09:23:23 -0700 (PDT)
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
Date:   Thu, 02 Aug 2018 09:23:22 -0700
In-Reply-To: <b72e5848-a51d-a62d-2a3c-36ea6b8582d0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 2 Aug 2018 17:59:18 +0200")
Message-ID: <xmqqtvoc3fgl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 02.08.2018 um 17:44 schrieb Junio C Hamano:
>> Subject: [PATCH] push: use PARSE_OPT_LITERAL_ARGHELP instead of unbalanced brackets
>> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> Date: Thu, 02 Aug 2018 00:31:33 +0200
>> ...
>> official escape hatch instead.
>> 
>> Helped-by: René Scharfe <l.s.r@web.de>
>
> I didn't do anything for this particular patch so far?  But...
>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Yeah, I realized it after I sent it out.  The line has been replaced
with a forged sign-off from Ævar.

>> ---
>>   builtin/push.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/builtin/push.c b/builtin/push.c
>> index 1c28427d82..ef4032a9ef 100644
>> --- a/builtin/push.c
>> +++ b/builtin/push.c
>> @@ -542,9 +542,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>>   		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
>>   		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
>>   		{ OPTION_CALLBACK,
>> -		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>> +		  0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
>
> ... shouldn't we use this opportunity to document that "expect" is
> optional?

I consider that it is a separate topic.

I thought that we achieved a consensus that making the code guess
missing ":<expect>" is a misfeature that should be deprecated (in
which case we would not want to "s|:<expect>|[&]|"), but I may be
misremembering it.

