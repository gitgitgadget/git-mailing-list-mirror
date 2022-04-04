Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9D5C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 23:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbiDDXH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbiDDXGy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 19:06:54 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF8A53721
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 15:32:58 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so730671pjb.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 15:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zH+ikfByqNvoUUrp++p8NJgc8P/I04+LB6ACwI+3UXY=;
        b=OJN3BZeQfnPlElMweDWeSeWqjwAEVqft+TuGSKbssTl4bADd244q17f4U+w7b6Den0
         qpNNBUky8ZzT0FC3nmu02zpHSvyeTEdvf8XFmgkFolrrZtvqx2fFhu4GFqgsYW+LLCD8
         U+eGoDfR9d8+gPc1wHr8tpH9LCrN5AkQqQtMGa8mndFJ9L/GTLwYCHoXIGhvtrBX7pKD
         zgYws/GtybsZnRlHva9SY0X/Na4mDUfCzwzILO5YWc2v3vOfKBfF0A8xfqwzErVaAB3x
         T7PBCgu55iV6Ch4b1OKCw+Te9Sp/WbHIeXI6PYzgwfhvirf23JPoOHNfD2xqA3GGjQrA
         0jJQ==
X-Gm-Message-State: AOAM531TKzqG+TVzlsCdg5XshgM+er8TciQqhXmp7FZzijsoy24I5plX
        poM2kkkKhUWoKhWh8HNFx5quLdi6jcxK7o1y8H6cuu+b
X-Google-Smtp-Source: ABdhPJwExcv5exxYppQInUBpzjgm0ZFHNh+9ubRSogLhR4MezDD7Q1oJzs56DYY+taahYweGdYD5SOmMXY2oQSKPWDU=
X-Received: by 2002:a17:902:d2d2:b0:156:cda5:e88c with SMTP id
 n18-20020a170902d2d200b00156cda5e88cmr428062plc.74.1649111578322; Mon, 04 Apr
 2022 15:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>
In-Reply-To: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 4 Apr 2022 15:32:46 -0700
Message-ID: <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CSPRNG_METHOD?
