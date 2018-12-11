Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4012F211B3
	for <e@80x24.org>; Tue, 11 Dec 2018 14:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeLKOjd (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 09:39:33 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41801 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeLKOjd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 09:39:33 -0500
Received: by mail-pf1-f173.google.com with SMTP id b7so7218270pfi.8
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GZHu6LBhsTAE6X0JWCVFEoet0RbILOeW8i6cuzTgxZc=;
        b=CEyTjF+XT/zNNejfQ70nb8JCcArTMEC5Qa+rsdUof6dd2revVwepgcjmx1UhbM0Mw+
         WFApH001WbdqBrVbGdYf9DnlQ0+KgEkPbb+wqYB0QJjF39m/1K3FXrSGZK9H85onLQiq
         Q96MBRdNorloHKD2na5NuktFZqFDW/roqRF5qTvkXgLv+2KF6nuywe0A8PriXr+e934y
         vhwZ0WFPQtUzWfW5ztLGDzfvTYXNoPPJcZGYjIWoR2OQl1Q5hgSJAVJ4YOWLV3pHS+AC
         q4+YwmwO/Mzwr6h0BLojWRJlQst1ELMOfOXMHxLt/TXIT+MjO5p0IWyMvR8lbwrU7ZIp
         OBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GZHu6LBhsTAE6X0JWCVFEoet0RbILOeW8i6cuzTgxZc=;
        b=dccHAcY2rHLZuTHPFGpzjsypEZQQAL1UmitjXgeg0v8UIRRchdjT9nTD/gaXIUqRkE
         zb6KpuoEHrFPl28dGxmwnFp84vAr5Z/1TuNhrme64jqjizMgZwG7PkiigvXKl1s+lJ41
         4ch+Doht/I0YIL6q2pzHmldo97NCLYn271kHaO/RPvWW9idW58Zi5mZGjeh0cL7yKkdv
         DY/IxRygGyDK2yYRWbtABpfb14gKSGgY256jj9YPor7Cgjv+dkICmqCBk8sNzMy1te/z
         HYsL4woq8XMVmiuCl/gk2+QG3NQfW1aF3O78P9IKtfnEeb3NKVj3X4Mqnl0XHFESKGUG
         Y4KA==
X-Gm-Message-State: AA+aEWaMu3TltseceR16mgCNNV/GT2wBLBEwAZZXOaSUwrmReuT6BiwH
        7sjVZ9fY1mCXqy3Z1saKDTVpBuKG
X-Google-Smtp-Source: AFSGD/Xpr3vunQ0B2gjGdoEigTmAVIZR0gdkAPknWnqXjzZbWKSd5jG9t5Iom1iqPc3Vm261rNbowQ==
X-Received: by 2002:a65:4946:: with SMTP id q6mr14397329pgs.201.1544539172577;
        Tue, 11 Dec 2018 06:39:32 -0800 (PST)
Received: from [192.168.42.11] (157-131-142-64.fiber.dynamic.sonic.net. [157.131.142.64])
        by smtp.gmail.com with ESMTPSA id p2sm27522245pgc.94.2018.12.11.06.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:39:31 -0800 (PST)
Subject: Re: Announcing Pro Git Second Edition Reedited
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <pujni2$ulb$1@blaine.gmane.org>
 <20181211105007.GD7233@sigill.intra.peff.net>
From:   Jon Forrest <nobozo@gmail.com>
Message-ID: <a1941151-9453-5830-7175-7c8e27425274@gmail.com>
Date:   Tue, 11 Dec 2018 06:39:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181211105007.GD7233@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/11/2018 2:50 AM, Jeff King wrote:

> The content at https://git-scm.com/book is pulled regularly from
> https://github.com/progit/progit2, which has collected a number of fixes
> (as well as translations) since the 2nd edition was released.
> 
> Have you considered sending some of your edits there? It sounds like
> they may be too large to just dump as a big PR, but it might be possible
> to grow together over time.

Fair question. I had tried doing this for the first edition of Pro Git,
but the person who was in charge of accepting changes wasn't a
native speaker of English. As a result I had a hard time
convincing him that my changes were necessary. Many of my changes
were very subjective, and not technical, so this was hard to overcome.
Things might have been different if I were correcting technical errors
or adding significant sections to the book. But, since I'm not a Git
expert, that's not what I was attempting to do.

Things have changed for the better for the second edition of Pro Git.
Its management seems much more willing to accept the kind of changes
I make, as shown by their reaction to the excellent work by Robert
Day. Even so, given the amount of changes I've made, it's unlikely
that my changes would be accepted.

I do track the changes to the second edition of Pro Git and
incorporate that ones that still apply into my version.

But I hear what you're saying. Maybe if and when the third edition
of Pro Git comes out I'll try what you suggest.

Cordially,
Jon Forrest
