Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A001F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 15:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdFLPYv (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 11:24:51 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35989 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbdFLPYu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 11:24:50 -0400
Received: by mail-pf0-f181.google.com with SMTP id x63so52650090pff.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iVndOKA2dFna+FHvvCDb4kW0HkO96hA64fXeVC1kCC0=;
        b=acre7kgBNKylAaTm92+cvLhRAUT/ef0wVXbDpsv3hGiZ3tW3DMYpmF0F94mAD2BUhS
         iwJWOupBF5PftXVtAcqSWo4QyoR/H9x3Vw43Kg27Rh3kH/Wxuk39IyUk6hXoIuUBb0Tl
         TEgk4HhdB0c5kK4Uh/6iLMEFjYkvyccJEhQBPza2AtAYtlZWdyX1S9uPGYvM8AUwroBx
         +UW4K7cfe9iMB+L4nbqAJjfRKBF6MyQmWMr/mlKr+dPr8CiABBKbE0Z3vNJZErRh4RGi
         E6V2b/hlxikYWrunDQq8QarEuHmUpunYX6pcG4GIEZiK+ng3YpqmV90uf7WgyvqLDzju
         /+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=iVndOKA2dFna+FHvvCDb4kW0HkO96hA64fXeVC1kCC0=;
        b=gEzChI0ABWg6T7dST1/Ts2OksQxoqKflNm2vI5Q4lu8DpSPRk4ildOMTufWNE3BoUe
         wBrBMlEJRWF7xVtisoE/nhQWDXVs54xrb72s5A1ikGtAOYwX9/oTe3FUBAVzCYZFjRMl
         OjXLr647sZflz343VK08l7pbEOMOVoHG+0SflPXazEoEejqcrc7ZtxVK7FBUK5CCZC7i
         um2xaxLqUv/OXJGGp4vJ7K1ZqUcPrYsf0M9q59QajW1QDMxFEskk8I78GfW++4mnuxMz
         0PDH0bSvkpU0MMBRE0BmAW2th85dOgKGgoW5+qOyV66WyQKk8GoljLdQsQ6uY+0FDHg5
         R3Rw==
X-Gm-Message-State: AODbwcBj5jTYxVzIQ+g+hQGevjoHC95HMdRdplo3JuKkRVmhP9tMfXaE
        3Od2+y6kP9DATg==
X-Received: by 10.98.13.138 with SMTP id 10mr35642250pfn.218.1497281089572;
        Mon, 12 Jun 2017 08:24:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id u45sm28324495pgn.28.2017.06.12.08.24.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 08:24:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Andr=C3=A9s_Sicard-Ram=C3=ADrez?= <asr@eafit.edu.co>
Cc:     git@vger.kernel.org
Subject: Re: Missing git-2.13.1.* files in the SHA256 sums
References: <CAOUWSGC3z990x_Oehh5=R7jV2no63FGwVyArT9z3pp4zpBzxWg@mail.gmail.com>
Date:   Mon, 12 Jun 2017 08:24:37 -0700
In-Reply-To: <CAOUWSGC3z990x_Oehh5=R7jV2no63FGwVyArT9z3pp4zpBzxWg@mail.gmail.com>
        (=?utf-8?Q?=22Andr=C3=A9s_Sicard-Ram=C3=ADrez=22's?= message of "Wed, 7 Jun
 2017 16:00:31
        -0500")
Message-ID: <xmqqtw3lp6tm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrés Sicard-Ramírez <asr@eafit.edu.co> writes:

> The git-2.13.1.* files are missing in
>
>   https://www.kernel.org/pub/software/scm/git/sha256sums.asc
>
> All the best,

These checksum files are auto-generated as part of the mirroring
infrastructure among the kernel.org servers, and those who upload to
kernel.org (like me) do not have direct control over it.  I see that
it was a bit lagging when you observed it, but it seems that it has
caught up now.

Thanks.


