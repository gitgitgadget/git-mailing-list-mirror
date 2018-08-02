Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41E81F597
	for <e@80x24.org>; Thu,  2 Aug 2018 12:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbeHBOcn (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 10:32:43 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:53715 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732110AbeHBOcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 10:32:43 -0400
Received: by mail-it0-f54.google.com with SMTP id 72-v6so2981424itw.3
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qvT5ddwvCcj/3nuQQQx1XzjJfO7jFTHdT6N9CZRY0uI=;
        b=Oh3Q6T8nVZGTYolu29x59CdXGbEeX4oGUncocAL6c6MFtQvVeBQAWZODVMh5OUdSZ+
         tBQMeq0M8Ycs+336RirCfYJaERoYHqnmC5Qp7OdEEkyj//Z6FaIeKy4+o+1WNGRRBY2A
         kmpmsZ6gKaf2+bkwXY3IjzGHcI7IKx9QY16027AGqEwTsjHx02tcytsP6p4Fn/vsg3kw
         pqdXqncV0j6uh7x5o9Uqgp85gLo+jebH66ZCjZh2t+LoCsyfl9TZPMZZclx1QaSKpJO3
         fBYraSZgThnaThdTgQIkYMnBy1mPW7TjEA9xVQewSNn8ODudpurvGw0xjo27BG5MM5pY
         7lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qvT5ddwvCcj/3nuQQQx1XzjJfO7jFTHdT6N9CZRY0uI=;
        b=XjLS9YCeyhI+B2K0PgVQJh8YkaBbKNG0mmRK8CSpfsvtQY4mhAxjXiP42kVlICpr4+
         PyigPNNCiQy7MAw71h/06unNUtrwOFV461BQI7yprlCjz4+ILRbb99xNA6Ba0VR1ditB
         KuK20nFMb/ZV/rWKI3a5cy0EPZVR6/bQbRbDDbHyVpjT3MSn+XiEXGJsBm7Ug6OkiDxj
         2SNPKLMWhUv7Csl9tiWZBLFtkjcqiyW0UZMMys7o0he6ECUIEJpJmf417BvNIheTG/FK
         YVCI4InYSLh4DOXNHXvN76i9Zz3eBgQNl89q7ZgYEiwniM1UmLBXbmBSMMq7X+fZ0Jpv
         52NQ==
X-Gm-Message-State: AOUpUlFLrAf3Pe54Xl+UMaAQoVMe8OJ3AIJ2/CX4ETVTTEQd+q0jSxJm
        in8EplxemD6Ecv/j6WkSVBq3WPMF1BHf/ompLKM=
X-Google-Smtp-Source: AAOMgpflv/ljjjD2eAXixpLe182ImCvxKSAjlrhpYMeoLzA4VH3szHB/TenhhBpfI81A3vGv9Ik/Evw0DeCLdMDNc5g=
X-Received: by 2002:a24:54d:: with SMTP id 74-v6mr2179805itl.96.1533213701832;
 Thu, 02 Aug 2018 05:41:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 05:41:40 -0700 (PDT)
In-Reply-To: <xmqqpnzaq6jf.fsf@gitster-ct.c.googlers.com>
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com> <CAL21BmkmxmjVmi3JUaW7vK5yGyzzZDxeMGNSSYV0nzEzWKcs+A@mail.gmail.com>
 <xmqqpnzaq6jf.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 2 Aug 2018 14:41:40 +0200
Message-ID: <CAP8UFD0yWYvrbgtKjUs8oVks36Rp4qpfGAj3tambixSeC+-_1w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F  <oly=
atelezhnaya@gmail.com> writes:
>
>> 2018-07-26 1:13 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
>>>
>>> * ot/ref-filter-object-info (2018-07-17) 5 commits
>>>  - ref-filter: use oid_object_info() to get object
>>>  - ref-filter: merge get_obj and get_object
>>>  - ref-filter: initialize eaten variable
>>>  - ref-filter: fill empty fields with empty values
>>>  - ref-filter: add info_source to valid_atom
>>>
>>>  A few atoms like %(objecttype) and %(objectsize) in the format
>>>  specifier of "for-each-ref --format=3D<format>" can be filled without
>>>  getting the full contents of the object, but just with the object
>>>  header.  These cases have been optimzied by calling
>>>  oid_object_info() API.
>>>
>>>  What's the doneness of this one?
>>
>> It is ready. Thanks.
>
> Thanks, the question was meant more to the reviewers and mentors
> than the original author, though ;-)

I just tested this patch series on git.git on my laptop with the following:

$ time git for-each-ref --format=3D'%(objecttype)' >/dev/null

and the best I can get without it is:

real    0m0,038s
user    0m0,034s
sys     0m0,004s

while with it I can get:

real    0m0,017s
user    0m0,016s
sys     0m0,000s

The results are similar with --format=3D'%(objectsize)'.

So I think it is a nice improvement.

Looking at the code of the patches again, I can't see any simple way
to improve on the way it is done.

Thanks,
Christian.
