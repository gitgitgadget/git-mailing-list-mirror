Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B38D2027C
	for <e@80x24.org>; Tue, 30 May 2017 12:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdE3Ml3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 08:41:29 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35263 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdE3MlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 08:41:25 -0400
Received: by mail-it0-f50.google.com with SMTP id c15so40632010ith.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lRY7i311YOAZ5q8lP+tUzrrbbc+T51RkSGbLXCdvic0=;
        b=nuqLbaa57I1hBhD+NDLeu7hjUvShoDgZZHKdI6giXdlofavtxzOJt7JDGnquNwkut9
         3JU+7ghbwS+qw7sXKmD0QCBrx00juxEi/1uTK2qONq7bKOMUba5SilMVtA3xmlAEy2LE
         gCJDYgs0ri/nzt8Qx+kRtxlUX8PIszZ0qazj6/KXNgRvchYXMIgbPbmaubcxncldSOdO
         ZPAaOoKmPiVWjPfW200MywLAS3H42yaOGJNub34PS+h/wTxNnuBndX0YuzuILoB56rEy
         faaX9sCnXjmF+zFQYWMdd0w/RoVgPN9yivpnjMx1qSeTyOuPkmw8EeuLiwmyXQoNSpmy
         XXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lRY7i311YOAZ5q8lP+tUzrrbbc+T51RkSGbLXCdvic0=;
        b=iaqqoU5jttfbq6YXe3j9NeIc6DxsSIZZS2sceshSLBFQ6jS3hdJnb1pcvDX/+Ue/WU
         0qUIehhHoj4aWFobjkgzSFctvE8DT/eToj9CvE8o2EblDuL5PMq6yrNWdTuqFdT+HZSR
         MDzpkwVVWNCQVHrXoqFPCgPRU05bJTCOYoR0r0slCO2UgnCScF52qP7GbM2ck94eKe7R
         5BsfAMr0SG9ANSpxY+JjysfuNg503BedHkDAGrohHP9ItEbemgXRa1tuJ9hShKhppTld
         jHBXwhAldqGU96BVqp0gIV05c8xCZ+kX5Cn1rUFiY+X6IXexPbcsJ5UZvqx+xEPRxEvd
         eDdA==
X-Gm-Message-State: AODbwcDp5qGZT3yo/fsJAl8KfYEH56GIZqgfl6t6XCVUgIleRoMQUq08
        awylb5Xu4Rr7ZN88/9iwFAUUCs89/A==
X-Received: by 10.36.166.4 with SMTP id q4mr1569820ite.66.1496148084465; Tue,
 30 May 2017 05:41:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 30 May 2017 05:41:03 -0700 (PDT)
In-Reply-To: <85970ab4-e9c8-c6b6-11d3-faafd3ed0708@redhat.com>
References: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
 <CACBZZX5U=U1bpiFuuxH2t8ZWnmQQAjWm1ji8XYq_6-SJPGL1sw@mail.gmail.com>
 <c2453701-979b-ebc7-dcc3-483a27d4c157@redhat.com> <85970ab4-e9c8-c6b6-11d3-faafd3ed0708@redhat.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 30 May 2017 14:41:03 +0200
Message-ID: <CACBZZX4-T50q_eVWwJuBzoC6ocuG+v14Tm8wfK8h7FB_cMQzdQ@mail.gmail.com>
Subject: Re: FORMAT_PATCH_NAME_MAX increase
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 2:33 PM, Laszlo Ersek <lersek@redhat.com> wrote:
> (apologies for the self-followup:)
>
> On 05/30/17 14:28, Laszlo Ersek wrote:
>
>> Note that in such an incremental review, I specifically wish to compare
>> patches against each other (i.e., I'd like to see diffs of diffs, AKA
>> interdiffs), and not the source tree at two, v1<->v2, commits into the
>> two series. The latter would only give me the difference between the v1
>> and v2 patch application results, and while that is valuable as well,
>> I'd really like to diff the actual patches.
>
> ... One (but not the only) reason for that is that I'd like to see the
> v1->v2 commit message improvements as well. I quite frequently suggest
> commit message improvements in review.

This all makes sense, I think a way to make this length configurable
is the easiest/best solution to this.

Just curious do you know about https://github.com/trast/tbdiff ? If
not it might have a high overlap with what you're doing.
