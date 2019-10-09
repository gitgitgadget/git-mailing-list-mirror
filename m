Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605ED1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 00:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfJIAQs (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 20:16:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34766 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfJIAQs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 20:16:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so368103wrp.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 17:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hmv26q+A7zGBSd8FVXcvGppiYA1SBDvb+qO6GflOZic=;
        b=qdmO8krgMcMG3rGAxIKcyA+Rw/+JIgEtEe/PGF+rReXPSXt+qbVo7ttJqS8szzcfuo
         zdVBlCJlBtdIF2sFNLZHMx1JnhtzERq6Lm0DrygGDmzY6fi0UlIlg0g5Io91iefKb5JC
         hz517AfGJlKiLCK/RXmzJ5ril7Us8jSIGkjckj19HxX20qyT9TgBJ0cWCL9WxPj6QR1N
         cCptxbNwab4WhAeElgLc5SOre1n39uvw/eaKeO8/MK/wN5JYxaNVXn1IkPHZ/lw9hhzc
         C/MGcvunFiwimIjGNpQXFRWeB3V351FPuiBW9n4UaFjxTlRRRSoOWvbkkKg+CkwZZxNj
         kM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hmv26q+A7zGBSd8FVXcvGppiYA1SBDvb+qO6GflOZic=;
        b=fXKLN1eysMVzToJcm31KN0fqZzapmW7BAvSP8bePadVLFU9dwiz0X5rdF77UFG+QJV
         EHF6d9VmtJmofsxCFMIv/qITLLdabP884vmq4zRdE06ZjzPK5Z2gKVwuA6oMeOaCg17D
         CsxwfJlyBoWYb8JiYbl6CL76MK1B0k99IMzDA54SXwvUWWIRJx0u1d77lQklWgLOAbpr
         mIbeLYFVDbDpQQr6Oh0MWUvHGnbpca8Am0lJwBRcBpfCl59h+cUDg+e7Zw8fbiZHQefh
         ilNiABGcOjOnGJpEBVT74A2KUTt6HIDAlMjqohBbiO0PLzfuwZxyqM9LMtr8bd92Ugxh
         GiMQ==
X-Gm-Message-State: APjAAAVB8hQwU2oOWFiC27VvHfvY9vHplTs+YYAXDLRuNGqvA3iDfAmh
        143YH6paeJWNCfSsBshym+c=
X-Google-Smtp-Source: APXvYqwrjZQO83wZR6SodHEaUz0uBTpMnE/xz7WnV6NAFEssuEGBX2QJBYn42Dtu9z4ZfaekhZLYEw==
X-Received: by 2002:a5d:6608:: with SMTP id n8mr454963wru.92.1570580206277;
        Tue, 08 Oct 2019 17:16:46 -0700 (PDT)
Received: from szeder.dev (x4dbe0d12.dyn.telefonica.de. [77.190.13.18])
        by smtp.gmail.com with ESMTPSA id s1sm382081wrg.80.2019.10.08.17.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 17:16:45 -0700 (PDT)
Date:   Wed, 9 Oct 2019 02:16:40 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     William Baker <williamtbakeremail@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
Message-ID: <20191008232439.GA7212@szeder.dev>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
 <20190921121104.GA6787@szeder.dev>
 <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
 <20191007172951.GC11529@szeder.dev>
 <xmqqk19fn9jp.fsf@gitster-ct.c.googlers.com>
 <202ed2c5-9729-120f-fa0e-cee9ecec3b77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202ed2c5-9729-120f-fa0e-cee9ecec3b77@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 08, 2019 at 09:24:56AM -0700, William Baker wrote:
> On 10/7/19 9:30 PM, Junio C Hamano wrote:
> > SZEDER Gábor <szeder.dev@gmail.com> writes:
> > 
> >>> 		func(PROGRESS | REGRESS);
> >>> 		func(PROGRESS + REGRESS);
> >>> 		func(PROGRESS * 3);
> >>> 	}
> >>>
> >>> how caller came about to give 3?
> >>
> >> No, they tend to show (PROGRESS | REGRESS), at least both gdb and lldb
> >> do.

> I tried to see how lldb would handle the "PROGRESS * 3" scenario
> but I was unable to get lldb to display the "PROGRESS | REGRESS" format
> even when ORing the flags:
> 
> (lldb) l 399
>    399 		enum test_flags {
>    400 			TEST_FLAG_1 = 1 << 0,
>    401 			TEST_FLAG_2 = 1 << 1,
>    402 		};
>    403 		
>    404 		enum test_flags flags_1 = TEST_FLAG_1;
>    405 		enum test_flags flags_2 = TEST_FLAG_2;
>    406 		enum test_flags flags_both = TEST_FLAG_1 | TEST_FLAG_2;
>    407 		
>    408 		if (flags_1 || flags_2 || flags_both)
> (lldb) p flags_1
> (test_flags) $0 = TEST_FLAG_1
> (lldb) p flags_2
> (test_flags) $1 = TEST_FLAG_2
> (lldb) p flags_both
> (test_flags) $2 = 3
> (lldb) fr v flags_both
> (test_flags) flags_both = 3
> (lldb) fr v --format enum flags_both
> (test_flags) flags_both = 3
> (lldb) version
> lldb-902.0.79.7
>   Swift-4.1
> 
> Is there something that needs to be adjusted in the config or with
> --format to display "TEST_FLAG_1 | TEST_FLAG_2" in this example?

I'm afraid you are right and lldb doesn't do this, at least not by
default, what a pity.  I tried different versions of gdb and lldb,
distro-shipped older ones and some more recent in containers a couple
of days ago; now I tried it again and see the same behavior as you, so
I must have misremembered.  Sorry for the confusion.

gdb still does the user-friendly thing, though.

