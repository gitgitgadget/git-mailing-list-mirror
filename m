Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44CA620281
	for <e@80x24.org>; Wed, 24 May 2017 00:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759736AbdEXAPt (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 20:15:49 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33768 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbdEXAPs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 20:15:48 -0400
Received: by mail-pf0-f182.google.com with SMTP id e193so129531860pfh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 17:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N4KedDQ0km6FlISW38Rjtzw+7sWXNVbc3siNrJolvYM=;
        b=g33FdWyO5ShFkMk+pqibODTXrVdblCBf46NiHe0mffO9jM5mW+ORvtEFbhcaKkefVi
         DU96GAJ7bxNPgYPtNP05oWJv4A2nq5vAcyJtMhcIQrLyVpB81UjAChR7ZMJv6sAg8SZp
         mbJA/7yyNcnCgMEG2rclzXUuTPiGgjSgcPRYloM2ZtLfZ9QKyEa0+MaJmYDcrpTgSsIQ
         sY3sNLolW37j1emddQkBOiDmgvL3Q2SqKlqgpV+UdJf30cOTaAuPsLRb6Nl6RekkYbac
         1ygQ78KdnqBnFR9BmN73mUGWbfrPiGiVYBwQ8JXIQBPDl7tXTSxaTzMzG+/nNDHjzrAb
         oXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N4KedDQ0km6FlISW38Rjtzw+7sWXNVbc3siNrJolvYM=;
        b=enJ3NwS3LaLp7V4qpQSvAYbrtEuTuVy6gkSIdrA4c6Z1pbMkxgE8O5T8x+JOJ/oUv8
         Y7Aev3krnFcnr2Bi9kBi1ipuuZfCS5SAa9AvAIb+CeqlBcOyaIxSDLAOxIKohUn9DPvo
         fNRGTd8DgtOODOl81tCd/w/9EFmbrkvlqnUeOM8fHitC9N+pwzB2H4uvufmwC0BUylhb
         izKmVQkz22PeoRqx9ca+Us18cwmmc2Rp+LcvrsdAjzNMxS7MVRkR4hT2cu44YCXRI1N+
         R4oQwST2EAxzIw7XjBuUcUYu205iKvFDbjam+vro+4sDavM4PgIxJ+qSvBTkaC79zSkm
         juJA==
X-Gm-Message-State: AODbwcDVIgvE4XabNznSTOOsLGRwBzmsuYN1LX4Laaf2mXs8UiI9Z8xw
        HWUMl43nCrfUjFz1WTXdlvN1jVEnuPY7
X-Received: by 10.98.91.5 with SMTP id p5mr17063655pfb.94.1495584948031; Tue,
 23 May 2017 17:15:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 23 May 2017 17:15:47 -0700 (PDT)
In-Reply-To: <xmqq60grjgje.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYirjV0eQgB_ng-64HSPN_7njUMjnoNBkmWnx-rinsemQ@mail.gmail.com>
 <CACBZZX7HYU1USdcX_=CDFiMDtdaySSjd0zv-Bb1Z9-nHxk8UvQ@mail.gmail.com>
 <20170523151310.mhdhck5djmdlxrt4@thunk.org> <xmqq60grjgje.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 May 2017 17:15:47 -0700
Message-ID: <CAGZ79kZufFQ9wUa8u1usPuWt-KLgfSxdGiXipYXiQW+k_JvQpQ@mail.gmail.com>
Subject: Re: Another git repo at kernel.org?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        webmaster@kernel.org, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 4:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Theodore Ts'o <tytso@mit.edu> writes:
>
>> So Junio owns the pub/scm/git/git.git tree on kernel.org, and he may
>> already have access to create new repo's under the pub/scm/git
>> hierarchy.  In which case we might not need to bug the kernel.org
>> administrators at all.
>
> Yes, sorry for a premature inquiry.

Thanks for bearing with my premature questions.
I just went off from https://www.kernel.org/category/contact-us.html
to see what the workflow would look like. Knowing that Junio
owns the complete pub/scm/git namespace is a good data point for
our discussion.

Sorry,
Stefan
