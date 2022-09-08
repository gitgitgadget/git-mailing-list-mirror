Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86122ECAAD3
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 00:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIHAgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIHAf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 20:35:56 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9F37653
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 17:35:55 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id k80so12694762ybk.10
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 17:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HeM52FJsCyO6kUx8Rc+z3OHgFKlxSpIf2JSj6JWbIQk=;
        b=BL3J0coQV7Q/Vp4DSwYqcOvljT0+LG/2Ak3ql53B/aUiQSdLbnL7n5oV0rOIwujI7X
         V3NhtagqW04KFJLlVr7Bxwy9J5SmZ7opJ5aMBsJhOs4+APcD0zGxUzZAfBRCak7MeTVU
         aIZbqPJs9eUegnrocv32B6FM/BN0XgyLzmXHTlf3k2t7c50JYEhjrlH50sYSlFlxZea+
         4vMombFpw4gxTDQq/L4EwW3bidBLzhii9t0mNZcV6sWyp5g6gPjrZRXy4JaVh265vQpw
         j3h4Vqb7tjzfYrhVv9E9byh1+xEtNknqSJRN9deWFfIvzp0TfEu/GNmfweGku8fbVnlf
         ue+w==
X-Gm-Message-State: ACgBeo1xdS1TY0BWq+3nZuLeq1GwhVyuBw9FVbK/1aJbb6nAKZH+7Ssv
        kZMNkkOJtI1pARIT1EiZo1DrGZ4EJgNyh3QbfRg=
X-Google-Smtp-Source: AA6agR4o2xVmaU/G7fV73yRkkRZASH5ZivrhvNxCQIvvb8tOODoDipMhP5qvNR0+tomkVt7B4avGIqG1bhw1JyYG5vg=
X-Received: by 2002:a05:6902:154c:b0:6aa:37bf:131b with SMTP id
 r12-20020a056902154c00b006aa37bf131bmr5169396ybu.419.1662597354452; Wed, 07
 Sep 2022 17:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662559356.git.matheus.bernardino@usp.br> <99012733e440be15afc7fd45272e738c71b3ef27.1662559356.git.matheus.bernardino@usp.br>
In-Reply-To: <99012733e440be15afc7fd45272e738c71b3ef27.1662559356.git.matheus.bernardino@usp.br>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Sep 2022 20:35:43 -0400
Message-ID: <CAPig+cTZeSf8UQxU+tMsXC-uKp2eCZ5NEzEkFj93zac4mNAf_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] patchbreak(), is_scissors_line(): work with a
 buf/len pair
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 7, 2022 at 10:46 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
> The next patch will add calls to these two functions from code that
> works with a char */size_t pair. So let's adapt the functions in
> preparation.
> ---

Missing sign-off.
