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
	by dcvr.yhbt.net (Postfix) with ESMTP id F063F1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 19:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfF0Ts2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 15:48:28 -0400
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:43958 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbfF0Ts1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Jun 2019 15:48:27 -0400
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-01v.sys.comcast.net with ESMTP
        id gZ4whtKosJ4bugaNfhcARV; Thu, 27 Jun 2019 19:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1561664907;
        bh=U+MZe5qQTFKNY7jZ7ayNBPBcaIfNQ4YcPSR/VjAMXuo=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=6NZYlzVPwYW55SixhT7RhCuzn390Dw7kLzdV0AavJGIRDk/IFm6xeH1fDzLrp7ZwJ
         Th/bbGAKbQRf812zCkqZ9OPOgLJ/9KImkFT5eP1ungo263FxQRpBlziKkhZglHglk1
         JTe+DsNiEgYHNegkqJHW1DkDakHRuqlXgIYBLiE+xHU/4wE6Wzxdb9tBe2PR611kD8
         4CdGhwx7q2D8aRP5fOxG+gpU9xfDJy2eNDBtBnaTUgv9oC/sEY+LgvMhB4885vYzZ1
         bLDVLigK4VW0IrsrVFyIgvehh7Evi2D7vRHzJV+eWnD4NlQapiO/7OAOHpQHWmKNOI
         R2wa+ROh7RxRQ==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:ac3b:83cd:e5c7:24f4])
        by resomta-ch2-16v.sys.comcast.net with ESMTPSA
        id gaNNhv8c8nR7SgaNWhkJcl; Thu, 27 Jun 2019 19:48:24 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Thu, 27 Jun 2019 12:48:09 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #06; Wed, 26)
Message-ID: <20190627194809.GA54617@comcast.net>
References: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 03:29:29PM -0700, Junio C Hamano wrote:
> * md/list-objects-filter-combo (2019-06-17) 10 commits
>  - list-objects-filter-options: make parser void
>  - list-objects-filter-options: clean up use of ALLOC_GROW
>  - list-objects-filter-options: allow mult. --filter
>  - strbuf: give URL-encoding API a char predicate fn
>  - list-objects-filter-options: make filter_spec a string_list
>  - list-objects-filter-options: move error check up
>  - list-objects-filter: implement composite filters
>  - list-objects-filter-options: always supply *errbuf
>  - list-objects-filter: put omits set in filter struct
>  - list-objects-filter: make API easier to use
> 
>  The list-objects-filter API (used to create a sparse/lazy clone)
>  learned to take a combined filter specification.
> 
>  Will merge to 'next'.
> 

Great, thank you. I do want to apply jonathantanmy@google.com's
readability/textual suggestions. Can you wait until the next roll-up before
merging, please? I'll send it out today.
