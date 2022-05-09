Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C3DC433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 06:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiEIHBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 03:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiEIGsf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 02:48:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1787A19668E
        for <git@vger.kernel.org>; Sun,  8 May 2022 23:44:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c14so11454700pfn.2
        for <git@vger.kernel.org>; Sun, 08 May 2022 23:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=FVqCPv4e9F4eJgXyqq9HqJMZiMkLBrRF2VTjVizAa+c=;
        b=PDqxDL1wtCX0x3b1Uy13JUFxFp0MosNi0y1PKsJ5n9fNB6lNFi1CbkW9muQh6Xdok8
         MGrzf5YihlEi/iPvQ5tlENX+EtVMfO3dK6qDNdbBG/cAhuyIwFnVxzBkPXUpbg/zZKai
         7cJxC5vMHjzoen5J70m2XXesr805qPjJ4Mk0VtaYeU5v52aHDP+lmdnMsyJLJNI9QB/9
         vdhZmAXU6Esx5zFSkbPONizLOzexo+yRYyGEXVoNDr2z7t+n0Zb6wGuQUnOlxrjt+ox7
         9yOtFPlLkktgxIC7W/CepWoVgnC1x7HxDC0mD0OD2Nke3Y68bV8AwXU2n6kuBR60NMEn
         SObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=FVqCPv4e9F4eJgXyqq9HqJMZiMkLBrRF2VTjVizAa+c=;
        b=oUP0SQXtndrHplM0n/lcKXjjky0DnepaugUBLJO0uFPj9mzR3iZKdFcKjXiMrSTQvn
         4698IwEPuxoeNifI4dvAa2qb+12r4leKpbvHr23gYquoYUjUplP21aIWHORyaQAV/pJD
         dwIrNsUKK/hQo4Vg3m8bZ6K72rDC9pS3ndDtdf3MrdXTtKef76tQCFRZXcrJXqQ+3r4L
         vIs60lvlf45TQVbbr7xDG4pQvPWqk1XEUDKqV5nJM0BMGUW/+JU9ywh39/Ae0vvOCM3P
         YKmGAPmS3ZX4blo7fpQw0KHChgVyr8HYlOnSzqn0ihifYrF6qiFWR1wAIraQ4EVKDKQt
         hs5A==
X-Gm-Message-State: AOAM531Hg5QThClibPJn7STAYkjoZuaJyeuax12NSfu/Ra3uLmfx6dzk
        ujOgaxT4a6GbP2bAS9mrS8A=
X-Google-Smtp-Source: ABdhPJwZBFFj9i2s7EVaFExX0JrlhscYrPh50CeveGynSIJcVRhouCGRwLt2Ghs2nzceMA/N9kr/TQ==
X-Received: by 2002:a63:90c3:0:b0:3ab:24df:fa19 with SMTP id a186-20020a6390c3000000b003ab24dffa19mr12083907pge.608.1652078657942;
        Sun, 08 May 2022 23:44:17 -0700 (PDT)
Received: from [192.168.10.73] ([117.216.44.92])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902d2d000b0015e8d4eb25bsm6332832plc.165.2022.05.08.23.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 23:44:17 -0700 (PDT)
Message-ID: <965b5394-9f72-e4a3-9ed4-6abcf67fb524@gmail.com>
Date:   Mon, 9 May 2022 12:14:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [GSoC] Contributor candidate introduction
Content-Language: en-US
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Plato Kiorpelidis <kioplato@gmail.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
In-Reply-To: <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

We were reviewing the proposals and noticed some missing information.
Hence we wanted to gather the information now.

Shubham,
You have mentioned that you'll be able to dedicate 35-40 hours per week.
We just confirm if that's feasible despite you having the commitment of
a full-time job.

Also, do let us know if you would have any other commitments during the
GSoC period that you're already aware of.

Plato,
Do leṭ us know if you would have any other commitments during the GSoC
period that you're already aware of.

Apologies for reaching out late. Since the project selection deadline is
approaching soon, do respond as soon as it is feasible for you.


--
Sivaraam
