Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787492027C
	for <e@80x24.org>; Fri,  2 Jun 2017 21:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbdFBVyC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 17:54:02 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35256 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBVyB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 17:54:01 -0400
Received: by mail-it0-f51.google.com with SMTP id m62so18981552itc.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 14:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5fGd2b7rCg7NEBRdVfUo135en7k3L+D7VSoEfkRYd9o=;
        b=nHCVf0PEMiTJj9MHEYUZ+BP/MwLCi53IKxLTJkylG+khZDNRcympCV2Axx+57+6pGF
         bvmlTQ8jQnWh4//jjS49NMQaRASCZw9zST3OKd4+ZQXKO1xa0rr4DTZsRkxGf8IiNJ+V
         jOOWxrDX6hc9LzQI9PmoLNdphZjzw6gZIbgE0UmUPPuMwlcalLYppzFiDR7TIwX06hC7
         OjhyqG1m9dVxHgjJGNAzT/Vb/Hv5NJZKd9SwYyx2l5Qyi0LYcDKVPFbkJvwKKgtQByxj
         vlvcHqlrucRiEaanOkJGZVzhZGqqqQ2pUtQ/Q9wngFhckmeZJtghfH7ZZqFNJqAC6Pn9
         rZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5fGd2b7rCg7NEBRdVfUo135en7k3L+D7VSoEfkRYd9o=;
        b=mLbo9Wew0xRnPVrGKpVZ3gb3SBjbIkmlrnGAbeadbjblyQfZ1Pq8XXuOQGcAUfwJMA
         txIwu86/s50qQ4fyojxObyt/KW3F27ShLtG60IPveILkfSlUDWPAnMmPLGCSW5nfj9oF
         Z1HM2BJDefpPgOJaoqL+N68qWFZG24zHBOZnRPyMeAN+K6PiR19IYF/Gqs7hFysmBGnQ
         5fiS7M0kiCSz8XkgMNqaeKkLpImnGY5lHepczvuAv8W7Xn/N5YFMX2vJksz+7YLOWfbd
         3YlBFiFBfnFQNzyHVPvBEbo3Zd4NONASNIhwvm+wKjO0ss+2hOwBxHONEPe0y6P8UK5Y
         G0kQ==
X-Gm-Message-State: AODbwcBlwZhgfyq7Vd1bkxRGLjc9smdJmVP6sItgoxaQOGUQ6FPkpeil
        0v8kTTgnS4BiCMteJ352UlYPE7hTOw==
X-Received: by 10.107.149.7 with SMTP id x7mr9624900iod.167.1496440440358;
 Fri, 02 Jun 2017 14:54:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.168.65 with HTTP; Fri, 2 Jun 2017 14:53:59 -0700 (PDT)
In-Reply-To: <CANgJU+UzoaN3Urj=L4unMMtNwFm6G8LGxx19g49AR5R+76F2OA@mail.gmail.com>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de>
 <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
 <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
 <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
 <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
 <xmqq37bj454a.fsf@gitster.mtv.corp.google.com> <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
 <CAN0heSq3CSe=Hgygtzd+ZM4rW-qM1_chrNd7Pq0KnYnKEVXcpw@mail.gmail.com>
 <CACBZZX5re5Ge1OzxYOE42nwBhhusya6=M9An08X-KzaqNH9Cog@mail.gmail.com> <CANgJU+UzoaN3Urj=L4unMMtNwFm6G8LGxx19g49AR5R+76F2OA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2017 14:53:59 -0700
X-Google-Sender-Auth: 3GWkFNCD-6rUwwt22CiI-tWX8vE
Message-ID: <CA+55aFwL9LQfx8t7tixYgV+2w_=_dAABxk54_GLJoGod-w=mbw@mail.gmail.com>
Subject: Re: Unaligned accesses in sha1dc
To:     demerphq <demerphq@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 1:17 PM, demerphq <demerphq@gmail.com> wrote:
> Most hash function implementations have code like the following
> (extracted and reduced from hv_macro.h in perl.git [which only
> supports little-endian hash functions]):

Yes.

Please do *not* try to make things overly portable by adding random
memcpy() functions.

Yes, many compilers will do ok with it, and generate the right code
(single load from an unaligned address). But many won't. Gcc
completely screws it up in older versions on ARM, for example.

Dereferencing an unaligned pointer may be "undefined" in some
technical meaning, but it sure as hell isn't undefined in reality, and
compilers that willfully do stupid things should not be catered to
overly. Reality is a lot more important.

And I think gcc can be tweaked to use "movbe" on x86 with the right
magic incantation (ie not just __builtin_bswap32(), but also the
switch to enable the new instructions).  So having code to detect gcc
and using __builtin_bswap32() would indeed be a good thing.

                     Linus
