Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E95C433E6
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 17:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860AA64FB8
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 17:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhCHRFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 12:05:40 -0500
Received: from mx.kolabnow.com ([95.128.36.40]:19356 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhCHRFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 12:05:30 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 4A8EE40D27;
        Mon,  8 Mar 2021 18:05:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1615223113; x=1617037514; bh=TAlUr1WenDhXtYB3IVg
        v2x7Fdz+YIPhjeTS+ZsG0mhw=; b=3ThADeCLqn6X6+54PFO/vtO6Y4Cpwqe4sls
        o4cNx6QrCLxN8hMZlKNmnCeEw8uwHmaKPMqGeqe7x7DmeIjlJMYmvsm1RM7h3XPf
        f4eyyi/9VGB6+zYKUTtW6KDUh3mMT54bwO3LR5q+ryMibfKklmWIeqImPQOL3FNw
        sx0uxkiQdJNYa4InyefWoe75lEgIZw2o12zrxq0+Vrf4/5eXy+i2hWPnd1N2aeoZ
        mv0MDeLIxIdn0v8k/8/+10uA6d/r957Or6uc+0sgsRjgGTZKcSyjvThjVh9zEG60
        YMw79Vv8S1nWNuQwyctrgC6ii/0e+macGCrX2P/PTWtA4xPJS9pBwVuJkHdyCchx
        omYama+q/VRW4yIVAuL6kWdgJK31ln0RwZvKVYJj0tM645dSvpDvNUZDZ4jDt+ow
        TtadHnHpyWwzja7xF+bvZPCA5RFKjRVhheynBKj7PY/aM1x/kJ52zPVZZWAC4jgX
        dlSgW0G8njaInhfXSYwtZ4BaphjadLLkgX1m1cZtqeicI4BTfC5oO3o10iMNXy3x
        mCCLAcISAsHC5sE5TL5tmV0lo4+Ou9Tn3SUqPGw4V1hQieNLPyz6AxhCDC+t7BzK
        vQcml/NxdclAWLqvG/7nteG5zmkQgU4KJx7WP/oFCiP+tJkSfon6K8UI7mT6P1oS
        yC5L3B0E=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ka5_w7USbkf7; Mon,  8 Mar 2021 18:05:13 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 78608404C2;
        Mon,  8 Mar 2021 18:05:13 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 9154218E;
        Mon,  8 Mar 2021 18:05:10 +0100 (CET)
Subject: Re: [PATCH v2] Update 'make fuzz-all' docs to reflect modern clang
To:     Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Andrzej Hunt <ajrhunt@google.com>
References: <pull.889.git.1614514959347.gitgitgadget@gmail.com>
 <pull.889.v2.git.1614871707845.gitgitgadget@gmail.com>
 <xmqqlfb2cz8c.fsf@gitster.c.googlers.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <defff7a3-2104-4fa1-7750-0b13ca5cdf59@ahunt.org>
Date:   Mon, 8 Mar 2021 18:05:08 +0100
MIME-Version: 1.0
In-Reply-To: <xmqqlfb2cz8c.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/03/2021 23:48, Junio C Hamano wrote:>
> LIB_FUZZING_ENGINE is used this way in the Makefile:
> 
>      $(FUZZ_PROGRAMS): all
>              $(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
>                      $(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
> 
> and it is somewhat annoying to see a compiler/linker option that
> late on the command line, where readers would expect an object file
> or a library archive would appear.  It makes me wonder if we should
> instead be doing something along the following line:
> 
>   - empty LIB_FUZZING_ENGINE by default
>   - add -fsanitize=fuzzer names to FUZZ_CXXFLAGS

This sounds sensible to me, and will certainly simplify the use of
"make fuzz-all" by beginners - although I'm not sure just how useful the 
change would be since my understanding is that this target is almost 
exclusively used by oss-fuzz.

However I would prefer to wait for Josh's feedback before making such a 
change, as he is the owner of oss-fuzz's git integration [1], and as 
such is most likely to be affected by any changes to this target.

In the meantime I'll prepare an updated patch with a fixed commit message!

[1] 
https://github.com/google/oss-fuzz/blob/c41e46ffc8bc409bdfde0c0d2c97e1305f0c4106/projects/git/project.yaml#L3
