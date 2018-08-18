Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06F551F97E
	for <e@80x24.org>; Sat, 18 Aug 2018 05:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeHRIt0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 04:49:26 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:46509 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeHRIt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 04:49:26 -0400
Received: by mail-pg1-f177.google.com with SMTP id f14-v6so4436983pgv.13
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 22:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pic3psDxwR3+00swdqhxwQkriQqgcA6ns00pVzhvB2Q=;
        b=ABvU+LdUIZxiSoea7BOu4MwfLOFWP5WA/+FuzV1eaqvyd9Ei9wbH47QQVUwlEzzob5
         Y3EGc6YSEqHJOllpXw3qBPkz1mbPiA37T/c7FminV51E95o6lRDtmk+G5dBQYL2GQ6Gr
         pmbtimeqTDEcxLP7ANbUKEtnad5DsHXbpukjVP8DZGWACw/aYNJInklDQ4rTWHjcvpvh
         cNbh2Cx3fcuPBVeY0QxRjQb78ErDyLZX2oWwWTbISC4nUteETJ42+DZM2bAXnxCo+xZK
         +8Ms2mhDTobHxMBngndy9YWg93Fh47puYkTO9MnBs9GaxDVcwV0PiZunHq9ua25Bp+PD
         /qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pic3psDxwR3+00swdqhxwQkriQqgcA6ns00pVzhvB2Q=;
        b=GXaviQFNVhRxVcADT3bOXnBQdAGPcig82cKx3jbkNSfUYAhZ37WAO2nnRI8MqHBHTd
         7mH+8hd4Prfh3BrCSNNBr/iNOXlNFYzt6iZlW25rE8A52THFUE5kAli3NKcN+m6Efsss
         SY2LN2bPS34jm3BvPRogp2kzw5wZTTvZ1qVYPnboTsUsPrPffzMrSRFZ9VbjvHBvWMRq
         GguD1WaiLN4wyTbZ7Px6JjFFp034ynEG3lH5gOBu7Cz64/vupI8K0P4oKdR97mkqxLm0
         9lQzl8jePMF/oOmDnNma2FbHaiRSjgM6/2Bj46RygmQpMuG4E0bCQUYI+pU+iIwUJd0O
         yxcw==
X-Gm-Message-State: AOUpUlHdaLNAGvQKQtxDWPH9NR598SaAhoh23jESngoyN3USDfqe1i4F
        7HGXWrTEohweEEn6NRAarxM=
X-Google-Smtp-Source: AA+uWPwprlw2lj7FrPLxjFxHtl3Ssi8bJxs4TrpA6KxSMEF7K65I7fnWwkF4BLgEQx4gR3XEfFGr7g==
X-Received: by 2002:a63:352:: with SMTP id 79-v6mr4011422pgd.112.1534570982184;
        Fri, 17 Aug 2018 22:43:02 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n80-v6sm5316087pfb.95.2018.08.17.22.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 22:43:01 -0700 (PDT)
Date:   Fri, 17 Aug 2018 22:43:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Michael =?iso-8859-1?Q?Mur=E9?= <batolettre@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-bug: Distributed bug tracker embedded in git
Message-ID: <20180818054300.GB241538@aiede.svl.corp.google.com>
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Michael Muré wrote:

> I released today git-bug, a distributed bug tracker that embeds in
> git. It use git's internal storage to store bugs information in a way
> that can be merged without conflict. You can push/pull to the normal
> git remote you are already using to interact with other people. Normal
> code and bugs are completely separated and no files are added in the
> regular branches.

I am a bit unhappy about the namespace grab.  Not for trademark
reasons: the Git trademark rules are pretty clear about this kind of
usage being okay.  Instead, the unhappiness comes because a future Git
command like "git bug" to produce a bug report with appropriate
diagnostics for a bug in Git seems like a likely and useful thing to
get added to Git some day.  And now the name's taken.

Is it too late to ask if it's possible to come up with a less generic
name?

Separately from that, I'm happy to see progress being made in the
distributed bug tracker world; thanks for that!

Thanks,
Jonathan
