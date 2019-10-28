Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08DE1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 10:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbfJ1KNx (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 06:13:53 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:50898 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732270AbfJ1KNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 06:13:52 -0400
Received: by mail-wm1-f50.google.com with SMTP id 11so8784582wmk.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xrUrJPDNwQHKvFocnXM31RsFlH6TPJVUOvAQX20RX/M=;
        b=KEnjQekKAIbKfs54wZa2AH3jDz5HODZPlUwR5k4bBhh5mL/3R7O+j+TTg0CL3jgTIv
         VEIoHoHGEUcEChST5Y+z8SeBsjjX9qhb/fceYdZiR5V/WQljLL1JZqqXwSaVJhHNRSfc
         UKy8yG/luD9YCOMc96DJmbmnicYEi9HwyQgZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xrUrJPDNwQHKvFocnXM31RsFlH6TPJVUOvAQX20RX/M=;
        b=hL6YcDL8z/oZR3DtptnYrPo6cFaKGwd1BlpwYeUcvEmMjoqLgSuGtVpxjR1iQ0UCos
         b9fDRm8BRln+Z1dBhphU5JhQHDIwr8QjyVLRR/lCZ3cS3NTyP+C10bXkWEIgkUO4MgaM
         1VaEKcumktYrhdmlqMt7O1UUoWW3RzbNgI46IlO5F5cu4nk51Mi2T9hpE5tVLEuuZ1tY
         bHW9Rj85D524tEkw4fpfQadhyPekj62261WgqgZWXOWgXPadzJSmGZxPmF2y7Xc0KWjq
         IIyPNTIw9phDtvb0I/FWQeVG7fvFnIyJ6Zb5DHUf4da4aXen6Ure4TJ7GDuz1yj4BeJx
         xJ1A==
X-Gm-Message-State: APjAAAWN4hmk5kCtYJ82Sp1mOIZ1mdH9v7hG+mKajZx6zTN5jwNEcK49
        B1M9qP4KQF1AfmfzWG3aHJygXA==
X-Google-Smtp-Source: APXvYqxbpOFEKcikzZzFqHtZsQ1oles5cnjkjnEaB+IKArkmgs6TwfYXxSN8C84If3Oag//8wdO/+g==
X-Received: by 2002:a7b:cf36:: with SMTP id m22mr14161194wmg.98.1572257630072;
        Mon, 28 Oct 2019 03:13:50 -0700 (PDT)
Received: from pure.paranoia.local ([91.217.168.176])
        by smtp.gmail.com with ESMTPSA id y3sm16325235wro.36.2019.10.28.03.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:13:49 -0700 (PDT)
Date:   Mon, 28 Oct 2019 06:13:47 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: RFC: Moving git-gui development to GitHub
Message-ID: <20191028101347.pofpm6m3hbxjhwlg@pure.paranoia.local>
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
 <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
 <86k18rbbyz.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86k18rbbyz.fsf@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 26, 2019 at 08:25:40PM +0200, Jakub Narebski wrote:
> It is unfortunate that we have no tools described in "Patches carved
> into developer sigchains"[3] wishfull blog post by Konstantin Ryabitsev...

We are working to get us there. It's going to be a long process and we
are choosing the evolutionary approach as opposed to staging a
revolution. :)

-K
