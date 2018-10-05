Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21541F453
	for <e@80x24.org>; Fri,  5 Oct 2018 14:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbeJEV5G (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 17:57:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44344 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJEV5F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 17:57:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id u74-v6so10594725oia.11
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyyF226/nCVfRNo4pioY/CzpgHU2QqU4gP6OsTAZXHg=;
        b=rY+O4hBEiDMWKgkDnK9WxHsAvOVZ8W3UYLoKSE83tpj76wN7TrdC/Y5Helvc6WdULl
         LlVNB5K4fA6b/5Z2gYjgPaYsODnrM7qXH1LdmFDwLeztSH+Iaw2cu3/QNkc2mqTfmwV7
         JlqoPCZ+1UjNmc1V+psO5vDsJ8q6FKdihiDrRjlTQENQOs/OG/4N98B70Igvl6k4Gyvf
         fowJCe7STRGt35oS7uRg+8mILDeN2bY/3fGQBkpmVCH4AYwPVS6h5jdlsIyQf/NLhMYf
         VOY588KyDhs75C3as+2Po9gzJWfdc+P50l+AVsdFq0kZowakkU4eBlXiaMyutMbROqkd
         AcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyyF226/nCVfRNo4pioY/CzpgHU2QqU4gP6OsTAZXHg=;
        b=NF4Nmz9V5WckNYwJtJwhpA37On5xM+GAm4ZDmdsgzrBvdw8QIEZ1OJW3MpqlVqF2Hu
         7nKSVzJ2J4REmvHxzuOTL+/C65+ywJ8XQIqxQ09TCmvMmXj43atfhg5JgwQZRTSc4v7m
         qCmBDiHKuIT1gYy/dD+SYMr0Ahklw1vmZPbXiY2qQRTdRFCkLkgWdlQOMeU/MZxUSpjR
         hClxhmdklt776v6BVw/OVkn9NMlDPAWh5WlTf9Yhgp2BOdT4ai2mxHkSY5WK88loWPgD
         ZCyrAfl6A6MVJ1v2p+R78fKFKA7/+nkpstwkCrxZVB7/Uc90WUKVeC/5uJ6ga6O7c5vE
         En9A==
X-Gm-Message-State: ABuFfohzLaIpW5YB6iOWtxO2XrFt58icFvAhc5XoziivS8MOzLxc+e0b
        sRTETT8IitcVOHbYRJUVwi+Mx0D4GXIgnanZClzR
X-Google-Smtp-Source: ACcGV62MeXCCmMwzXA4yQKLTeWA6GBs1C0HZYJunQmQ2q0KiDPNrLMEO6UUMKYo8Ico9mg9y8/wYPEKqkyj+d0DEV4c=
X-Received: by 2002:aca:5590:: with SMTP id j138-v6mr5152365oib.97.1538751480219;
 Fri, 05 Oct 2018 07:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538581868.git.matvore@google.com>
 <32f6f14f8d3323468b4255927cca028a82f64b39.1538581868.git.matvore@google.com> <xmqq4le03ome.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4le03ome.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Fri, 5 Oct 2018 07:57:46 -0700
Message-ID: <CAMfpvh+6JGpY8WBGYvh7z96mxw6qFnt2xV23oibRep=ON+7J9Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] t/README: reformat Do, Don't, Keep in mind lists
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 4, 2018 at 11:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matthew DeVore <matvore@google.com> writes:
>
> > -Do's, don'ts & things to keep in mind
> > +Do's & don'ts
> >  -------------------------------------
>
> We may not format this with AsciiDoc, but please shorten the
> underline so that it aligns with the line above that it applies to.
>
Thanks - Done. I will send a re-roll within the next 8 hours assuming
no further comments.
