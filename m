Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33EB41F453
	for <e@80x24.org>; Tue, 16 Oct 2018 05:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeJPMtl (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 08:49:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51001 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJPMtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 08:49:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id i8-v6so20844113wmg.0
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 22:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5VuwnCrrEn2Z6YYtqappwL7X0DMm6zithayyCNEIiWU=;
        b=Xav4NtF5lyKAXjTv920qSLkTRJABq5YlLd7X/ELGoHvIABmPNhymg3yr2Y1aoa0mAB
         cxnZRPZx7W3JjNyrX4gvMEBhwPOxSLQAu40vTnIAHo6O4xnjv8fpm1HoGZi0ptpQlNov
         5DQC4ZaFxnHLJqwExyZrHeNfG3Tnnp6PJ2whpzXiaynhhrKU3Cl829mZEX+wmMbO0j2H
         mvymljeeT02r2r5Nelsr6RWw/WdPm5xAEGDq3OCCKRqQnEAlWR+Gl1m5EgaBLMRWHh3P
         e0NvoYAk0ir6nhy8fjNmVdWY8kBUg49Fnf0O/1kcERbudQczDYfejJW7Tk6xk4kQ7tDt
         E5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5VuwnCrrEn2Z6YYtqappwL7X0DMm6zithayyCNEIiWU=;
        b=APmalm+edkImzmQKjKhMgcW7oHRyGHh30/t3yGKdYuLpMT/bF1I+fXVRBKWfU4W9oy
         v/GFQq5c16fs7CQDkgfbMsQrirTyTyUmIJXpt09fPREPBDJNkooJVD7V21H1G89nbazV
         pbceofrEliT+MRzOXTrvTZJIkVyKw7Cp+l5/RHjGJkoEgVGQNOA7EnGCv+tTW5/TJZxw
         xod2k1mxAV368kWKHok1erzUASsf6HyrXUN9g7vPeWdJJ3ZWTtrK8Ce+NvlUcYYZiXvH
         nXfA5eUsQhqYuk5WcaxDsJb0MM+tL5rWPv4OfAdUtL1+UmlavuRoIA4BZQIsIWx9SG98
         vtWQ==
X-Gm-Message-State: ABuFfohG06FvvoYxQVj15LdsKuChrczzW5sHTTRfH2IS1v31d226L/GX
        O3g44AjGUFZNo9T0dq75BuM=
X-Google-Smtp-Source: ACcGV6202gHpyZ63kUmXI1hOQ55VMWqhKt/pa9QjokT5VzIV8ip3FkbYTf+94XY11KU9NMeVThMAnQ==
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr13949162wmd.99.1539666064721;
        Mon, 15 Oct 2018 22:01:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u10-v6sm9617750wrt.59.2018.10.15.22.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 22:01:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Hesse <list@eworm.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] subtree: add build targets 'man' and 'html'
References: <20181007073036.30643-1-list@eworm.de>
        <xmqqmurmmt9j.fsf@gitster-ct.c.googlers.com>
        <20181015231501.5a7524b0@leda>
        <xmqq1s8q4pen.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 16 Oct 2018 14:01:01 +0900
In-Reply-To: <xmqq1s8q4pen.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 16 Oct 2018 11:05:20 +0900")
Message-ID: <xmqq8t2y1o4y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Christian Hesse <list@eworm.de> writes:
>
>> Junio C Hamano <gitster@pobox.com> on Wed, 2018/10/10 11:26:
>>> As 'contrib' material without real maintenance, I do not care too
>>> deeply, but shouldn't this change be more like this to avoid
>>> duplicating the list of targets?
>>
>> Probably, yes.
>> Do you want to add this yourself or do you want me to send an updated patch
>> or one on top of the last change?
>
> In principle either is fine but keep in mind that I'll likely forget
> if you leave it up to me.

Actully, I take it back.  The original patch is already in 'next',
so an incremental on top of what you sent is the only valid
improvement ;-)

