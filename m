Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DB961F51C
	for <e@80x24.org>; Thu, 31 May 2018 07:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbeEaHKD (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 03:10:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36644 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeEaHKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 03:10:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id v131-v6so32778417wma.1
        for <git@vger.kernel.org>; Thu, 31 May 2018 00:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RDgSVDzy1Bvshx9TKzZltoXOeKwoMDwwZrAObF/A0Og=;
        b=SOem1J1LqSpnB63rmlyXlZUCDBT/1Lt5y4CfY/XCBxzdvHK/ZirHv2sk7Ko6cPuHBK
         Nug9oqps2XXdS2E+mxYuxKMfWb9rhJ6LySLdRvlOJe/2t0079td2XSJiVNxcdh2RNVNB
         1GUgjWJcNq1t/YApG6GGGYurRuWpcIVPqZd7I0xq4B+Tc889VTrfPQaHHAIITYpv6xqm
         +Bfftt4petWVpsVD90m2kd0GIgjb5+7t2H4gcr9X0yAnJ+CeJubZ8PqoJWswvagyeWBY
         m6tFCrJxsGH2Kr+suL43bvANa4PevXi6KoQbzmtLyoLmJIf2/xsLVzOVjns9aDx5gK9o
         TTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RDgSVDzy1Bvshx9TKzZltoXOeKwoMDwwZrAObF/A0Og=;
        b=oJi6eq4oRlnH1szuPTXKGimlDTUhRvmJEBfscKKBHISpDBv+iHx1pM8Grw0v5saR/n
         tLnCtisdarYlm5GNpovhikkaranQGqLz903FBaFKhpoCMhREQd+vIVFkvGiuLDt64PnQ
         JVPRLxOCSU4OG2WNCQfG2vOr6JOm4nvMY4w2LsraxifM7pxtpXmi24vLCz5tBJ2IRT1n
         NJp0W5SDR6OZrrjy+L+byrydJkpflYlbzTC4+Tka9giUeTtukOKBbKnAUEfDxMs7YejM
         4LEq77VqwczgSFczQNNwTfwZF5mgg9cr8ks8bgF2PxmSfivJIECALxbRTBUbWWpmUe+S
         4/7Q==
X-Gm-Message-State: ALKqPwdO3CBmUbaGqb2OurGnBne3Cu0nhWr5QyUbiZABHU0RaK7u6yKs
        Do+sFaeOKddhQqSgcxS3axA=
X-Google-Smtp-Source: ADUXVKIO2cPCkUIUYEFMqLmkap5ltCTzmbHR5vTAc+yje1EmspnR4Sr732MzrJmDRlH51b71aAiRTw==
X-Received: by 2002:a50:d6d7:: with SMTP id l23-v6mr6682843edj.259.1527750601335;
        Thu, 31 May 2018 00:10:01 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id d8-v6sm21570946edk.50.2018.05.31.00.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 00:09:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/4] config doc: move color.ui documentation to one place
References: <20180530210641.19771-1-avarab@gmail.com> <20180530210641.19771-2-avarab@gmail.com> <20180531052538.GB17068@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180531052538.GB17068@sigill.intra.peff.net>
Date:   Thu, 31 May 2018 09:09:58 +0200
Message-ID: <87in749u7t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 31 2018, Jeff King wrote:

> On Wed, May 30, 2018 at 09:06:38PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> Ever since b982592d66 ("git-status: document colorization config
>> options", 2006-09-11) we've slowly been accumulating more and more
>> color.* options, where the documentation for each new one has
>> seemingly been copy/pasted with minor adjustments from the last.
>>
>> This has resulted in documentation where we're describing what sort of
>> values color.ui or its overriding variables can take a grand total of
>> 9 times.
>
> Yeah, I agree the current state is poor.
>
>> This makes for hard and tedious reading, and is going to be a royal
>> pain if we're ever going to add more color.ui values.
>>
>> Instead let's briefly describe what each variable is for, and then
>> copy/paste a new boilerplate saying that this variable takes the exact
>> same values as color.ui, and if it's unset it'll fallback to whatever
>> color.ui is set to.
>
> Definitely an improvement. Though I wonder if we should go further and
> show the user the relationship in the documentation explicitly. Like:
>
>   color.<system>::
> 	A boolean to enable/disable color in a particular part of Git,
> 	overriding `color.ui` (see `color.ui` for possible values). The
> 	current set of systems is:
>
> 	advice::
> 		Hints shown with the "hint:" prefix, controlled by
> 		`advice.*` config.
>
> 	branch::
> 		Output from the linkgit:git-branch[1] command.
>
> 	...etc...
>
> We could possibly do the same with color.<system>.<slot>. Or maybe even
> make a single hierarchical list of systems, and then the color slots
> under each. I think if our mental model in adding these options is
> to have this kind of hierarchy, then it makes sense to communicate it
> explicitly to the user and get them using the same mental model.

I wouldn't be opposed to some twist on that, but I really dislike the
variables that are documented in such a way that you can't find them in
the documentation by searching for their fully qualified name.
