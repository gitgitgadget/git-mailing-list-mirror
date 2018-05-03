Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D3C2023D
	for <e@80x24.org>; Thu,  3 May 2018 06:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeECGnr (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 02:43:47 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33332 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbeECGnp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 02:43:45 -0400
Received: by mail-wm0-f45.google.com with SMTP id x12-v6so1562353wmc.0
        for <git@vger.kernel.org>; Wed, 02 May 2018 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L+HPKxmZgr6LRk3pPQDaZWiqfbz5o9Czab7ewfXXZVE=;
        b=iQMP6EEs93uSkVRaxSZ7prLsrNkXLve6jb24lWb6lF88AvwvuQOXfxyOP/DDlJxNGx
         PkBRGjH69hv/FWhnUY0SHb4iHvKUtXGASq7ZrVvq70VaOA8OagnD1qBP50GWIX5bR3fj
         5lLNLg3UMPK0+CzP5MkGJZ+rAEdexH5RItHHqrOkJcsuKwaO5yzxZSqnH/5j41n3J+6x
         ACRIRSNSTSlTibE8ttTq+820CFVr/bs7ZARGsSZph2pKW2ABFSKNc7NpD8PlS97CtsB7
         XouFtIZHHowtD4FBXOIE5IEGBXJBDbGmu7Aq/6aN+lz8ki6dcj+6aaPbohhqKndUB3tM
         jjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L+HPKxmZgr6LRk3pPQDaZWiqfbz5o9Czab7ewfXXZVE=;
        b=jA9bBClt3fHGk+iTmxT2aTgvQ4smzt8IOoxkSiInUVSKBxXIyuqhqwAAtCZpTaLtSE
         FlYDKYTUSlJrFbg5CcICYxTHO27OCx70CbXyGgA7VUilK0uooc5FjDvEt0mXOhpwMN5+
         qFZJy8h9ptBEz3UWtteKc7OFDmTr/pR/H+0gFysxGGKmFYG4LWEn0UIYPo8q1QekGn1T
         P9KcqzfdPDZTWjaCawEFCznPFp9AaXSk/xwnhu6qd1HfbWbhnpND500fvG8wba+Uzx94
         4/DDfXyRDdwVWPIRb1MzfWxZuQb5h1eB4uu9T+rrFGFxhnZ9nVfu0H+wcH04jTmIoc3g
         4dfA==
X-Gm-Message-State: ALQs6tCELR+eSoVcuZXRkY8F+yMAEIdfTglF0X88aCD5FfcmE6+ByTMz
        g8bhsXhgHfOSCVhNVvxhWA5xBM2eOHr49FyKfPQ=
X-Google-Smtp-Source: AB8JxZrBmID2RMgBWeXSfmgFE+6wGqg8nBLQaTPvmUYOyf/Dx28WI0qSacHV/oafelWRGb88PX+6s+8zRxtbUvziGCc=
X-Received: by 2002:a50:8f21:: with SMTP id 30-v6mr28795709edy.265.1525329816465;
 Wed, 02 May 2018 23:43:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.234.135 with HTTP; Wed, 2 May 2018 23:43:16 -0700 (PDT)
In-Reply-To: <385be5ef-7d0d-7e5d-4373-4d85c1a36a0d@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com> <20180501184016.15061-1-avarab@gmail.com>
 <f35aeda5-8f41-f457-736e-393e95f530ec@gmail.com> <385be5ef-7d0d-7e5d-4373-4d85c1a36a0d@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 2 May 2018 23:43:16 -0700
Message-ID: <CA+P7+xraqcnvg274_zaJO5Je1sJDfmEL=-orFZ4hL1Sg26Cd9Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] get_short_oid UI improvements
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 6:45 AM, Derrick Stolee <stolee@gmail.com> wrote:
> On 5/2/2018 8:42 AM, Derrick Stolee wrote:
>>
>> On 5/1/2018 2:40 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>> The biggest change in v3 is the no change at all to the code, but a
>>> lengthy explanation of why I didn't go for Derrick's simpler
>>> implementation. Maybe I'm wrong about that, but I felt uneasy
>>> offloading undocumented (or if I documented it, it would only be for
>>> this one edge-case) magic on the oid_array API. Instead I'm just
>>> making this patch a bit more complex.
>>
>>
>> I think that's fair. Thanks for going along with me on the thought
>> experiment.
>
>
> Also, v3 looks good to me.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
>

I also reviewed this, and it looks good to me as well.

Thanks,
Jake
