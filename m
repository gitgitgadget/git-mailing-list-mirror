Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E621F453
	for <e@80x24.org>; Wed, 23 Jan 2019 19:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfAWTni (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 14:43:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51318 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfAWTni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 14:43:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so661656wmj.1
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Z/HANK7TwLL1cX+dyTUhGP5BMPuJi4o2PFUJox9RGMg=;
        b=IcPDJJJxGxNvmIOImc1/CQ2ckFTq1ccNb+YzssSq61+K+kv6l1plJHNu49F2jflaoK
         e9wGkeVwL3FH4tzuvNtH5j/dQlg0QCy4rJVzOhMgQCe2+HxHDKVBGQJDNT8FMhOMIOKY
         qJ40OFSvyIziMgYPKTZfH9RDMFJDNdGo7AOiUkO00qSpa8cg2k6TVe2qYLfTYBQH5m/m
         c6hq9N3kp20EYS2kgS9AC3WWF+vZP+b/ZMqo96vFzOxyJFmOqnTK2cX5zCsnSiii/ozx
         MuXok/PFGVIFMR+6DetJyC1SeR4y5SCqYEU7/P2Mw8UaE2SbOlHn9mTSPTi/u0gghQ6P
         vfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Z/HANK7TwLL1cX+dyTUhGP5BMPuJi4o2PFUJox9RGMg=;
        b=EctzcGUHBGdCiLvmW6ToC7hFOcDhc5pFCegDmtnLmUq1MxLngOgBYzy9B3wCJUr+Xq
         NBGuRJ1UKb2EfkhBIoivJV4AgQu7Kp3HCSOIrsDupJwP3RQGwZ7hZK6uBgBrDE/xbaVh
         SnUJAXanhkaHtmMLRfqaLISz1w4Wrpt3vZgzps2AQbU+z/idQwTDsx7aAlwr3bfDXisC
         ngWhVo6CKtLiNpuzszPDDcXXcHyBuYpjuEd7anqohFAjPH1mT/qS3hbioB3L56YPSMCx
         Q8+retzZrY3x8XuMTERNfrQ+1HpG6y+EclfykJBUFZgUHF9C3O4S9q/skswBTd4uXG+3
         IkNw==
X-Gm-Message-State: AJcUukdB5ky/8zLtHaRyWWnsvezcuiKlk38IM0Hfabn3EBo4uWMH64CA
        kB8xe1vDfvD1ncW2M0z8qLkAvg+6
X-Google-Smtp-Source: ALg8bN7Rn/sCuj7Bue8rNEcJE8y1KGiAbScdqcNrLi3DJyrIu0BlsOz+x/QVlxlKH0k80afeJKRDSg==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr4104301wmf.72.1548272615985;
        Wed, 23 Jan 2019 11:43:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n5sm99186859wrr.94.2019.01.23.11.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 11:43:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: tidy asciidoc style
References: <20190122201635.15961-1-jn.avila@free.fr>
        <xmqqk1ivb1yp.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 23 Jan 2019 11:43:35 -0800
In-Reply-To: <xmqqk1ivb1yp.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 23 Jan 2019 11:36:46 -0800")
Message-ID: <xmqqfttjb1nc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jean-Noël Avila <jn.avila@free.fr> writes:
>
>> This mainly refers to enforcing indentation on additional lines of
>> items of lists.
>>
>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>> ---
>
> I somehow misread the title as "tiny asciidoc style (fixes)".  This
> is a huge clean-up.  Thanks for working on it.
>
>> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
>> index 45652fe4a6..37bcab94d5 100644
>> --- a/Documentation/git-add.txt
>> +++ b/Documentation/git-add.txt
>> @@ -58,9 +58,9 @@ OPTIONS
>>  	specifying `dir` will record not just a file `dir/file1`
>>  	modified in the working tree, a file `dir/file2` added to
>>  	the working tree, but also a file `dir/file3` removed from
>> -	the working tree.  Note that older versions of Git used
>> +	the working tree). Note that older versions of Git used
>
> Good.
> ...
> OK.  Just to make sure (read: not an objection to the change), this
> does not affect the formatted result, right?

Answering to myself.  Documentation/doc-diff seems to find only the
")" difference we see above and nothing else.  After I sent my
earlier response, I finished skimming the diff and the changes all
looked OK.

Thanks, again.
