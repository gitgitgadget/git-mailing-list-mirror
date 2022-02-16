Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC7C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 13:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiBPNCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 08:02:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiBPNCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 08:02:46 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9615F601
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:02:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f3so3198983wrh.7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=EM8y9kf6h1qBQOKIaoWUOJOZ5CszrUDc54R7FsuLDH4=;
        b=VzDKy8QZHvsbBsdAhMPpzFb+iHmKYUW5KNeaPFBMle7wfkmHxN/1XMlMpE2+FUh0DA
         qikqZVI/hV/iycKBZ03x3YphV9WjG6tKKQj53vMj6bgDxXWlw29PkdrQOOrvoYZ/BECm
         9lw+tfNCzWaPwuQZWvoX9RIMaV6T02KhFDosZs/Qv/Z5ZKXbvrnxeUO7eNl/9cy48jQS
         YtMgK1kBbuVW2yxQx6KdHClsJvBtj7IC61UPHlPHkqH+nNJ/JTeZceEXYMFPjdgA5gJJ
         WxHirerON2jLFV5PGtRA9HY2nUJk0VOwDVc+9FT+386T6NldN3uKdw7+wVvCh5VtQ3re
         PGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EM8y9kf6h1qBQOKIaoWUOJOZ5CszrUDc54R7FsuLDH4=;
        b=XujC18ocNVTVSXzbcGKzc4iYduUYcCLDhWyv8vFlyEgovFVFbJ03r0UrXbnG4nZNrj
         +82MFAoBPlaqV3+kQv8Ynz+jM7USNGOZt51tmXLrpSRZxl2i3JmgrWEPCF99VIi2NrDC
         c2OZOuBq6Y1fJGjat1S65IKN1W+CW8xlVHz07571kWCsUyCVhZXv5ZCDe+lClJkO2JKw
         kY58pXtH6tVfr1RpRUIa/jsa4jmGrsa6mWkLny+xofnd9R+PAidLJ4NT9ALBdnc8qn47
         fJmilfEZ11Qjj3AYg2wkJkAV895FMIcVVl/EHocqGv9qDpONG85SlRAu3f9C7RxBX0WS
         edTA==
X-Gm-Message-State: AOAM530DyVc2t27R6tCcJAcIemdK+yPKv45yNykI0CwIyG7oECNXWNOY
        p+Z+/5oHb6ySZ6sBREZ5rSGRCpzDhBeT7A==
X-Google-Smtp-Source: ABdhPJyFGTNZTFwNm6eIaIud8BIbnye0BNjwa3Gf6jxsjuFxVIIJgfyb1UkwSqrI4E7arsa7pfJnIA==
X-Received: by 2002:adf:f8d1:0:b0:1e4:a86e:33 with SMTP id f17-20020adff8d1000000b001e4a86e0033mr2208384wrq.456.1645016552069;
        Wed, 16 Feb 2022 05:02:32 -0800 (PST)
Received: from [192.168.3.156] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id s26sm18066427wmh.47.2022.02.16.05.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 05:02:31 -0800 (PST)
Message-ID: <e9310f40-c6d1-0e36-8aba-e9b840105513@gmail.com>
Date:   Wed, 16 Feb 2022 14:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: =?UTF-8?Q?Re=3a_=e3=80=90_I_WANT_TO_CONTRIBUTE_=e3=80=91by_Doppo_Se?=
 =?UTF-8?Q?kino?=
Content-Language: fr
To:     Doppo Sekino <doppo.sekino@gmail.com>, git@vger.kernel.org
References: <CAKg9Jn92h2PtiAtB2xt2XDPCHCQm+yW4Y7Puw_8dn38aRJCe+w@mail.gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <CAKg9Jn92h2PtiAtB2xt2XDPCHCQm+yW4Y7Puw_8dn38aRJCe+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/02/2022, Doppo Sekino wrote:
> Dear Git community staff
>
> Hello, I'm a Japanese Software Engineer, and I love Git.
> Today, I have a question about contributing to the Git Book of Japanease.
> URL: https://git-scm.com/book/ja/v2
>
> In the first place, can I contribute to the Git book ?
> If I can't contribute, I want to only share existing problems.
> If I can contribute to the Git book, could you tell me how to do it ?
>
> Git Book of Japanese for website, there are strange links.
> For example, This page.
> URL: https://git-scm.com/book/ja/v2/%E4%BD%BF%E3%81%84%E5%A7%8B%E3%82%81%E3%82%8B-Git%E3%81%AE%E5%9F%BA%E6%9C%AC
>
> When you click the link, it returns a 404 page.
> I think it is not expected behavior. I want to fix this problem.
>
> Thank you.
>
> Bset regards,
>
> Doppo Sekino
> Twitter: @Doppo1033 ( https://twitter.com/Doppo1033 )
> Github ID: Doppon ( https://github.com/Doppon )

Hi Doppo,


The problem you are referring to is related to the Progit book and the 
git-scm.com website, not the Git program itself.

In your case, the content is coming from the japanese translation of the 
book.


The places to visit for these projects are

* the git-scm project at https://github.com/git/git-scm.com

* the japanese translation of Progit at https://github.com/progit/progit2-ja


 From the type of error, the issue is probably coming from the book 
content that is not formatted for generating the website content, due to 
some asciidoc error.


Jean-Noël

