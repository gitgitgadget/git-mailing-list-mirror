Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A71C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D147A2399A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgIYRoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:44:21 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:39022 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYRoV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:44:21 -0400
Received: by mail-ej1-f66.google.com with SMTP id p9so4729942ejf.6
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avJR3kYovIyBq8mLP75hc8Z94xsboHomtYbOyTbWxSs=;
        b=BE/MF35k4yuA6RMggiOV+bHbgro7Qi58l7M7ef6nExUoSYABthyG73bpLRjqbeCCDr
         YJNe+m9D92Ca3Tw/Da2ew78x17CKnDn9FxWow4DD/ZZO2q25v3LMdaa7Ae0ERq8+ZEV7
         Ji88bmc0wqDEIPzrYVLFwX9kf8q8NH87Tkrs0oERMrGgzfhJnxsD57dQSqKoWEaJEWcR
         9ToVj1P3rB9AKowYSyuV2joHu3AEb8mZJcNzraEXScmX5yHWNmSMSS0NlWsijSkj3emb
         7cMxO9xPpEwm6+rzYTAvX0TG3/yuU/EWXjh2r1rjY7Apa69lMVGjPOcuaeV5zu8IVMKQ
         YhDw==
X-Gm-Message-State: AOAM532s1KgNIpILEXzs34492ELc85l7ndIJjPossazI4UOup+PvU3TP
        8ar0f1KiQOPAwBvApo+d/bm8bkMBOTQ2MYO0wlCBRo4OEMg=
X-Google-Smtp-Source: ABdhPJyR8Pp0QGZfpcxWxcmcCiXC025GXiCmkDUsQTdpKcA1Pd8pEbjiSCmlntqgXNvO3ep6mQ7deNpUf9icslHekV8=
X-Received: by 2002:a17:906:552:: with SMTP id k18mr3779319eja.482.1601055859890;
 Fri, 25 Sep 2020 10:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200925170256.11490-1-shubhunic@gmail.com> <20200925170256.11490-3-shubhunic@gmail.com>
In-Reply-To: <20200925170256.11490-3-shubhunic@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 13:44:09 -0400
Message-ID: <CAPig+cSr_EY7Z1tqEZyWF6W1Bxs8aOWyypv6m4Gv0ACz=j+O4Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] t7001: use TAB instead of spaces
To:     shubham verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 1:03 PM shubham verma <shubhunic@gmail.com> wrote:
> t7001: use TAB instead of spaces

Nit: "use" is a bit nebulous; I'd probably say:

    t7001: indent with TABs instead of spaces

> Change indentation style from spaces to TAB.

...which would also allow you to drop this line altogether.

If you feel that you must write something in the body of the commit
messages, then perhaps say something about how modern style is to
indent test bodies with TABs rather than spaces.

> Signed-off-by: shubham verma <shubhunic@gmail.com>
