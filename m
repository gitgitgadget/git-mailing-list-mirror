Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B38261F404
	for <e@80x24.org>; Tue,  6 Mar 2018 12:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeCFMQh (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 07:16:37 -0500
Received: from wine.codeweavers.com ([209.46.25.134]:57438 "EHLO winehq.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbeCFMQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 07:16:36 -0500
X-Greylist: delayed 1333 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Mar 2018 07:16:36 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=winehq.org; s=20170406;
        h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:Cc:To:From; bh=Akle/XgOJura5MkOGMh7vXwX6I4AGGgv5SNTnz5ci6w=;
        b=DnANJIf2Wb/ASfYOocN5zgFL/I9dK/3hhfF0bXO/aMUwCzQU9kVxQGeCcb/MZaduknALvcXShF/3tBzazyvawDVm8xmdVk4LmHH/F5DJc2ebpaQF6rGwad+GuiBL0lfHdwBFycB25MtagMsx5H+ecEeJKydsfIvbPqXAVBgThBA=;
Received: from [207.108.82.226] (helo=barbatruc)
        by winehq.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <julliard@winehq.org>)
        id 1etBAi-0002VT-87; Tue, 06 Mar 2018 05:54:21 -0600
Received: from julliard by barbatruc with local (Exim 4.90_1)
        (envelope-from <julliard@winehq.org>)
        id 1etBAZ-0006Gy-Ae; Tue, 06 Mar 2018 05:54:11 -0600
From:   Alexandre Julliard <julliard@winehq.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] git.el: handle default excludesfile properly
References: <20180303034803.21589-1-dorabpatel@gmail.com>
        <CAPig+cR=adC_Ok=FJw2APaLahXX_v1ix4ufEJyBhED5ruXaQxA@mail.gmail.com>
        <CAE09B1+XXJvrOucHwehUGk=Taio7sirfOh5gq7KGs4iZSpK=vQ@mail.gmail.com>
        <xmqqr2oz9rka.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 06 Mar 2018 05:54:11 -0600
In-Reply-To: <xmqqr2oz9rka.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 04 Mar 2018 18:36:37 -0800")
Message-ID: <87muzlwhb0.fsf@winehq.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Having said that, I am sorry to say that I am not sure if the copy
> we have is the one to be patched, so I would appreciate if Alexandre
> (cc'ed) can clarify the situation.  The last change done to our copy
> of the script is from 2012, and I do not know if Alexandre is still
> taking care of it here but the script is so perfect that there was
> no need to update it for the past 5 years and we haven't seen an
> update, or the caninical copy is now being maintained elsewhere and
> we only have a stale copy, or what.

This is the canonical version, and I guess in theory I'm still taking
care of it. However, the need that git.el was originally addressing is
now fulfilled by better tools. As such, I feel that it has outlived its
usefulness, and I'm no longer actively developing it.

I'd recommend that anybody still using it switch to Magit, which is
being actively maintained, and IMO superior to git.el in all respects.

-- 
Alexandre Julliard
julliard@winehq.org
