Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF7A1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbeGSTY5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:24:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53427 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732080AbeGSTY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:24:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so7183636wmh.3
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xTAUq2miSgWsO/2CDO/ctHbgwJjaWvos+ockv7uNfJs=;
        b=b768IvFhLDYVYmJj63gO9hDqI11qLrkwVP67qkI1PhMbkf7R+2aR2LhCc3X3guJXYY
         cbQsK9zyH1OYsWRVsdF3MXhRMtjZUp/r+gaekY3NIfRj1PVj5yLZ9G6wsBOGfbuRRLMy
         R9Ag2Qal0//JuCD/NJWOQoFPmPzDNMxUg99kZ/m97qoJz60/PgS6H2xTvrQdYgde7iBy
         SPlKPFKCAux/XeOaLxcsenTzUPNaRDzZRnmldiPXiXHGcOGtcQPq424ElR/cbfioCeIM
         XqsXXfRa0Dx/eT41u4snkC+7rnmq0jkZAzMoK1nU2PpbidADDSOcaMzI9vpYMtIXn1Yx
         kSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xTAUq2miSgWsO/2CDO/ctHbgwJjaWvos+ockv7uNfJs=;
        b=N4NMEUOAbCogahHgfFJcSj1yUKCIrsv0+i4jEEeIwfl/8DOOsnhOx5xLWI3TdEJplB
         zDRwYI8O3ely1ijLpv7nzEtzTyO418yNZrB+0GJT41l6AFOW3Muvj6qm2iSu0Sw5EbBM
         K/F9azlYVxVx8k+Kkx0wFvnUk/vF6trrPy4Em1AwqcFRsr21hC94cLTBR//CFVMulAqS
         si8J+vFEQsMedJc1RSwD0s3gL/9pvmX2D6IDfhVYFsDehieVoiWK/MLeRegvKGp5ExC3
         VaiTwPd4J3V6cOX/Sbr5vy3zIQ7o68/M9cHQlNGTgtx6InoLO+w0bMUTtZwL+ESLWxmm
         3iMQ==
X-Gm-Message-State: AOUpUlFeVlCiZWD07C7jmjvzWoXnFHe7yngXiiH3mPHQbgPmlGDOR7OB
        5A0SMEuWbC0JBDQaZdxVG/Y=
X-Google-Smtp-Source: AAOMgpeGdnhbZYvNDBO3FxVQBi0dgfNW6CTviaSj/jIMhZJM7zt1ue5CT2NYamuzYJgHXIO8mAmhVA==
X-Received: by 2002:a1c:dcf:: with SMTP id 198-v6mr5001224wmn.131.1532025630557;
        Thu, 19 Jul 2018 11:40:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z5-v6sm11067663wrv.2.2018.07.19.11.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 11:40:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 06/23] builtin/pack-objects.c: mark more strings for translation
References: <20180718161101.19765-1-pclouds@gmail.com>
        <20180718161101.19765-7-pclouds@gmail.com>
Date:   Thu, 19 Jul 2018 11:40:29 -0700
In-Reply-To: <20180718161101.19765-7-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 18 Jul 2018 18:10:44 +0200")
Message-ID: <xmqq601bf4rm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> @@ -149,7 +149,7 @@ static void *get_delta(struct object_entry *entry)
>  	delta_buf = diff_delta(base_buf, base_size,
>  			       buf, size, &delta_size, 0);
>  	if (!delta_buf || delta_size != DELTA_SIZE(entry))
> -		die("delta size changed");
> +		die(_("delta size changed"));

I wonder if this should be a BUG("..."), as it falls into the same
category as assert(), just like others turned into BUG("...") with
step 01/23.  If the following observation is correct, then we need
to turn this message into BUG() in 01/23 in a reroll and leave it
untranslated:

    In try_delta() we have earlier tried delta against many other
    objects and picked the best one as (base object, size of delta,
    delta chain length) tuple, and in the caller of this function,
    we write out the delta by recomputing it (because the resulting
    delta, unless it is trivially small, would have been discarded
    long before we come to this phase).  If diff_delta() between
    that chosen base object results in a different size from what we
    observed earlier, on which we based our decision to use this
    object as the base in the first place, we have a problem.

