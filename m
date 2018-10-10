Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462401F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 09:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJJQuk (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 12:50:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36756 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJJQuk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 12:50:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34-v6so4858437qth.3
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 02:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfxI1RZqYim+/GMx8g+OlFcw5qk8AXEdlVVL/9AlBYw=;
        b=O0G7e6rwNNlhD521NknVGZYNTtBINYkWvssJLpoAazXuLZueynrAZQxzkLaXDN6c3x
         aTvMtWiKPBE5RzNkijiQIxQgjGsjJ6sulMgo75CvhKlnBK7UO4u+CnHFAYHROgQ/D/DW
         jcgIpax6mZNLUEvi0qrs7OfZdEzY3zCSEnVWQzyiymlQhmModa3/E0RKsY5S8t3/5yDV
         Qok1XHcRmDx9JUri11q5EU+xgMOeDm+fRsTKUZN4t88/dYrOZmHafUexH2Pp/CcibkQk
         fAlAVqGjbDI6o9wMPrrBMDmsqe8hMWHeLWUiVnPSOOyuT/qEAsphO9FdCY2Sc8dpVg9N
         9X7w==
X-Gm-Message-State: ABuFfojXgeJSI4Kz8hxN3vzjUQ0nCKJUfmSsxJVNYZZXYaFd7GvQVvHN
        bwCxnCidacBBDiHVB+lo4kwY2TdpMjjy2xEte6c=
X-Google-Smtp-Source: ACcGV631jmsljsnBo9MWBjuEr8sBw3XJYBa9hq7V3pNvwM3HD0IQuIeRQ8HCfGU6kcsAFAqZsxfJwK9I7enrBJPSjBE=
X-Received: by 2002:ac8:73c5:: with SMTP id v5-v6mr3180664qtp.352.1539163760933;
 Wed, 10 Oct 2018 02:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181009182006.9446-1-daniels@umanovskis.se> <xmqq8t36q1k6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t36q1k6.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 10 Oct 2018 05:29:09 -0400
Message-ID: <CAPig+cTp-cFKX2Kqj-yV7OtgmxDo7Mp7i0TUXU7JGYdgtbHiug@mail.gmail.com>
Subject: Re: [PATCH 0/2] branch: introduce --current display option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     daniels@umanovskis.se, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 9, 2018 at 4:59 PM Junio C Hamano <gitster@pobox.com> wrote:
> My inclination is to recommend to:
>
>  (1) name the "show the current one" not "--current" but with some
>      verb
>
>  (2) display nothing when there is no current branch (i.e. detached
>      HEAD) and without any error.

Sensible suggestions. Also, please documentation any new option(s) in
Documentation/git-branch.txt.
