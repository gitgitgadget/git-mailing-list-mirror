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
	by dcvr.yhbt.net (Postfix) with ESMTP id AFEA01F731
	for <e@80x24.org>; Thu,  8 Aug 2019 18:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfHHSXF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 14:23:05 -0400
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:41724 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727649AbfHHSXF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Aug 2019 14:23:05 -0400
Received: from resomta-ch2-12v.sys.comcast.net ([69.252.207.108])
        by resqmta-ch2-07v.sys.comcast.net with ESMTP
        id vjhGhrsjl544Svn44hf48N; Thu, 08 Aug 2019 18:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1565288584;
        bh=SIaQdXFIIekq2P8ChEkAifNeaisQEInXrQzFaKXZjus=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=ygPcEjOLPInIWfbXrtpfavvfSS4SA1LQ8AyWA4MBrH6RuCrOGef2lZs/pLgBDPHbc
         HzvJGWqjGueTp4QigI3s2uCa+LOMvRsliDwsjEYh9CSYthknHhV3MKRUJWrJkrqkPg
         n8/5mIyYDVy0T/TaE/La3p9mn//oF4i0gmYrB3Lxvc3X6Bj1nNdFO0Rg210RkKR884
         03RxcR8xxT1y6iwzgZeiKey2c1airsaqVaLSp4ByGqNXrDRUhnB9lXafuRLOG0rCzZ
         kYawBqZwzWMUrBgqIZeO7kT6UXn19Chx4Ba57ZiZCWM0EEsqP1PGtL8Bzgb04phTZd
         XZEUQvQP1qzSw==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:a9c1:5c2c:5c87:36b6])
        by resomta-ch2-12v.sys.comcast.net with ESMTPSA
        id vn3ih8oc3vbxRvn3shwl5H; Thu, 08 Aug 2019 18:23:02 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Thu, 8 Aug 2019 11:22:42 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: What's cooking in git.git (Aug 2019, #03; Tue, 6)
Message-ID: <20190808182242.GA96790@comcast.net>
References: <xmqqv9vahs6p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9vahs6p.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 02:58:38PM -0700, Junio C Hamano wrote:
> 
> * md/list-objects-filter-combo (2019-06-28) 10 commits
>  - list-objects-filter-options: make parser void
>  - list-objects-filter-options: clean up use of ALLOC_GROW
>  - list-objects-filter-options: allow mult. --filter
>  - strbuf: give URL-encoding API a char predicate fn
>  - list-objects-filter-options: make filter_spec a string_list
>  - list-objects-filter-options: move error check up
>  - list-objects-filter: implement composite filters
>  - list-objects-filter-options: always supply *errbuf
>  - list-objects-filter: put omits set in filter struct
>  - list-objects-filter: encapsulate filter components
> 
>  The list-objects-filter API (used to create a sparse/lazy clone)
>  learned to take a combined filter specification.
> 
>  Will merge to 'next'.
> 

This has been the status for a while, and I don't see it on "next."

I notice Johannes wanted a fix for incorrect strbuf usage to fix a linter check
- (just saw his earlier message now) is that the cause of the delay?
