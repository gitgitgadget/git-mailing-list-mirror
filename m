Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C051F405
	for <e@80x24.org>; Sun, 16 Dec 2018 18:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeLPS04 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 13:26:56 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37598 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbeLPS04 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 13:26:56 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so16799556iti.2
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 10:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+6eqw20R29q9j1nL2LU9rXmagTpANf6EJ7XbGjHRJg=;
        b=AZfXGAHqwRCWIFjV4mPo/Kqa5ZceWZKy9DLAbNu088z38qQ6OKMgi5nnD6ogjZU6vy
         Fh41dNaZn5HIkyplXdlJNP6w5WjrkbKTrLKPzuy8EJy86hRR5rJvUytXJLHt2vrbkotQ
         m55kut8S/+Yerk/nllnHvR2R+CZrD6xxBRt6mLU5BL2lmgFZPD2PvKuLtuQEf/l09IK8
         SVoh/TIWbBPdfXWWTiY9mj6hdypB1mWk6ea0bzY66GmNOjuciiLMYDKQImZto8zhcsHj
         P9fGmhDq5NtazOoHpwCnOb01hqCcQ7fnzfcfwt0G6S1jf9rrofM8v2OmGYzlhzda+tS3
         pHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+6eqw20R29q9j1nL2LU9rXmagTpANf6EJ7XbGjHRJg=;
        b=DvnIVaK7hSN8GeEcwFZ2yotUYmUL88vEGCtfX7iXJqNUmaKuZvULCHbvcMX9tXz3wh
         EASyC51SUk/KUlHtVgAfgWvRM4RWagUJ9/dF6HRt+P5CEUmSlx48oJMwC+ovqu+RBlK1
         ZfEeymn5W9z7IKGIO9fYvaTNrg1kx+XSefGo7wnwIR61OITdXVTQzg6mcOJlwoNW0xFB
         ZPdkZDWTx9GoO1vgZbVRPfTqNZ1FRZdScMuaULGjDn3iqDT/wnxzZXFnVo7ecAEWsK88
         KdGxP8DIcHfashyCzT+txDOs5URLjAahE9mzsSjvQYq6BMA/5oeZQEM+JGnnirqAgxzF
         RCUg==
X-Gm-Message-State: AA+aEWZ5rxf8iAm+hnWDRy61moyatly3n/8pxam+5StgSyl4sNIekVRu
        raTAFmC17U47x5QVN85j/sZOJmCZxYsL5ntSFqU=
X-Google-Smtp-Source: AFSGD/VHakBBnslprSfHOcfylEzefBMSvoWz96lj3sRqFFrtMR7hRSqa6b+Nm5PQ/cZshCqFiBUBYGbLyQ/ITypzvlw=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr9860267itk.70.1544984815542;
 Sun, 16 Dec 2018 10:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20181216175536.5535-1-asottile@umich.edu>
In-Reply-To: <20181216175536.5535-1-asottile@umich.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 16 Dec 2018 19:26:29 +0100
Message-ID: <CACsJy8C+zLg0HUB-jx4tMSATLH30Jv0_bHkZ7JQRvfmVAn2DmA@mail.gmail.com>
Subject: Re: [PATCH] doc: short status for delete + intent-to-add
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 16, 2018 at 7:10 PM Anthony Sottile <asottile@umich.edu> wrote:
>
> $ git rm foo
> rm 'foo'
> $ touch foo
> $ git add --intent-to-add foo
> $ git status --short
> DA foo

Twisted, but not wrong. It may also be a good idea to describe
intent-to-add status, which is probably something like

    [ D]        A    intent to add

>
> Signed-off-by: Anthony Sottile <asottile@umich.edu>
> ---
>  Documentation/git-status.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index d9f422d56..4af7424e5 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -202,7 +202,7 @@ in which case `XY` are `!!`.
>              [AMD]   not updated
>      M        [ MD]   updated in index
>      A        [ MD]   added to index
> -    D                deleted from index
> +    D         [ A]   deleted from index
>      R        [ MD]   renamed in index
>      C        [ MD]   copied in index
>      [MARC]           index and work tree matches
> --
> 2.17.1
>


-- 
Duy
