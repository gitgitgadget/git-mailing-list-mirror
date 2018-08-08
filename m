Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FE01F405
	for <e@80x24.org>; Wed,  8 Aug 2018 20:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbeHHWtW (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 18:49:22 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:32915 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729625AbeHHWtW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 18:49:22 -0400
Received: by mail-wm0-f50.google.com with SMTP id r24-v6so485532wmh.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XpQN4aUZKeyxFcfc+RCcjWA0NL0Ti7Z3u1fCZg58Mf8=;
        b=CUw06406ZDrR34aM4vlDgV0Hbdoox1apsCkalaxGsvDpfmUkUg2fiACX9M7JVzqbN7
         r3r7VpT0KP71c/AJMAPyl7n5WX1SxQzIFSGrwUScj0Yr0r1Ws3hor32T+Qy6soLpiHkq
         XjvIF9q7VBaYGvDtBfe0GlNlgjMX1WaXKQXfkIlGYfrxmvGIu2Olb+SO7sYEW9UsOWMb
         V2A5aAQF4BiGmtuG0O+7txygNa95ewdrqpaB9zovuf/aH1DGaJhHUrUXwrxQgxc7BUZd
         Wz1kpdGzB/8DUb3mhiyaO4cCbwLYb0a4WwAFq6d1z306fnh2LZCb4pR+LtgiEkHbtG5B
         8uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XpQN4aUZKeyxFcfc+RCcjWA0NL0Ti7Z3u1fCZg58Mf8=;
        b=TT15hJId4ytWPTk2eZx5nQN4iiyoO6NT8QMwVfvq0iXUmHClPn1xtb2O3c7ZRcUy3V
         Ue3GWx2Z/VLw1lWpIC8a1gXt7ikrO71r4hdTTdae5QMuzgtV4eNPiGnNQ6p+rJXxPjKz
         TkgvQI/j95RuHbXlrrHRK+PUcXuCy5Fj5J5wz4AiPzj+qK82VA4unuDrRWcU0xVsF7UI
         y7OGbLxrKGwTrbdffFbKdx4u5RMPO24b2ZDo0MiZcJeuPKYqUVJVQX2jS3KcNehi5pQc
         CIQKqf1dr++X2ez3E2MF77ehZnSOOyrakcuSxCZXfuUp48dGMTb9hq7ugCUZFRY3zcFi
         c3tw==
X-Gm-Message-State: AOUpUlGVPsVHROQzWONHxO0sUaP6qMfjvAl2OkZLDVLcDZ6t2XAT+ptW
        l+ALmLeqWDmEvD0pGyDm9pU=
X-Google-Smtp-Source: AA+uWPyQrXcU30yMxGD6qxoJ6Z+Q5hxQ2mJx1HcIYuTJYDimkyWJ7fvFc4xOhF4UTt/NrwlJjB+mqw==
X-Received: by 2002:a1c:d702:: with SMTP id o2-v6mr2760581wmg.115.1533760082259;
        Wed, 08 Aug 2018 13:28:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w9-v6sm5815029wrk.28.2018.08.08.13.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 13:28:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] Resending sb/config-write-fix
References: <20180808195020.37374-1-sbeller@google.com>
Date:   Wed, 08 Aug 2018 13:28:01 -0700
In-Reply-To: <20180808195020.37374-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 8 Aug 2018 12:50:17 -0700")
Message-ID: <xmqq600kfvse.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is a resend of sb/config-write-fix, with a slightly
> better commit message and a renamed variable.
>
> Thanks,
> Stefan

Thanks.  Let's declare victory and mark it to be merged to 'next'.
