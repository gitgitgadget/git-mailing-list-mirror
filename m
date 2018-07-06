Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14371F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 22:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeGFW57 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 18:57:59 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:54377 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753899AbeGFW57 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 18:57:59 -0400
Received: by mail-wm0-f52.google.com with SMTP id i139-v6so16049771wmf.4
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 15:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=CpjfkA9P7ClcTasVlsaByWNZZCvrbkcyxgveC/e/aQA=;
        b=EkYSGCI6Q+cAzOzecXBhw+k2u2dmivLhREw9re1Cy5hUrnSGxVcZhf4mdWtYwn4ZMT
         j2rJq9iv+RpdwA/I1rn4fWC8WRhE4f06w7SYY1YbIOTm2KEcgjZ4Ga0cXHdE4fhgsfiY
         RizJV7YU0IivVfRlu8llP9DzxRVFbhX5hqHfBJUO4qgeu695ggflIPx57gMz2Gcfos1w
         OGDcA3HD1xR0yR1e2OmHKj8SgiVyFQDtJsyxgMqDGKDpOmD5WCzS71NOz6LQtu9yv9iK
         0zwc+wVueQrijaM0xaXxl0pFl6TdHO1lgiSyO4mIX7eZwoMVusL9XM8kjKIYbCfRwZ2J
         Ri0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=CpjfkA9P7ClcTasVlsaByWNZZCvrbkcyxgveC/e/aQA=;
        b=j4rJkiQym2xfIR5CKkYPs6/il8D64AERWgmjqO3Wv0bHgUK96Xn7W+Al04RJg0I3SL
         CEVQs3o75IiFDsMyzN56pSgwrdKzDNgrL+wrzZJSAxYegZTgkFQEc+zZSHYBneo9SG3D
         FYPxSBc7ElNucNyep2Ej6h7ldepAGG/GLK3QvEJLNWYt6J1e8yQxjjA1n3YoBNSwSPut
         C+LxMtmbf1Q6rcAo3vt1oJr9F152vkfv0PWpqjlU2Qjzz2ks7Nwg0WfGanwL2vu1pHAw
         he4D+nVyrQoa/fnmYyolEwrmc73KXZxSIPrEGag8sFGg+dTEuzaSM0xmNAeCXW5wvW0z
         HK6g==
X-Gm-Message-State: APt69E3bDfM4EsUbXe8+4MsBjziSGJ/W2nbkwtfO8u83ne7yuyOJciCV
        E3eK4yWvTtmBgFCZlcvLEtViy29F
X-Google-Smtp-Source: AAOMgpeX+4Jq9gpXxAwY4dkpR2uOZMkYw1GyngrFSAVdCZxoy8CEL8Mu5gpiHDGwQq0ap+Vuu9M+AA==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73-v6mr7097322wme.141.1530917877411;
        Fri, 06 Jul 2018 15:57:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w2-v6sm18536104wme.45.2018.07.06.15.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 15:57:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's (not) cooking
Date:   Fri, 06 Jul 2018 15:57:56 -0700
Message-ID: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll be pushing out the integration branches with some updates, but
there is no change in 'next' and below.  The following topics I gave
a quick look and gave them topic branches, but I had trouble merging
them in 'pu' and making them work correctly or pass the tests, so
they are not part of 'pu' in today's pushout.

    pk/rebase-in-c
    en/dirty-merge-fixes
    en/t6036-merge-recursive-tests
    en/t6042-insane-merge-rename-testcases
    ds/multi-pack-index

