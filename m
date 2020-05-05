Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EAEC4725E
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 314A62075A
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgEEFwg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 5 May 2020 01:52:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38634 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgEEFwf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 01:52:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so1165625wrt.5
        for <git@vger.kernel.org>; Mon, 04 May 2020 22:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZDZhN8eZUo6NaGxAX9PbSXH3HYrienvjNPrzJWNZw4E=;
        b=Iww3tfcQBEHHBzxT/GlCsqQ/de0y56QKRyQ2Q49sy9ILmJfS8DVLqX/Mld7fcM6u+/
         JePDbelVXyf5wYXUaUxPmMFMePKIaIThzIEPdr9QBbvpTKuM5iarlOdNl5LrcKFANYI6
         fqPxdIl9yN7LYPt6t7SI5CnQwbUzH1lz9ocYLPdAo0ji1WutX46OFqCEofsFFAsCTh0+
         SkAxW1OcscTDYdQ7foWsF+Neg25Gn6s6ossvtMc1GO9JqtHvo7YqHFtsuaknobmega5K
         aDHvef6QGB2QWx0t7HAdKkuDNbMGvEuBzgOIhrzvRGl40hoOHLqGCQD8cC01lDpDeP5Y
         P4IQ==
X-Gm-Message-State: AGi0PuZB6yTKkQXsS4VDcJFYV78CLgMlng2fsjGnpdzbUR0lfTzYkQgo
        0AAscQWuR6d7TDAdEeDh2FeiObIXdU7yJk7aANv88Q==
X-Google-Smtp-Source: APiQypJyW+yNnQfHh8aCECcnmqhLwlMTCWsd3egcZpKt+qehZ5hoQP+0Zbc6yrsdIikawRY61U8IInzbzOdt4wfQ7sM=
X-Received: by 2002:adf:f786:: with SMTP id q6mr1630106wrp.120.1588657954197;
 Mon, 04 May 2020 22:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200505054630.5821-1-carenas@gmail.com>
In-Reply-To: <20200505054630.5821-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 May 2020 01:52:23 -0400
Message-ID: <CAPig+cRE60kw-PeF=Di7O9Kw1P1CctCX0drDzGX3diVQ2-Fu1Q@mail.gmail.com>
Subject: Re: [PATCH] builtin/receive-pack: avoid generic function name hmac
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 5, 2020 at 1:46 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> [...]
> While the conflict, posses the question of why are we even implementing our
> own RFC 2104 complaint HMAC while alternatives are readily available, the
> simplest solution is to make sure the name is not as generic so it would
> conflict with an equivalent one from the system (or linked libraries); so
> rename it again to hmac_hash to reflect it will use the git's defined hash
> function.
> ---

Missing sign-off.
