Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436CA20248
	for <e@80x24.org>; Tue, 16 Apr 2019 17:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfDPRcd (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 13:32:33 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:36117 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPRcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 13:32:32 -0400
Received: by mail-vs1-f73.google.com with SMTP id l4so4481585vsq.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=erqQ031STWe3w6DNnKr45oB9I2D3uwxPB4hOeR1UMp0=;
        b=lPCP0hcFQJ6NICa9JZ127V/8wxptAhYaoSvjQdHDr073shbC528rg9UurKtBDZJl7P
         K0/SXZeg8YJD35xTtQ6SXQ94ldRoLjo9zJB6kZhWWG80dEI5wW3DCIVmOkjBklMxpG7x
         6zDkkABSV9N5XG9Zd0pxG6/haEWr6NkFQWTOu75klnHAgvM/adyUecmrVsb5vPd2G9tM
         +6qlUTuPx9SEkzcQmeyFKU7+/JIbn1qBShJ4jal9AHmFBKzq4iWt5MXaw2AgD1clw9/N
         zhg0Uw7htTL1e0a3DPcvG44vR6V7pwkjWMPskrMslw5QylhH/mSl+tM0KJ6B8LglG8/O
         eevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=erqQ031STWe3w6DNnKr45oB9I2D3uwxPB4hOeR1UMp0=;
        b=g/riJEpdwSadVFZu8i1H6Un2ZMdz6+wrpjx/DUkC/x4Tqlm2iLnR5m6bD6UNjlBJUM
         2AuRyOmVWGVau2/0amEut1ACZq+97fX0OkXVuEy0nFia19jMOUzfr04BC1KT9WDNh/Dn
         znWRXUuVj6El4ZRv2pQcID8GlD62v4VACA/5OiHgQrrP8P9/5vlK8eKOnk5HcRhDynVO
         Y2lulaYpALo9zvbfZ04Eb2PXX5WoX+aVWcOlAtQa9HfzgQuS5dAimfuTyRoSjhOmzAuc
         TWi/7omP7oud94KTMZNvc27Ux0e3mEINHHHPwYrXL0YA0KwUR6kNgArKOzj6ejpqILSt
         pyEA==
X-Gm-Message-State: APjAAAUAXF2rxzNOW9xG6S4k3jW4mJY+sGUuqPfsrs8wd2MFZseDP7fN
        9Ys5fQdfxo1ZSjRfntwcw4xSjsEvXiBOiohZA9BP
X-Google-Smtp-Source: APXvYqyxskYTNnSisOp4F7p/kfGE38bgCx2UDfilsVvUCm5rAhXOu+LOfxKlbUFsuOHyr/cZ/muc8oweA+uhTjzk7RuY
X-Received: by 2002:a1f:970f:: with SMTP id z15mr842559vkd.25.1555435951824;
 Tue, 16 Apr 2019 10:32:31 -0700 (PDT)
Date:   Tue, 16 Apr 2019 10:32:28 -0700
In-Reply-To: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190416173228.232980-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.21.0.314.g8007d49101.dirty
Subject: jt/clone-server-option (was What's cooking in git.git (Apr 2019, #03;
 Tue, 16))
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jt/clone-server-option (2019-04-15) 4 commits
>  - SQUASH???
>  - clone: send server options when using protocol v2
>  - SQUASH???
>  - transport: die if server options are unsupported
> 
>  "git clone" learned a new --server-option option when talking over
>  the protocol version 2.
>
>  Getting there.

With the two "SQUASH???" commits, I think that all outstanding comments
have been addressed, and Jonathan Nieder has given his Reviewed-by [1]
[2].

[1] https://public-inbox.org/git/20190409204525.GA92879@google.com/
[2] https://public-inbox.org/git/20190409204616.GB92879@google.com/

I understand that the following references are not exhaustive (in
particular, Szeder made some comments too), but I'll address them:

>  cf. <xmqqk1g342xi.fsf@gitster-ct.c.googlers.com>

This was about (1) what happens if the given option is not understood by
the protocol-v2-supporting other side, and (2) what happens if protocol
v2 is not used.

For (2), I have made the client die upon Jonathan Nieder's suggestion,
similar to what "git push" does when the other side does not support
push options. For (1), I have documented (in Documentation/ and in the
commit message) that handling of server options are server-specific,
just like push options (which are just sent directly to hooks).

>  cf. <20190406115728.GB219876@google.com>

This was about (1) giving an example of what a server option can be used
for, (2) using NODUP instead of DUP, and (3) a long line. (2) and (3)
have been changed. As for (1), I replied in [3] that since it is
server-specific, I don't think I can give a meaningful example.

[3] https://public-inbox.org/git/20190408171149.125872-1-jonathantanmy@google.com/
