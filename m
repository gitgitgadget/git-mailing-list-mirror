Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D80391F516
	for <e@80x24.org>; Fri, 29 Jun 2018 21:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965779AbeF2VEq (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 17:04:46 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:50900 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965700AbeF2VEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 17:04:45 -0400
Received: by mail-wm0-f41.google.com with SMTP id v25-v6so2462156wmc.0
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=4b4EuOXNT7bVcXRLe9IBvZyg/HueskV48jN/MPlFbg0=;
        b=JRapbqF86y9Sr4EDRtsjIYYBrwxW+AeYcZ9B6cQ1VkoD5/r6f2Zvu7cbQjCXfaYe3f
         YqWQNtaHZRw2tM6idJ8FNrCHiJ8ee6MTpwHz9zOFbq/cq/36dB9PeN/q9XY822Z0p9p0
         EJ3HACas4NQl6MvPTI4Uz6h5xF2VZqjEAOFNvbz+i6Jn0EL59NYzEdR3o40NocrXC5Ek
         MBtY6myPQxVtr3aJLyEWos1GB8UnE9dF/kMFUiUpO37gmiisv9bbVYGHUJGIjZmln5hL
         x5/9NwlmqkSUOJYIaRV5xZ0nKde9W0nMGmtwr8SvK1D9e5b8bXcvMmc9ZWRx0d0oVU+z
         8txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=4b4EuOXNT7bVcXRLe9IBvZyg/HueskV48jN/MPlFbg0=;
        b=qmARtmwTSDWgQAGS48qWj/Dl6fYPxAkSEtpU0OFlOnyPY245cbTp3m4mXYeAQA3mEx
         n+y9ce6xyDC6EYHeRe8vhpTTKJmhJk/UqgGmo4FRCM9RbL+OGPuJaLy1HMVW7OaECJxm
         +O7Sks1eMYNIPwrEYtebESkYRM3mWGleCuSoISa8HIOTJuCcFe1pHuIldBGYDl5R6Knt
         CCrxcVUqmxv/AxQC4hOj8d1b9zlIHMZSXx6grYliIex3vt8VjbSQC+PjoyVUNzUlY2ta
         MoJZbgO005K3NLqF4HbJQ8OggsGNnoIh3xmQmYBQLHEac5dHEE4aVVU9hvp/eqWfPmq0
         J+kg==
X-Gm-Message-State: APt69E2/dMgEVetBv8ufrz20RYPlJLtMQkpZ+K6vmU2cuoDdUIUn9G+U
        BNuX5WFZ2FA1ttZkCZK31Zs=
X-Google-Smtp-Source: AAOMgpc3IxPFWO3kkmjLIMECTCpKqmq31vlhhNa800yk4oEpoUdhM8MgU95FjMZUfcy9J/keTGvIaA==
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr2854073wmc.58.1530306284325;
        Fri, 29 Jun 2018 14:04:44 -0700 (PDT)
Received: from evledraar (240.red-79-145-32.dynamicip.rima-tde.net. [79.145.32.240])
        by smtp.gmail.com with ESMTPSA id m58-v6sm20020872wrf.61.2018.06.29.14.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 14:04:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 29 Jun 2018 23:04:44 +0200
Message-ID: <87po09cnir.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 28 2018, Junio C Hamano wrote:

> The tip of 'next' has been rewound and it currently has only 4
> topics.  Quite a many topics are cooking in 'pu' and need to be
> sifted into good bins (for 'next') and the remainder.  Help is
> appreciated in that area ;-)

Per my
https://public-inbox.org/git/CACBZZX4yG5h5kk4NFQz_NzAweMa+Nh3H-39OHtcH4XWsA6FGpg@mail.gmail.com/
(seems to not have been seen) I'd like to suggest that:

[...]

> * ab/fetch-tags-noclobber (2018-05-16) 9 commits

This be ejected for now.

[...]

> * ab/checkout-default-remote (2018-06-11) 8 commits

And this be merged down to "next".
