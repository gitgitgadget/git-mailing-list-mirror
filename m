Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD6820382
	for <e@80x24.org>; Mon, 20 May 2019 20:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfETUyI (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 16:54:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37865 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfETUyH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 16:54:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so7818539pfi.4
        for <git@vger.kernel.org>; Mon, 20 May 2019 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kqSmXEhamaaW9n6VwClQy6MY3meOeiHXoT2dcqvYYLg=;
        b=hSuQeQtItcjK43XO+RYKuTFqx4mx5Om8OC9wcdX463N4Uu9j7i6vO5oJNhRB1sCROx
         bkgZ/pE3WBUngzOG4kwRHiMD5+CjGRpuoJV0SCTRlZMqZiCgkgVJrm1qBchtHKNHLdGd
         5N5/8CTAWqiBLXnnlnsnR3CoopztdMoGVKngRJyQ6CazQG6CuceW7J3LyRhtE5DDkqC1
         /vBaSU9kaz2CZsKOyfXtVsRsit5mKSDTAskDB7dz078qtyIbNhgVaQ9CfikeD+ZQfXvv
         jKdkA6MqYMG4XXZRhcFsi6YIzrJxnbBLPnbNueOy/G4E0jBagjp+mI+y8M1TG/RLi4v6
         ijTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kqSmXEhamaaW9n6VwClQy6MY3meOeiHXoT2dcqvYYLg=;
        b=qVfBRaruwQgQDvKRUIe4eX2Va+BMXtSSk6YPg4xTDUGoMMPTaTDoAG6Qe90YtM5Q43
         LwFpqc/PSf4Plr4O59zxWKJd48SQXkFWTLdwMeI7N3a2m2r0YlW5zAXG9QzEQHQOd9jy
         2yi8RUMwUR9GxYv1Z6UFq/hWKa0u+7YofHYIzKK8HdY9t9KytaLLOFrErjZ0d7LTjZbe
         TM2y/Cy/0wxVSrQlNlPuFh7cxKkdpOnk1fXjWZn1Fpmea1LhF4rhw5vuM+XdY/DvGiQt
         oqWEnZaOntAUVuTNumHUkDyf8zQuvj/RE9r03CJOdlhmJRfodjMbSvI/XKu0/TH8t7Jh
         LPXw==
X-Gm-Message-State: APjAAAW2aEuEG5IC4uJDaNhLVO2Q5wdfxE24lgQWWmpxjwVvIlVtOLxi
        4vNZTSC3uvJ/ViTnENZLS5U=
X-Google-Smtp-Source: APXvYqzxQCvFbn7zitvlkZR6dSjCHWVk75Y2BPwlnAQ18iVW12TZJ1jINmNYFZ6Ee2AE0E8qSvdFxA==
X-Received: by 2002:a62:bd0e:: with SMTP id a14mr63022381pff.44.1558385646709;
        Mon, 20 May 2019 13:54:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id c23sm37200712pfp.0.2019.05.20.13.54.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 13:54:06 -0700 (PDT)
Date:   Mon, 20 May 2019 13:54:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitsubmodules: align html and nroff lists
Message-ID: <20190520205404.GA32230@google.com>
References: <20190501203216.141398-1-emilyshaffer@google.com>
 <20190501210354.GC13372@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501210354.GC13372@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> The patch itself looks good to me.

For what it's worth,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

as well.  It's a straightforward patch and solves the reader-facing
problem.  Thanks.

For the curious, the upstream discussion in docbook-xsl is
https://lists.oasis-open.org/archives/docbook-apps/201905/msg00001.html.
I'm not sure where their bug tracker lives and what bug number this has
there.

Thanks,
Jonathan
