Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555971F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 17:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938844AbcIFRvl (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 13:51:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36412 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938148AbcIFRvk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 13:51:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id l65so11925991wmf.3
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=s9T5uZk+/fSht/rnU3mRILgVUlEXwe7GCHb6PIknqEI=;
        b=n9LvAapaElmvGLELsHtScijtAsdf49N/+u7+X6DW73wPg56TL2o7Hdl8ignVQnsaPx
         UmWATgx5TDHDCv1EYlURi2FuzItcNGKC6ter0KIAipZDDu08M/VxAt/hUDQ+1kbu3d8H
         NT/04/iPDyO8MahpRhBwU3VKnoUS7h0wyXgLsf0uSLfh3SCZrWb73YUYrFHXdtgdEDYd
         fbmDTmz2jM7fc9Dpj2HhLv4a6r1a3fD7dQ93NsaDZnGKAg0sdN94HlKMwnUsEUGTy3RC
         bn2mVt2xQCMHA9vq1OhahoCI0KTl/LYWGUnKcfxTyBxrvmJx/Tphh5w5zf6RK3X8zhil
         /EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=s9T5uZk+/fSht/rnU3mRILgVUlEXwe7GCHb6PIknqEI=;
        b=UcnbWyg/RXRozm/U9mIydoHRWok2OzrtX0b3ZJf31aj+ebQGLGc7NJ33InpA9AEO6b
         crkO5GWwpcIo5x9qo4oUYH8LC4smzxi5qQBkdreHPc5zqxgzSGnkpmJUmLPzRSVyZFz+
         obJWalyq+0j3otaSiVt6xOinteoCsPRi5rSmUuxTkZtVQKpaXubN7QKHArqEDEAp/Gqv
         RBv7AknUj7P7+F2bZZYyhwc1ZIAc33uSsWhwStb7bXLTRpag9poOylsh31jP69/XpveM
         96rrJtSx6bNaOxmoY0tyUr+zfoiiHqENGrjMOV/viX0hhnY41b2p+tpRTe9x256MkGlf
         z29A==
X-Gm-Message-State: AE9vXwPl9qpN6dtKhNAPK/kadvd3VhmnbZwNqmdo3qpf/aATTP3Rsdlz0FR+804iY4qzTQ==
X-Received: by 10.28.8.84 with SMTP id 81mr8019823wmi.22.1473184298545;
        Tue, 06 Sep 2016 10:51:38 -0700 (PDT)
Received: from [192.168.1.26] (epw136.neoplus.adsl.tpnet.pl. [83.20.64.136])
        by smtp.googlemail.com with ESMTPSA id w203sm27518101wmw.7.2016.09.06.10.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2016 10:51:37 -0700 (PDT)
Subject: Re: [PATCHv4] diff.c: emit moved lines with a different color
To:     Stefan Beller <sbeller@google.com>
References: <20160906070151.15163-1-stefanbeller@gmail.com>
 <15618224-a9f3-bbe7-3556-8fd8aab2a2a4@gmail.com>
 <CAGZ79kZPzEYV=gdhzXQetXoe4+1zdh67eyL-gGh9EOCSbRwzWw@mail.gmail.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <82367750-adea-6dee-198a-e39ac7a84b31@gmail.com>
Date:   Tue, 6 Sep 2016 19:51:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZPzEYV=gdhzXQetXoe4+1zdh67eyL-gGh9EOCSbRwzWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 06.09.2016 o 19:03, Stefan Beller pisze:
> On Tue, Sep 6, 2016 at 7:05 AM, Jakub Narębski <jnareb@gmail.com> wrote:

>> If not for `color.moved`, I would have thought that instead of adding
>> new command line option `--color-moved` (and the fact that it is on
>> by default), we could simply reuse duplication of code movement
>> detection as a signal of stronger detection, namely "-M -M" (and also
>> "-C -C" to handle copy detection) that git-blame uses...
> 
> Can you please elaborate on how you'd use that as a user?
> 
> The -M and -C options only operate on the file level, e.g.
> these options are very good at things introduced via:
> 
>     git mv A B
>     $EDIT B # only a little.
> 
> So these options make no sense when operating only on one
> file or on many files that stay the same and only change very little.
> 
> The goal of my patch here is to improve cases like 11979b98
> (2005-11-18, http.c: reorder to avoid compilation failure.)
>
> In that case we just move code around, not necessarily across file
> boundaries.
>
> So that seems orthogonal to the -M/-C option as it operates on another
> level. (file vs line)

The idea for an alternative way of turning on color marking of moved
lines was to follow an example of "git blame", where _doubling_
of a command means more extensive move / copy detection (accompanied
by new values for `diff.renames`).

From git-blame(1) manpage:

-C|<num>|
     In addition to -M, detect lines moved or copied from other files
     that were modified in the same commit. [...]. When this option
     is given twice, the command additionally looks for copies from
     other files in the commit that creates the file. When this option
     is given three times, the command additionally looks for copies
     from other files in any commit.

Color marking of moved lines may be considered enhancing of exiting
whole-file movement and whole-file copy detection.


But it is not a good UI if the feature is to be turned on by default.
Your proposal of adding `--color-moved` and `color.moved` is better.
 
> In another email you asked whether this new approach works in the
> word-by-word diff, which it unfortunately doesn't yet, but I would think
> that it is the same problem (line vs word granularity).

I don't know how it is done internally, but I think word diff is done
by using words (as defined by `diff.<driver>.wordRegex`) in place
of lines...

Best,
-- 
Jakub Narębski

