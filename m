Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A36F1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 21:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbeHAXgj (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 19:36:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53219 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHAXgj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 19:36:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so232009wmh.2
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Wu3SBiGh3imswzYEqXLF2ettlaVehqSMzF7iZrjoYlE=;
        b=nxMiSvleFkwLerKK4PiW6SJYkTMpMha1xOWJqMx1sHEGwSqKlwJDTLasdr4z4wTSPv
         44QveUlFOrAHcxZigXYusnipJ5ESSw/6uonqW+JC3QBAowZqbiOZWANkFITfkxnS2eUc
         IvmYqvzZDBQFYPlHmDicpAb2WUlXESkBs3r7s4QFX4lHgPpiW4mzKMQfbY9IkgjVBMls
         8Lylnn15oI/j87uTEGVp3vf/gyXSbuoFi5IWaHsgh7gtYA46eDascBhQBdlNMsPqQsMz
         e47IvzLZIwaidLPrtXk5KfXwJRfBGk8VDv1uio29eEUuKKjifsf3o9GIy5EpKVyNeiJE
         2Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Wu3SBiGh3imswzYEqXLF2ettlaVehqSMzF7iZrjoYlE=;
        b=Z57x6JGkjbBNaBwpg11gxnivFIUiiy/dn4qH12DkyeedU/YspZPHuAt36cBe/g6L6G
         R19qCW7Ml4kQfc7/tTjCNBQP8N7h0lyXBVl8Fhef/8E/YpywwG4LaHGjaT9Xjl5Jzaw/
         bQtl4cRRrFnkTHnNxDPa/TWCg4y+02bGTmFfotkyF5aIaUb+vf2DDGmTUssza+AlWDIF
         644QhRmLo7c8Axbycxkvybr3EFaabzBjb32IRZwrmfsA0QDkybObyuSWde5cpWaX8Oxz
         nqF8VS5Ak/9sq190lVW9+nFV1dmRWLR99h0LNe96XUn1BslrVyDEjYBQpRS7LV1C0FzN
         p5uQ==
X-Gm-Message-State: AOUpUlG9EirZilkPhh7M2ziulFWypbBh895hQxW8A+FPIqHw+Tj04jGL
        vcICdSTrKzGTNkDA5Vsce4o=
X-Google-Smtp-Source: AAOMgpcQ1Amx9p4tBBXzBSFugBx6z7XSGTSP6IPq9SMmIQfsC9vpT/XionKpTba2aL1cyNZ+1PhsAQ==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr184779wmd.6.1533160127840;
        Wed, 01 Aug 2018 14:48:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t70-v6sm125845wmt.30.2018.08.01.14.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 14:48:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
Date:   Wed, 01 Aug 2018 14:48:46 -0700
In-Reply-To: <87k1p9u860.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 01 Aug 2018 22:46:31 +0200")
Message-ID: <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> +		  /* N_() will get "<>" around, resulting in "<refname>:<expect>" */
>
> ...but this comment isn't accurate at all, N_() doesn't wrap the string
> with <>'s, as can be seen by applying this patch:

I know.  It is a short-hand for "what's inside N_() we see here".
Try to come up with an equivalent that fits on a 80-char line.
