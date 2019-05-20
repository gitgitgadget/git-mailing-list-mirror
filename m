Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F173F1F461
	for <e@80x24.org>; Mon, 20 May 2019 11:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfETLUE (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 07:20:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39956 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfETLUD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 07:20:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id k24so15776840qtq.7
        for <git@vger.kernel.org>; Mon, 20 May 2019 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n+enP/GrvVqJt0jbgL29OuW2rh316CCZHwJGuCpTgQg=;
        b=Oz8I6arey8qJDTyaGa8x5YcP29wwJq2rNSkp8G+KXwIOz50X4QDEh4kTGO+07V7PiD
         gIJbOwekYw2aEpCJdA6CaRNHkX0xTKuyYm258/ItGuf2rwJ0Rsk6QMoUL4+0mVsi85tf
         ON73lMhDalqMBXHOk1nwtkJBgpKP/czSFN7MSJUODhfnII/IC74ZKN5gHRJIcE/MXIFR
         Z8Wsxec1lvlril2G9aLHpxbSslZ0ER81L194RW6w8irF5x8g5vmO3J73t46jeXnzeysh
         HyqmhExUAZWXPO8TMuGnCF9rpT6vZAx1iEzPXXss3Ej1MxyJHxu7c7/8QIhoK/zuLKXk
         CyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n+enP/GrvVqJt0jbgL29OuW2rh316CCZHwJGuCpTgQg=;
        b=t560gW4AVcBANaLoREFFEqBSppneWDPHD3I3sPiHnPoroWZR4bNJSUVitD4B4B7f7h
         p699bwqDFL2QVPy6G9E9xr0Dj5gIMWEXQ02lXJhoBODvG5l+UEZDJ7hci4+vHJANWC0x
         v3KF7pfmiU4p45XaeOgZI4WxkeqDQIv2Mo4yIPSppDT/flL+NsMgTSQjn1iFF9eDGso+
         cf+g/pKGveKDfcYCZA2ohK6XETa+8vlNy81eDXNndIubOt3EFANZaogxLTOKD9Yvc+J5
         cjVCC5qZesyevXeP98nKE31/5j7/AxjzxuBC4PTjtp01yULkwzHwTI/Zv1Glz/vG6FSy
         yQCA==
X-Gm-Message-State: APjAAAUFx/RobKzBgiogFb5BYCDE+dcl7OdiQmxsmbHrbh1zRN8OywzO
        gmPpc7RV859Q0UXm8C2NAGmoFrqa1BE=
X-Google-Smtp-Source: APXvYqy7lQJyLGBHsMY1hEhqGm0zlw31MCKhdxPocg4bmoGTvWAgI3PU9C2bATh4LwyqEspmK8wrTA==
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr39800646qve.76.1558351202810;
        Mon, 20 May 2019 04:20:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8824:a533:8b:9681? ([2001:4898:a800:1010:395a:a533:8b:9681])
        by smtp.gmail.com with ESMTPSA id v48sm2929669qth.46.2019.05.20.04.20.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 04:20:02 -0700 (PDT)
Subject: Re: Revision walking, commit dates, slop
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
 <20190518015005.GA951@szeder.dev>
 <20190518035828.pjaqfrkkvldhri6v@glandium.org>
 <20190518041706.ct6ie5trvxgdhjar@glandium.org>
 <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com> <86mujhpewj.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cfa2c367-5cd7-add5-0293-caa75b103f34@gmail.com>
Date:   Mon, 20 May 2019 07:20:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <86mujhpewj.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/20/2019 7:02 AM, Jakub Narebski wrote:
>
> Are there any blockers that prevent the switch to this
> "generation number v2"?
> 
> - Is it a problem with insufficient data to choose the correct numbering
>   as "generation number v2' (there can be only one)?
> - Is it a problem with selected "generation number v2" being
>   incompatibile with gen v2, and Git failing when new version of
>   commit-graph is used instead of softly just not using commit-graph?
> - Or is it something else?

The switch becomes a bit complicated.

First, the plan was to version the commit-graph file to v2, and that would
include a byte in the header for the "reachability index version" [1]. Since
older clients fail hard on a newer file version, we are switching to instead
including the reachability index version as a value in a more flexible 
"metadata chunk" [2]. Using the generation number column for the corrected
commit-date offsets (assuming we also guarantee the offset is strictly
increasing from parent to child), these new values will be backwards-
compatible _except_ for 'git commit-graph verify'.

Second, we need to pull the reachability index value into a commit slab.
The generation value is currently 32 bits, but we will expand that to
64 as it stores a timestamp. The commit struct is a bit bloated already,
so this will reduce the required memory space even when not using the
commit-graph. But, it requires some refactoring, including every place
where we pass a "min_generation" needs to change type and name.

Third and finally, we need to calculate the new values and change the
read logic to sum the offset and commit-date (when the metadata chunk
says we are using corrected commit date).

While none of this is _incredibly_ hard to do, it does require a bit
of care. It's on my list to get to at some point, but making the file
incremental is higher priority to me.

Thanks,
-Stolee

[1] https://public-inbox.org/git/pull.112.git.gitgitgadget@gmail.com/
[2] https://public-inbox.org/git/87h8acivkh.fsf@evledraar.gmail.com/
