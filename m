Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69DAE1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 16:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbeHNTds (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 15:33:48 -0400
Received: from mail-yw1-f52.google.com ([209.85.161.52]:41764 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731707AbeHNTds (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 15:33:48 -0400
Received: by mail-yw1-f52.google.com with SMTP id q129-v6so16682377ywg.8
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JvZlOQfWzw7zlKMuw4E55Il7qOdw6DU6hH/VsdBZSko=;
        b=g6M7NkJJ1j2eJDdbMAusgS57S/7dNDinTSS/WBM7lz8Auy/xkzb6fx79HBzyh5ycLD
         K9F8utMuvKvdqlae/v7omKJRjqbN0cfOtnhPQdqvilYqk0s61i4HQ1uW5mjYUxpDr/wC
         0sNzQmkF1/d0Iiw5wAMs+iIhu2aZf34GoV/79d4VXEUm2f1Qcy6LNIaZzACRqmtWhiJt
         wqxsP8ckQdSlF1bjZsu6HxosV4bfXwEFzOPYR8hjEAjDkE94GdvTZOmaB6219zoNRlnK
         8n9yS+pjc6ZaQldHQUBCB9XOjSCBGJ7MkWbMvvjf+P0TmXnklMxFr6NLyjOKKZ30YDFT
         mM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JvZlOQfWzw7zlKMuw4E55Il7qOdw6DU6hH/VsdBZSko=;
        b=CfqasCA1eXaARhr7t/JI9CG00KwdrwnUg+sWn/Thh+/upHl6K5n/UWZLvOvJptuS0o
         XxAIpraYY1nzhMHOhnVEl3FTz6IRWZsY5BVKarubwj6WsE6GAi8erHPrcU69UijOna9F
         08UAJFGngNx4GpVWjfFe+qkQCUyxLbzbAVPLRPGJNAcFlvR+NztcwaeCjzQZi5uTowg5
         KQLLiia4+71oTogkLFwO3sVIpQcjIffug9De6503Z3hRQhwCcyLqNU7Or5Cc4RZmtDYG
         Q8ENuIs19ogLccb4ChVXqer1ikCtL3HrVaqMO817RZcKdjSmIOGm3przVXBqTS5ZZF1w
         DExQ==
X-Gm-Message-State: AOUpUlGI5raHSK+9lWu3/4WC/RlEFG63acvNwpb1+eloAEYSsswTd595
        nHsTbSCSDigW5L99b8ovwprteidjCXwZj1ImCdHRsQ==
X-Google-Smtp-Source: AA+uWPw+fYjvVyyoo94itwWPYiRbXUyd6xggdUtt14TcL28V8OuGtV0sfsPy2zFAAGb063EpgYWHFBl2tDtnyRY1pmA=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr13085568ybm.307.1534265153212;
 Tue, 14 Aug 2018 09:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180814014122.30662-1-sbeller@google.com>
 <nycvar.QRO.7.76.6.1808141702570.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808141702570.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 09:45:42 -0700
Message-ID: <CAGZ79kYQtKEprxVkmRW0B5Dd6FXLqVh2DQbGf_8=QDLhu=tYhA@mail.gmail.com>
Subject: Re: [PATCHv2 0/8] Resending sb/range-diff-colors
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 8:05 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Stefan,
>
> On Mon, 13 Aug 2018, Stefan Beller wrote:
>
> > This applies on top of js/range-diff (a7be92acd9600), this version
> > * resolves a semantic conflict in the test
> >   (Did range-diff change its output slightly?)
>
> If by semantic conflict you mean...
>
> > 23:  6a1c7698c68 ! 23:  5701745379b t3206: add color test for range-diff --dual-color
> >     @@ -23,7 +23,7 @@
> >      +        :         s/4/A/<RESET>
> >      +        :     <RESET>
> >      +        :    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
> >     -+        :    <REVERSE><GREEN>+<RESET>
> >     ++        :    <REVERSE><GREEN>+<RESET><BOLD><RESET>
>
> ... this, then I do not understand. This looks like a straight-up change
> in your commit. v1 of this patch did not append <BOLD><RESET> to the end,
> while v2 apparently does.

Yes, I did mean this. Both before and now the test passes on top of
 js/range-diff (which was resend), so I concluded that the logic in
range-diff itself
has changed. However this is changed in a later patch to not appear any more.

>
> In any case, from what I see you indeed addressed all my comments (the
> need_reset was done differently than I suggested, but still okay).

Thanks.

So unless I hear from other people I consider this series done.
(just like range-diff is not going to be resend but built on top now)

Thanks,
Stefan
