Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3179C20248
	for <e@80x24.org>; Wed,  3 Apr 2019 21:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDCVtx (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 17:49:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42652 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCVtw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 17:49:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so859658qtc.9
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvrWAe28+nzFjUWxIx9G2aMb74DFa4nBemD+Rxmo1vM=;
        b=ztw0LQgnze8/ihEbEeH6LYS47DIsP3sfsa/mz5T2RVb3ePpxRXu5EA98shwlasQIGh
         2NfixYTLk/Y+B+SFRcRm5M0qAyEKlRggyrGDm5gI7RO6JLrDvylMBTr3+lxsRomKMr0l
         FNtW43o+7MMGHDJ0cVbxXDELcFkpU5P4ld6uYQSlep/dwxa4b25Wk93hFVXhLqNPnQLt
         SVFmPfz31Eelek+U+30TERiAQUhzPQmxHiYI3D03sWAjwuMNaF++Q0dmMopJK3R7qK8i
         tUbcUMAdt/6Pl+qgwzKzk0xm/F7A7Xw+oOxvDhaD3dpbynHlZ4jqqxwrrpjzuu2GAbCd
         FsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvrWAe28+nzFjUWxIx9G2aMb74DFa4nBemD+Rxmo1vM=;
        b=sUIz0a1w8TLInrED5MyJMuhErg2mxf5zBwOdQIBlfVdNe2PWqK7nUUnz+83Q54J9Vf
         LHiMBFL16j3gTS5jAsadoDyN1bWAMT9QADpl7JuuRKZNQCTn61/ul3s2SY4JMZ3aI+3C
         gfjY8xVO6Uu6llp4a4+vbIjpu7uDgAfFW0FD2aw4c/KbkOIn6KnViNK6/mdYnnDM4fTV
         4X5dJ8Iy3y5cYCF+b2jhG/nT2i/GLKaRJ8n2euflF7s/AQ+lG0idXLMttxPbE65FSdCt
         i6hRPLQOikH/VRCjZgTN76EpVjkba/3BHaP8SMyuT5ZWSC/BzRaQeJlMDP9iidZo15BI
         GnGQ==
X-Gm-Message-State: APjAAAXje76AzX9PXLg/2HQqQdyE1oJP1pzSNfq2ZhA0NUImeN6PucsK
        XDKI3rtToUZsfxGmyvpnz24zkE/ia/eZ3Rjf/lI=
X-Google-Smtp-Source: APXvYqwoZCbeTn85NhOer0pXvLKg3aVE0yNm3ciyimJzz/5eRvVZSDvlhpgEKtLF64YevmPbGfD8Z2N87Wrof59bZ7w=
X-Received: by 2002:ac8:33b8:: with SMTP id c53mr2133248qtb.11.1554328191940;
 Wed, 03 Apr 2019 14:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190324235020.49706-1-michael@platin.gs> <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com>
 <b077afed-d143-506e-977e-6edf2492f75f@google.com> <CAJDYR9R77_+gfOgLXX_Az8iODNRyDTHAT8BAubZeptEWJViYqA@mail.gmail.com>
 <7540d14b-f225-39ec-b37e-54cb157d4a72@google.com>
In-Reply-To: <7540d14b-f225-39ec-b37e-54cb157d4a72@google.com>
From:   Michael Platings <michael@platin.gs>
Date:   Wed, 3 Apr 2019 22:49:39 +0100
Message-ID: <CAJDYR9TmRThj5J_4ecj619_-19VqzHX17dBpUScJvvv6c=5zjA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
To:     Barret Rhoden <brho@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Barret.
I've cooled off on the git-notes idea since learning that notes
branches have to be pulled explicitly. And different people may have
different ideas about which types of commits they want to ignore, so
not predefining the name of the ignore file(s) does seem like the best
option, even if it's not perfect. And maybe having --fuzzy as a
separate option would be nice, maybe not - either way it can wait. In
short, I've come full circle and wish to do what I can to assist your
proposal (+ fuzzy matching).
I've rewritten the fuzzy matching function so it's now much faster and
more modest in its memory use. I hope to share the patch tomorrow.
Following that, I'll do what I can to assist with reviewing your
patches.
Cheers,
-Michael
