Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AAEC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 11:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbiAZLHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiAZLHc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 06:07:32 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB93C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 03:07:32 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id j16so11507086plx.4
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 03:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WgMG56CB8OIxXXXkA6+q9BZF8XV5Mb8C4Cg6Cew1Jhg=;
        b=RNVSIvVHCSXb3UicBpNO/aIlm7nAMsos/7hpd87t0QoZOfznKtRNaO0gPUUef/cNw9
         zRICQ3Zes6DavOEY9Z33loK6sJzzEh08BQDUPVoV2oVDuusiEjQ0LrxaASElb1cKxBtt
         NHsTOagUeUCX7XQndgqeiFzVI0pxEhA4z/8D1z69j8ObrDnPnBiMZ0vCmi/oIPCYDwH6
         j8bGJSpHp1RWqNmzFkotyc0V6hVC1EZ1dXJIOfhvHZiKSVA6UbiozLyk0Xl2D1+OgD7P
         jl5d4vfn/fXT7lwMroQ+eJknVymX6wLqVlxuSSxMW1GvWKRQDQlZB6tVBm616KysyX6f
         FyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WgMG56CB8OIxXXXkA6+q9BZF8XV5Mb8C4Cg6Cew1Jhg=;
        b=404zvl5NiNEqEQw7c0nReHbP+dGRe0U6BB+w1wn6gd/deZjae99pjNziM+g7jrXvew
         U2G7jKsqt4f64rSd3XV4Kzgt73zqk9H62KH7MBYTj8jebMnf9lJDoqsi8ddmMDYprPKE
         u4kzVJUswr0Qlr/hBMpbkzG/yZr5XJidJ11vMd9vD6HrjLxOa+XVDeJVrROkueIQkkHp
         4N8ujkOAq1lyArPCpAJND0cLV/nUZb4nonaxUDevZBRef/DE5n8rJs0ivaupfNZXZc+5
         AtG1yr8zZ8JcUwLVKMw0Ia0F2dVXO1OkWh7YUnI/umulas9W2kIqWmfadoafkMg5QHx3
         Mvvg==
X-Gm-Message-State: AOAM531DM40FDLcEzDEtnAjGF5IshaFerUXsMLiFruPcm++d54y8wJs4
        KshscaDWKWhLT8GpflUyTQ7dAM8ne9A=
X-Google-Smtp-Source: ABdhPJyig9M+rz8tk6Epb+l2UrPdXtwY+M9KDczvX5sgPkEW4r+LycoMpUZYozbKQsq/ToRNJYbW8A==
X-Received: by 2002:a17:902:d2cb:b0:14b:6611:4c6b with SMTP id n11-20020a170902d2cb00b0014b66114c6bmr9444253plc.7.1643195251830;
        Wed, 26 Jan 2022 03:07:31 -0800 (PST)
Received: from [192.168.208.38] ([49.205.87.95])
        by smtp.gmail.com with ESMTPSA id f18sm1828385pfc.203.2022.01.26.03.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 03:07:31 -0800 (PST)
Subject: Re: [RFC] Contributor doc: more on the proposed log message
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqqilua89z5.fsf@gitster.g>
 <Ye3JVEm77d7zMU5L@camp.crustytoothpaste.net>
Cc:     git@vger.kernel.org
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <700d8602-1efa-fe70-e9ff-5f5b7eb1a43c@gmail.com>
Date:   Wed, 26 Jan 2022 16:37:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ye3JVEm77d7zMU5L@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/01/22 3:02 am, brian m. carlson wrote:
> On 2022-01-23 at 20:37:18, Junio C Hamano wrote:
>> I have been thinking about making it more clear why we care about
>> the log message, and noticed that we have CodingGuidelines and
>> SubmittingPatches, both are specifically targetted for the
>> contributors of THIS project (not to users contributing to a project
>> that happens to use Git).
>>
>> I think the first thing to fix is that we have the "describe your
>> changes well" section in the latter, as if it is not part of the
>> code that is covered by CodingGuidelines.  You formulate the thought
>> on how to explain/sell your changes to others, and you sift the text
>> you add to help fellow developers into the ones you leave in in-code
>> comments and in the proposed log message, while you code.  I am
>> tempted to propose moving the part about proposed log message from
>> SubmittingPatches to CodingGuidelines for this reason.
>>
>> Independent of the above, here is a small update I would add to
>> clarify the project convention on the log message.
>>
>> Thoughts?
> 
> I think this is a good idea, since it differs from the way people
> usually discuss things outside of literature, and it's very common for
> this to trip people up.
> 

Precisely. I often get tripped up due to this whenever I write commit
messages in general. So, good to have this clarified through a guideline.

-- 
Sivaraam
