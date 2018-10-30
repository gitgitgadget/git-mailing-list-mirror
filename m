Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD1EA1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 03:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeJ3MmX (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 08:42:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50525 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeJ3MmX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 08:42:23 -0400
Received: by mail-it1-f194.google.com with SMTP id k206-v6so12220246ite.0
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 20:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ov+5Q+rECXWyRdO1W72oB7q8g6tM3nL+HBX8nEh2uSk=;
        b=rAHc7DaavKh4QOMhhJH2FAfC+G1PILp6+Dwm8A9D2Fd/86+0mqiCu9FdES56mv9VnF
         /DNT/WK2SF6k/rE9cXMkLoxCLX4XBG9NEbBTnVM90kvrvmsBYJPSh1tLiDBTa25ERzn8
         OL7XwqyL8NzUyDPZwWT0pJB0unSRrD26/dQkdJB+EheRv5R4ziQ5t8n6fXPCzc3pnJjD
         kbAGXDdKU5+0HRysklSLtc1FR0daZXd/WQ66hO/VYcCI0v0WbcZroGvqwiSc3an8qyx0
         0vHa8KFH5AyUVchQg88srWoX/N3QQ9Ya1jp3adzYbZEJwJinfmLz5WHx6FA8HW9ca+RJ
         +3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ov+5Q+rECXWyRdO1W72oB7q8g6tM3nL+HBX8nEh2uSk=;
        b=iD5TqFHu9LWP/NmAWk6sZRTHd6qGfJpr1rEMZD24A0wq3k8PohjpKAuLOsO+punxyE
         3D3REkK3q58jfz5UpxEr1uUL5+uu+/f9LjbwwNCRg1/2DXm4qYUk13imjb3Hp08OAtRh
         mzQDcTA3TXIBmRnA6Mnm7VQVbVYLUOgSaLGvjgcjykbP3trwyjc0SkVV8spMK6mAMc9k
         vrcpyL1QaccnjxYBKMwhdxgvUXmUSaAYkDdy9iSnmMKlDaIJfV3h0v5qOqTEmThULGcu
         wtrshNC9rYPJkn6a/ee9CUWOr8KJGyxMQKRBJ99PWn/cWpb8KALWZij49SnBt4CnTsHf
         xY1A==
X-Gm-Message-State: AGRZ1gK3rRjyuK208YLjG4QLKNfkNtTcWKAbgSCIjOyMF0IHve5j8P67
        mr+nj5iBdd2J8UhCVHto/+I=
X-Google-Smtp-Source: AJdET5dElF6wCDxPosbluv/+kFebBQJSdLf8RziAyNGL2R8oyjJ1nYMPZuRvLgvj/qeu6eqnnkZc7Q==
X-Received: by 2002:a24:d4c:: with SMTP id 73-v6mr301324itx.117.1540871438897;
        Mon, 29 Oct 2018 20:50:38 -0700 (PDT)
Received: from archbookpro.localdomain ([216.1.133.205])
        by smtp.gmail.com with ESMTPSA id q194-v6sm5555020itb.26.2018.10.29.20.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 20:50:38 -0700 (PDT)
Date:   Mon, 29 Oct 2018 23:50:36 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Subject: Re: [PATCH] completion: use builtin completion for format-patch
Message-ID: <20181030035036.GA14941@archbookpro.localdomain>
References: <31160e8c63399e8c866eef40462d0b699bae9b59.1540835698.git.liu.denton@gmail.com>
 <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 11:20:45AM +0900, Junio C Hamano wrote:
> We saw a similar change proposed and then found out it was not such
> a good idea in:
> 
> https://public-inbox.org/git/CACsJy8DUrVJu0HN7kuCeo4iV5aimWbYtr+E-7kenPVDx90DpGw@mail.gmail.com/
> 
> It seems that this one loses options like --full-index, --no-prefix,
> etc. compared to the earlier effort?

In _git_send_email, we have the following lines:

	__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
		... more options ...
		$__git_format_patch_options"

Would it make sense to take the old `__git_format_patch_options` and
just roll them into here, then make `_git_format_patch` use
`__gitcomp_builtin format-patch`? That way, we'd be able to reap the
benefits of using `__gitcomp_builtin` where we can.
