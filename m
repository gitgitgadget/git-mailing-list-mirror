Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65ECA1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbeGaPU3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 11:20:29 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42177 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732110AbeGaPU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 11:20:29 -0400
Received: by mail-qk0-f194.google.com with SMTP id 26-v6so10210769qks.9
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XrUjgKk3iwWd8xu/IRM8Lei2MdJqWl2XXz2RAz1g/SA=;
        b=ROv7Wk4FwJits0Q6Z9cvsEsLAFsGcaQ1QjOC7K3/pbsrlcCT+1o2GBqUBr1jTWtaFJ
         xQnUd0dpVYvS15L1zrSkIGf9lcBV3Qo12pb1h+ByEsBCslYAVUVboyRGThH4ola8XFek
         sJgRf++ffsXlWpJf8fe/QlkKqNX0DjIBdA1tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XrUjgKk3iwWd8xu/IRM8Lei2MdJqWl2XXz2RAz1g/SA=;
        b=b6rxfi+3NOs8v6sM9AxSOOkWlRsoUd+ZPmuMEWUlHVVWnQbV9qYwvGNHWU361thNhw
         nLStbTyGzrgHjWcltBt806i5EKWDq/dkHA0zXJmHBNHipDdUA5sPQ66DUaqxizcXjKhZ
         btV9IbbXc2AhN/Tszivu2zPhyJgR/HayTd2TVzCs/e8QskqknN6d9Yfxhue2AQPOx9M2
         nncQm/yXABB5ily3hp9jR1xQhCtpoVNKSWRMS1dH/xwsSnv0OtNo22VrHf328Vs95wFh
         n/9EZR8L2/U/rjdjoAxVkmTnwQCyXUW09fn8NwUW81GR3pwMgYOe+DKzfpM+md4nXZTM
         HAIQ==
X-Gm-Message-State: AOUpUlFbiRkma1RfkbJ7ZSmmo/fmFIIIDOFJM5O3SAFC6fjOUnEj7eGU
        7PQuQbiwiMkbhEuJtrW4kmIcT2HQ8y8fOQOzK2DJJg==
X-Google-Smtp-Source: AAOMgpcd7rZ9EdoEAsLM7zdP2veQX1ThR1Jje2j/nsn9270gNhPb/mgLlDD/qRWcTZA+jnK0fC7DUerRaWJZVh27JIA=
X-Received: by 2002:a37:7882:: with SMTP id t124-v6mr19939283qkc.367.1533044405808;
 Tue, 31 Jul 2018 06:40:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3763:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 06:40:05
 -0700 (PDT)
In-Reply-To: <20180731084638.18793-1-szeder.dev@gmail.com>
References: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com> <20180727112222.19061-1-chenbin.sh@gmail.com>
 <20180731084638.18793-1-szeder.dev@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 31 Jul 2018 15:40:05 +0200
Message-ID: <CAE5ih7_jh55mLVBhiu12gmc0j3mGkm4s0VU2Stx5iGf1tK6yzA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add the `p4-pre-submit` hook
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Chen Bin <chenbin.sh@gmail.com>, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think there is an error in the test harness.

On 31 July 2018 at 10:46, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:
>> +             test_must_fail git-p4 submit --dry-run >errs 2>&1 &&>
>> +             ! grep "Would apply" err

It writes to the file "errs" but then looks for the message in "err".

Luke
