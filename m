Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8D91F597
	for <e@80x24.org>; Thu, 26 Jul 2018 16:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbeGZSOw (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 14:14:52 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41050 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388502AbeGZSOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 14:14:51 -0400
Received: by mail-wr1-f43.google.com with SMTP id j5-v6so2394448wrr.8
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0aU4HskWgPdmmLv9k/NdrFHJ7x9ZWVlOEU3KuUY+znk=;
        b=dqO83xx4U588ygV5AsZos5ZbIKGM8T4SuC9UKCO3rNXbLTblciZzzQkPC5tI+ngFof
         dS+HdbNF1OAjq0TVjUWQnpmm2Q3gTvt2Sphn6q43uSTEfjUDtVDdoyN7qQis3vehypNN
         d9h3PiLJCS3Zujkuq/cqT80KkgzRLG/aRVryPGcuH4B45WY18nOjZS3EF1RsOAQnS+V3
         lAwsyvEQSGSd4AUfHVBHD9flRDvGuP889zuNQbSCmBNlmJKc4bRhDac+4Agm4zcgjG0A
         5wE2He5bzvmQbWok4fX1CUrtuRAOLYgzx4k+W2YIh4S1VR08hMdEa1u81UvzybhtTSJp
         9zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=0aU4HskWgPdmmLv9k/NdrFHJ7x9ZWVlOEU3KuUY+znk=;
        b=pggqrWRKjG38Basb3Y6MMet/kRb9My9FSHuqwyCi/5c2qXUfDZ8AA6YAvKHqIQyNyB
         EyNev+Xt75ORATM68mFld2j/TjIA1CeKqeNik9IZd10xCDpYj6kPilVDCrBVbb1dSp4b
         LX4pXR5pelZrHkFJKuYUjkzq6dWBWMAw2aLywBEdGvtyKMNaJy9szF139/Nt+FgZhE0Y
         yF9aYiMif4IA1G8TC6bVxWVAPwC7pgMM8HuXTDAUm3SbY6G7vAcEnx5H7h+TS9vayihT
         NE02B4FVIJtwyGL2c3y1FMp6KB+Fj5j455FntbfKzKEHUbtkkd9PbU4e53BjHHEE3T3+
         NOMQ==
X-Gm-Message-State: AOUpUlGRQ/MvSXUYthCBvI3xEDt5Db9SlBKmKotP2g+MY/739MMFAjBr
        9jD+FtDqAy5BYFYRkxipKnQ=
X-Google-Smtp-Source: AAOMgpfs/GcmDRIG5ck9By5ffIq9aSkoo7kAfRvY+SstJrSmSK5HN+VwGqSMsubxBKZph3rmJLcKkQ==
X-Received: by 2002:adf:fa45:: with SMTP id y5-v6mr2345207wrr.138.1532624229697;
        Thu, 26 Jul 2018 09:57:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p14-v6sm1964399wru.0.2018.07.26.09.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 09:57:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <CAL21BmkmxmjVmi3JUaW7vK5yGyzzZDxeMGNSSYV0nzEzWKcs+A@mail.gmail.com>
Date:   Thu, 26 Jul 2018 09:57:08 -0700
In-Reply-To: <CAL21BmkmxmjVmi3JUaW7vK5yGyzzZDxeMGNSSYV0nzEzWKcs+A@mail.gmail.com>
        (=?utf-8?B?ItCe0LvRjyDQotC10LvQtdC20L3QsNGPIidz?= message of "Thu, 26 Jul
 2018 09:07:03
        +0300")
Message-ID: <xmqqpnzaq6jf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Оля Тележная  <olyatelezhnaya@gmail.com> writes:

> 2018-07-26 1:13 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
>>
>> * ot/ref-filter-object-info (2018-07-17) 5 commits
>>  - ref-filter: use oid_object_info() to get object
>>  - ref-filter: merge get_obj and get_object
>>  - ref-filter: initialize eaten variable
>>  - ref-filter: fill empty fields with empty values
>>  - ref-filter: add info_source to valid_atom
>>
>>  A few atoms like %(objecttype) and %(objectsize) in the format
>>  specifier of "for-each-ref --format=<format>" can be filled without
>>  getting the full contents of the object, but just with the object
>>  header.  These cases have been optimzied by calling
>>  oid_object_info() API.
>>
>>  What's the doneness of this one?
>>
>
> It is ready. Thanks.

Thanks, the question was meant more to the reviewers and mentors
than the original author, though ;-)
