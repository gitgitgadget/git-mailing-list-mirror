Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185EB1F89D
	for <e@80x24.org>; Fri, 21 Jul 2017 11:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbdGULDp (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 07:03:45 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38587 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753850AbdGULDn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 07:03:43 -0400
Received: by mail-wm0-f44.google.com with SMTP id w191so10914641wmw.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DxABDJPqmI10hpaGAfenwmknkfkgEPGLojQeaL3RyAU=;
        b=KN/nIqvxQVMG2qLb6bsWXDSlQMueZbGW2aYCcFrLK8YvUd9CQKEG3Z8VilDVtA5Vvb
         pJP9a/xP61xBpCKeJigbTy8P/W/w9YXsNEWMmwme+HCtjZlQQLb/pMs+++cV8nxR5vKD
         2h35YjFEwdSyPrr2oBt2V2qjxnvinFvnVn40NU6r7ovJcnYY7VVGD/wG8z6P0pIElOT/
         puTZZef85ptX4ClpucehPL5wLGmzmlWejLPRgo/9Nrr3f1BBCbQSNElXjtUv+MRpeF/U
         Ymg9JT05XjovXiFwTUpRRxA/Y1K1Cbc3LPFfbapHKPuyeXJHcGGct0/igMI0d7zRfSKE
         su6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=DxABDJPqmI10hpaGAfenwmknkfkgEPGLojQeaL3RyAU=;
        b=VWol8+HeVFCFHc0s7nvWTiV41QIQcpE0dhjtjAaqRpNQqaYXh3gae50mGNN8YrvaxI
         K3YzleibSWtVsWKC1etXpJrR2HnVys7v8oZ35nhJTCRbZ72ANdJW+BlDe77uLdMbqjer
         eI3sbTjuu1oan1ov5ZfEsTc/A1BRTOA/ApPrjAdTXKs/kovtArPsSRfcfGSBUGzzvVQa
         0V8iwjaSatFM06ZRJ/lovEyXOElIvBCL9IsMixN8U58NZ9291OhHmdCpUZ/4py3VZdyc
         xYaVdXuGHcEgq7xaiGUfREoJYhIBQNlimPf50yvTDFdfO30CsDX2vW8tRqz3KSBiJ80i
         uYEg==
X-Gm-Message-State: AIVw111l8YqlRz228ruEhfzCpkyk9ogGuPhuQqxf8TUWiSlPDAuWk0eD
        ikYG/mItrmkefQ==
X-Received: by 10.80.137.220 with SMTP id h28mr4308355edh.153.1500635021779;
        Fri, 21 Jul 2017 04:03:41 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id z31sm1390439edd.54.2017.07.21.04.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2017 04:03:40 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dYVid-0005Zu-3E; Fri, 21 Jul 2017 13:03:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] 2.14 RelNotes improvements
References: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com> <20170720141927.18274-1-avarab@gmail.com> <xmqqshhqkfrs.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqshhqkfrs.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 21 Jul 2017 13:03:39 +0200
Message-ID: <87pocuoxv8.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 20 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Here's a few patches to improve the relnotes. I started just writing
>> 6/6 since I think (I don't care about the wording) that we should in
>> some way mention the items in the list in the 6/6 commit message.
>>
>> Along the way I noticed a few more missing things.
>>
>> Ævar Arnfjörð Bjarmason (6):
>>   RelNotes: mention "log: add -P as a synonym for --perl-regexp"
>>   RelNotes: mention "log: make --regexp-ignore-case work with
>>     --perl-regexp"
>>   RelNotes: mention "sha1dc: optionally use sha1collisiondetection as a
>>     submodule"
>>   RelNotes: mention that PCRE v2 exposes the same syntax
>>   RelNotes: remove duplicate mention of PCRE v2
>>   RelNotes: add more notes about PCRE in 2.14
>
> Thanks.  1-3/6 went straight to 'master'.  I am not outright
> rejecting the remainder, but I do not think these are release notes
> material---if they need to be told, they should be in a part of the
> regular documentation, and I suspect that they already are in your
> series.

Thanks. I agree that 4-6 are better left to the docs. I wasn't very
familiar with the format of the release notes / what you preferref to
list there & how.

I'll integrate what 6/6 mentions with my nascent gitperformance.txt
series.
