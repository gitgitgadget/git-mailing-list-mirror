Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8503C20193
	for <e@80x24.org>; Thu, 27 Oct 2016 23:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034250AbcJ0XQx (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 19:16:53 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33776 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034173AbcJ0XQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 19:16:52 -0400
Received: by mail-vk0-f52.google.com with SMTP id d65so13306057vkg.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m2y1u+XVtNM9jczfxHgE9j4SxeoThMmFCfmvfd1qE8M=;
        b=c7pwHbRK8kSQwRN9n6n4uJbRkdGycyzhXtjJuXbM+O3uAJDh41FS3AcMpOAhzMzYkj
         l8k4k+DTgGLHvLqEIK1vsTF+YiFqlaBpM5zp11w35u7z77t//0BTPLs6wureItFTSq4P
         KavB7dbhHAoOvyK0IIQqLiiU0YV76CNJNFDoNbcV0p8E/TZePXR1MyeAXwyqXUt3LXv3
         BoaY3fnaM/nHLnilv96DLzrfSbklgI/JD6RyEuslxzCuBEVAEkLhc2h65FeewJUKaseu
         /YQKu+CgCfim/Sj5a/viDpYxtDWijBuUukb44+XD6cZO9POUDy3YKX/q9k4XgM+zRgFJ
         Ry4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m2y1u+XVtNM9jczfxHgE9j4SxeoThMmFCfmvfd1qE8M=;
        b=SR5FMd9iuzAjrPB5nRGJBLVJoR0X4SA2C21qHehqDzB+G/PiJY1OG1TjFlot6viplW
         idblfogFsqmnH7ExqrS3qX78pFZpxxiaAQyZmX4IbnYD6DNhpp5sCTDdry4N1R2ZmP2R
         e6ExkK75s3W3+guPQupzNxEEPREnACCPyKvIyiGBGO1+2Lsrpnr94LEd59yDMZaxEoFu
         /2qaA30hf2ah0rI9AwCaH+kfVwWW38g6eCnC+6r5Oxgacd4kzam9QLw7YmehhfNmBUL+
         DkZ3+Dm5ZiONkn1orabWPKGjXD9+h14xSweImHb5yhKkUF53G0rJo90UVOuAAgkou0R/
         BBjg==
X-Gm-Message-State: ABUngvcb/0JFVIv2P9wcKi1DYcJFn7scqhYBp7W5LCaUhGXUz+r/WQKnql/v6BVrHlxqDuCYIhOBgHrG7gWPUA==
X-Received: by 10.31.133.130 with SMTP id h124mr9815052vkd.24.1477610211596;
 Thu, 27 Oct 2016 16:16:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.205.131 with HTTP; Thu, 27 Oct 2016 16:16:50 -0700 (PDT)
In-Reply-To: <xmqqshrh4d91.fsf@gitster.mtv.corp.google.com>
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
 <CAGZ79kZAfqxB699MOs6A6RL==Ku-qF7ABiW=eA+TSrqK+8e_sA@mail.gmail.com>
 <CALj-rGeMHyN6Xhc0_KCChmWL4BDyF-ZJYdipbe1_yNvznrYPVA@mail.gmail.com>
 <CALj-rGfsy+KA=dsd+wobMiVOWHK1GU=dZRcQWtMoXwtBrMYPLg@mail.gmail.com>
 <xmqq1sz15swv.fsf@gitster.mtv.corp.google.com> <CALj-rGdTfYYn1Nnksh=WijkJxknBUeqci3i3uujH8yzcE1z_8g@mail.gmail.com>
 <xmqqshrh4d91.fsf@gitster.mtv.corp.google.com>
From:   John Rood <mr.john.rood@gmail.com>
Date:   Thu, 27 Oct 2016 18:16:50 -0500
Message-ID: <CALj-rGfa5qWHiR42ggN3nWS56SGKHbcLttcyO-zLsSY6BfFifQ@mail.gmail.com>
Subject: Re: feature request
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks. I wasn't aware of --no-edit, but that is indeed exactly what I
was looking for.

I think your point about encouraging users to make good use of commit
messages is good.
My concern though is that vim isn't encouraging users to leave good
messages as much as it is scaring them away from leaving messages at
all.


On Thu, Oct 27, 2016 at 5:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Rood <mr.john.rood@gmail.com> writes:
>
> [administrivia: do not top post]
>
>> What I'm really seeking is not a make-shift solution for myself, but
>> an intuitive solution for the novice user-base at large.
>
> Well, there are -m and --no-edit.  Recording commits with useless
> single liner is a bad habit to get into, and change to encourage
> novice user-base at large to do so is not a good idea.
