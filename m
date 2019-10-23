Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7671F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 21:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392063AbfJWVoL (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 17:44:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46690 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391173AbfJWVoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 17:44:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id q21so2676188plr.13
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u0K+jBeW50eaoSIxmt1Vp/UH1OUKBs2pK52ZDfPj4DM=;
        b=I+xHA/grMljRdsCvCjJzL5wpo3L5BDgL7YXAWI+uR89HT8hEEzEFl3W5kBnj74Y5mj
         HPgwmVRr2+xtdNFrKJ7WY2gR3XCpffO0cEWmyQFNVX+zT+kCLQnSUMpJMzoPgcw8dzvk
         pBWjdARZdq47YO0DMEpj2a9LKjpus+LZzNdhjWCQ0gawPdq8YnFSGSE8tvKtAT9tEcAe
         EVcZk3yqdq+GFgCSzDjBOxvoHJhIFCU66i5EN6I5zf6pqVCTce0Lw4Cs2nm6kNTERdBL
         B3hlnMZvqgEFl/qcYZZblRmVa+hIaaHZhN0AYTNX7ybRmujZLGyRpEUw+jKG4aNvGKMc
         aXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u0K+jBeW50eaoSIxmt1Vp/UH1OUKBs2pK52ZDfPj4DM=;
        b=tjCTarOKF8ZDm6RmXICiXaH/5sGUKsQzY7/o/spAG1lltJADq7B765TOtGDKQmxZMs
         Xwd4IMEY/H4V+FgzExblNavXSSOrAxbI+XV15JX8jHUYdAgVBLo3mtMMMmu4V3sOoM+d
         /fKNnmDe4nng9jrFGNwGOJRlRNyc6IK2mx21wvTYtN5OwUO6u+w3T+QXkbP2FAhJLNGN
         a7w8z+IIArGs4fdmvlFvcPTdCOaYwTgy94Z1/sgN/1pZGc/D6A2J9EU4FC8vQIzQ1VLu
         SEQBpSwM9MEE9Q6OVqwoj67lZMFMGNk4uvQVtqsiyCuBWm+DybOf31WAVD2JzxdMnv1T
         dOYw==
X-Gm-Message-State: APjAAAUb7RlKNlPbDH42V+KyvOf2gzueNcYuSoGpSX02jIUlgQZ9c0NF
        K3CUMdWbFx/KUSmStnjuixyOkQ==
X-Google-Smtp-Source: APXvYqzKOOVqFgFNdp/sGeUWN9z3OshV1j4MxZdHDU02qpe/FULd47U63u0stdZ2xXHgKqHEkLt42w==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr11745937plk.183.1571867049542;
        Wed, 23 Oct 2019 14:44:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a24sm7336755pgd.93.2019.10.23.14.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 14:44:08 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:44:04 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] documentation: remove empty doc files
Message-ID: <20191023214404.GB124161@google.com>
References: <pull.412.git.1571768375.gitgitgadget@gmail.com>
 <pull.412.v2.git.1571815556.gitgitgadget@gmail.com>
 <5cd79e24fe6bde7c5d10e1c2cae660858e3c4051.1571815556.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd79e24fe6bde7c5d10e1c2cae660858e3c4051.1571815556.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 07:25:56AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Remove empty and redundant documentation files from the
> Documentation/technical/ directory.
> 
> The empty doc files included only TODO messages with no documentation for
> years. Instead an approach is being taken to keep all doc beside the code
> in the relevant header files.
> Having empty doc files is confusing and disappointing to anybody looking
> for information, besides having the documentation in header files makes it
> easier for developers to find the information they are looking for.
> 
> here's a list of the files removed and if the info can be found in the
> corresponding header file:
I think you can remove the above; in lots of composition contexts it
tends to be bad form to say "Here is <something>: <something>" - don't
warn us that you're going to present it, just present it. :) (Or, at
least, this has been drilled into my head by many high school English
teachers...)

Maybe you could say something like, "Some of the content which could
have gone here already exists elsewhere:"  If you take that suggestion,
you can probably move grep.h to the bottom, as it's the exception which
doesn't have content that exists elsewhere.

> 1- Documentation/technical/api-grep.txt -> grep.h does not have enough
> documentation at the moment.
> 2- Documentation/technical/api-object-access.txt -> sha1-file.c and
> object.h have some details
> 3- Documentation/technical/api-quote.txt -> quote.h has some details.
> 4- Documentation/technical/api-xdiff-interface.txt -> xdiff-interface.h has
> some details.

For this list, I think you can remove the numbered bullet, and the
leading "Documentation/technical/" - we can see the files deleted from
the diff.

 - Emily
