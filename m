Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CE21F453
	for <e@80x24.org>; Mon, 11 Feb 2019 04:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfBKEDC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 10 Feb 2019 23:03:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35943 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfBKEDC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 23:03:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so5676655qkf.3
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 20:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gCwiyN7WRmvXzt5OMudkNEksdE/DzKQDXYNR9ZTokM8=;
        b=P8zf8e0MKRWl+3pLi8g9dG5Qjxswv8lRZLxuK4k7t2C68PjK0zP8D8ptnN3RcCu2j2
         FZPUEoYW9ldwDZnBYgD1GQPfNjrc8F+1Fhfw6mVSC4s4r0CDZhGXigVt34bCArv1MxcR
         T1MUa5zc+258ZKu2nXo2hiLYbOOLHnKSZt24lBWVus07+joT8PPex+tWbZajI1AAvAIl
         GjwHp74o5QUxAss6BnTWCLv19wcGXMTYr1HJ34MEnqr5GTdVTtNFDjM8MMUJTHh1lKzU
         ML7N4E60xuFwZMbCDhgKFuQsV29wUejCmiISDlrbneNGO2Rt8MJitj63MUrrUy1l3TCJ
         AEWg==
X-Gm-Message-State: AHQUAuazvMACQ/Dw8mM7ODAo/rHuhWNGjYARZuJJalzO6t4bGtUrw0Hh
        cqXIWVYqW7F215115efONoyR/eeWU3fumQNUQ1IxjA==
X-Google-Smtp-Source: AHgI3Ib/SNCKfOPhkhmWFnD1qPoKYUEcLNFL94jAPhT+E/iqmV7BNYBSfsva5wVRrY9UoU4uqdJ/h9W7tNgEjUN4C2Q=
X-Received: by 2002:a37:c313:: with SMTP id a19mr20522631qkj.220.1549857781319;
 Sun, 10 Feb 2019 20:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190208090401.14793-1-pclouds@gmail.com>
 <20190208090401.14793-10-pclouds@gmail.com>
In-Reply-To: <20190208090401.14793-10-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Feb 2019 23:02:50 -0500
Message-ID: <CAPig+cTFEc9v_60xJvF13U6RtOYThfqU+vFEUbT8KCknMbhMeQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] switch: better names for -b and -B
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 8, 2019 at 4:05 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> The shortcut of these options do not make much sense when used with
> switch. And their descriptions are also tied to checkout
> out. [...]

"checkout out"?

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
