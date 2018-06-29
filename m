Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B7E1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967032AbeF2QeF (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:34:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35667 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967002AbeF2QeD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:34:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id c13-v6so9412572wrq.2
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nIpLRooz8vqSEuSJFhlwwrF74oqSJoOHAvwWxyDw+nQ=;
        b=bqg6kU5C2JTCtGIMQ0uJ1adNEpqLuhjbL8bVZJCqf7hQlPsYHvzVy0ORX98pq/E7Cj
         8xUcePDZ4VYPEGA+1tCSJDul5mSryqqmBHpTFDG2C0B/bMxGvMZnquww1CP1vC5gjISn
         v7H9Lwrqr5uqVKLvwOdeP69HvTv9wh+MycaSYwyHySZdy+Lv68ShSBeg82fVO9ilUuBE
         qlsayMxopGyOF0goSBSbJeti05rxq4wlG+yHqfaz5GvAHVPRV7Kos7Dop/v2c1FFwPJ4
         dgNdFr+3wRrzbGufT0sJzuULe0NTmH/iDE0r9k+UmbNAQCWR1/3lExA7I6sMr1m5T0fU
         h4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nIpLRooz8vqSEuSJFhlwwrF74oqSJoOHAvwWxyDw+nQ=;
        b=dlyEZ+Jeks0xMNPk9Sq37XQUYYDRbIL9ft0qZONuf4o3mVF915LIT0/H+qE7ltAapW
         HcERnFnzjfGa19CRvFkYV8QitBudgISvYsDQgtYEwZX+ERqJszYP+z2pLpFpGamxWIQZ
         sRUXU1XAaHq9yS0//3ZClysk1or5WXfj2W/p1/ntcQJF/Q2a0kn43tvB4NwbdljBaYg+
         b8/JePmBj9SOBFk1QGtKLH6Po4Pe48JV5j/cCQekYpcO6t0ymDJV0ieIPPaJ4lujA0cB
         yxlmUYdeNyRGD5J5GCK7uESSxZZyxxSrNLHbZde4Q3IQdim+kI0T3PcYJawqkOW4cEHp
         xNNQ==
X-Gm-Message-State: APt69E2HScft2BqJpCsFzu9dgPZV/EttuPsTBMxpbWn+QnLVABXTmgqX
        Qra8pfUb1VmppIX0cXPyMvk=
X-Google-Smtp-Source: AAOMgpfMKqzLmw4TTiEoB0vz2KWEPsmSJQeh92mKdq2EHzZDME+Ua6PPJgTWUX9yLS6YSSHSfMAmbA==
X-Received: by 2002:adf:fdcd:: with SMTP id i13-v6mr6925964wrs.276.1530290041429;
        Fri, 29 Jun 2018 09:34:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p4-v6sm9802929wrj.71.2018.06.29.09.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 09:34:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] .mailmap: assume Jason McMullan to be the same person
References: <20180629021050.187887-1-sbeller@google.com>
        <20180629021050.187887-2-sbeller@google.com>
Date:   Fri, 29 Jun 2018 09:33:59 -0700
In-Reply-To: <20180629021050.187887-2-sbeller@google.com> (Stefan Beller's
        message of "Thu, 28 Jun 2018 19:10:49 -0700")
Message-ID: <xmqqzhzdv9fs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Over the years of contributing to open source, I realized the world of
> open source is smaller than I originally thought and a name is still
> a pretty unique thing. So let's assume these two author idents are the
> same person.
>
> In 10813e0d3c7 (.mailmap: update long-lost friends with multiple defunct
> addresses, 2013-08-12) we learned both their email bounce, so asking is
> no option.

True, but leaving them as-is is probably a better option in such a
case.  Until we get new contribution from the same person, at which
time we have the chance we've been awaiting to ask the question, it
is not harming anybody to keep these two names as if they are two
different people.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  .mailmap | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index f165222a782..ff96ef7401f 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -82,10 +82,7 @@ J. Bruce Fields <bfields@citi.umich.edu> <bfields@pig.linuxdev.us.dell.com>
>  J. Bruce Fields <bfields@citi.umich.edu> <bfields@puzzle.fieldses.org>
>  Jakub Narębski <jnareb@gmail.com>
>  James Y Knight <jknight@itasoftware.com> <foom@fuhm.net>
> -# The 2 following authors are probably the same person,
> -# but both emails bounce.
> -Jason McMullan <jason.mcmullan@timesys.com>
> -Jason McMullan <mcmullan@netapp.com>
> +Jason McMullan <jason.mcmullan@timesys.com> Jason McMullan <mcmullan@netapp.com>
>  Jason Riedy <ejr@eecs.berkeley.edu> <ejr@EECS.Berkeley.EDU>
>  Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
>  Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
