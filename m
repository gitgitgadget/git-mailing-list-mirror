Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8F91F731
	for <e@80x24.org>; Tue,  6 Aug 2019 01:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfHFBae (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 21:30:34 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:35806 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHFBae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 21:30:34 -0400
Received: by mail-pl1-f182.google.com with SMTP id w24so37148543plp.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 18:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YLKtsVpP+trDXLseUp6+C3LPzCWyh69o04m5rtrRWaw=;
        b=GIj0GdqEhVTh2wIBzn6OE7oJvi8muRDF2j5A+uXWFVPjxPknXIUy8ZFepKwCJ/6An9
         B5cibm9ilxv+/dzH+Srbkn5j9FEQaX3WYKs89wQZE42KENWx2HYW2QhN/aG09zbdZoM9
         UbkWG8uk1QSMTXdG331KjqO9jwjOiO7yPBLBQt3M2ogsB5gkgVoNwCVKQ9egIk67iK+K
         Hw1O5U+AU0mq2qQRyB5fKPxtE3Vp6N4+kxyPc6m8pSYGxDK+fTLIhoSyAd8Ex3/b9No9
         fzHL84ag4nb5vZKkxtRccgerqR97ZB6jfKwNIIGyogMuxK8BWod8tGhT6z0mv0Kbltiq
         iWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YLKtsVpP+trDXLseUp6+C3LPzCWyh69o04m5rtrRWaw=;
        b=sXaZ1Mpg4hgxL9IeRxdolDCDVrE6NfGyuJlCbrP6elIdCX/uJUK6FASSEeuarcM7w9
         BJc6Rp7H9psAKg2obbprX1YUhf5pCrQ1dpmcHxcuise50pGCCAcGtC9AOdFX3yzvKRDT
         KykcOoqr6wBBPGPy3jrIj4mho9IXulMdHQLcrZDKfrxlWInv73VAMDQG73RQH2V6vPfW
         kRfP9RiJAEW5tHg29Vm1qLwfWKNCKXyWED42JLx3M39coORf6wp7IE4iD/P10Qp6z5Ff
         M29zH8gLEuS2Yldlib2umznvirnJsOfOi1QQ0BJEbQ1+YU7slqn6syz6YisvDMhyZP2S
         CDag==
X-Gm-Message-State: APjAAAVQlRps8RTbFdQq1E8ILsWYdxLgzgkDdp6yTqJo199/qeeth07d
        /Ax8lfr/imvVeCpDC+fc5yc=
X-Google-Smtp-Source: APXvYqwjCbtZepyHHmGpcPM2HYTr/dYFL1Cyge7W/m/lgrcUkRGi9Z/yMK6zw3onCy/qXPJRawvxQw==
X-Received: by 2002:a17:902:9041:: with SMTP id w1mr638880plz.132.1565055033131;
        Mon, 05 Aug 2019 18:30:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b36sm23980782pjc.16.2019.08.05.18.30.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 18:30:32 -0700 (PDT)
Date:   Mon, 5 Aug 2019 18:30:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Lukas Gross <lukasgross@u.northwestern.edu>
Cc:     git@vger.kernel.org
Subject: Re: amend warnings with no changes staged
Message-ID: <20190806013030.GA61803@google.com>
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Lukas Gross wrote:

> I have occasionally used git commit --amend without staging any
> changes or modifying the commit message (--no-edit). Since this is
> often done unintentionally, could amend warn when it is being used in
> this way?

Can you say more about the context?  What were you trying to do when
you performed this operation?  What happened instead?

Thanks,
Jonathan
