Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5B3202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 15:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbdGGPFV (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 11:05:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34055 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdGGPFU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 11:05:20 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so4426191pge.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DFjdc9vV3km7rWJpRqUND/UaYQOisoAu52A1NJaHarU=;
        b=f1B7LC2Dykz3R7NsUA/kYGxiJRtemQce3mfNskKWHxIpqncD/Y+YgX/4Q6AgrDx5OY
         JWDbA/x8K0OuAiNKCR2Cfuc1hCJH1Td4tBaaJHxcz+V7KxilKex8ybMC95vxMLgxMiVM
         9Gyb1X70c5cffx7EWmdNSm/MDHIe8aWjLM7s9yajnQkYkyC156Is/hRMbyJT/vOQoAO0
         b4yvVi4O8G9rWu6+1hLHpylzzEIujGLOvgzeQJATbeb1JB5Q1aODII3uhZzfCSzVj1PP
         ArdPU18twh1ynDnRrMi8x5fbq7LT0+sS38RR5GhOSwBfAMJc0K87Jbva627RO7y8CCcz
         VXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DFjdc9vV3km7rWJpRqUND/UaYQOisoAu52A1NJaHarU=;
        b=n3vz2bFEjUbT6Ks1ifs2/nh2HD2VVPW8P1tmE4Y46bkHCys7PHNHGGn0UyAMZPczDH
         1WSUrkzSQRrsmQO/cDyQs8eHADlJUigNA6E5SV2++iPcumrHY0ap1ozw3CKmQPwg8z6Y
         R93EiPuFK1AWRz9W0myKd8UlouXJ5xDzbyLen9dpk4HHiCxjn31zs/hnQQFbOwq65uEG
         mij7GgWZWMuusXyPZv6B1NDIrQHFvLROTZMkmd3NH70I0dfjuuHTmVzmi8s7KbLNYtqS
         eJhQ5e3qVKA1qz94CJP4Civ+m/o2+f+YwM/ZNl2g8bhQ9rftA4kqVdNefzwAGaIst/2Z
         uB7w==
X-Gm-Message-State: AIVw113lbaRG7QJBreZQEpaftbUuaMTUXJQ0ZqL3YgP/SepeKch5sZwe
        ZBtYf3DvUMy0QQ==
X-Received: by 10.99.240.69 with SMTP id s5mr1969314pgj.23.1499439919177;
        Fri, 07 Jul 2017 08:05:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id s64sm9167114pfd.77.2017.07.07.08.05.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 08:05:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] hooks: replace irrelevant hook sample
References: <20170702112728.15757-1-kaarticsivaraam91196@gmail.com>
        <20170705165114.20662-1-kaarticsivaraam91196@gmail.com>
        <xmqqr2xuhde1.fsf@gitster.mtv.corp.google.com>
        <1499428393.1849.3.camel@gmail.com>
Date:   Fri, 07 Jul 2017 08:05:17 -0700
In-Reply-To: <1499428393.1849.3.camel@gmail.com> (Kaartic Sivaraam's message
        of "Fri, 07 Jul 2017 17:23:13 +0530")
Message-ID: <xmqqwp7kcmoi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> That said, in case my interpretation that "'prepare-commit-msg' hook is
> not to be shipped due to it's uselessness" is correct, the reply of
> this mail as a whole seems to contradict it.

That is because I wear multiple hats, because I try to help in
different ways, and because open source is not a battle to see whose
idea is more right, but is a cooperative process to find a better
solution together.

As a fellow contributor, I do not think that removing the hint that
is commented out, which is meant to be helpful to users while in
their editor and which will be removed after the editor finishes
anyway, is a useful enough example to keep the now otherwise useless
sample hook.  But as the maintainer, I can see that you are still
making sincere efforts to come up with a useful example and improve
the end-user experience, and more importantly, I haven't heard from
other people what they think---the only thing I have are different
opinions from two people.  That is why I am not deciding and telling
you to go find another area to hack in.

At the same time, I found that your implementation of the idea, i.e.
removal of the commented-out hint, can be improved.  With an
improved implementation of the proposed solution, it may have a
better chance to be supported by others on the list, and equally
importantly, if it turns out that other people do support what this
patch tries to do, i.e. keep the sample hook alive by replacing the
now useless examples with this one, we would have a better
implementation of it.  And that is something I can help with, while
I, the maintainer, is waiting.

Oh, by the way, what the maintainer is waiting for is not just "me
too"s; this is not exactly a "having more people wins" democracy.
