Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23F520C39
	for <e@80x24.org>; Fri,  8 Dec 2017 18:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbdLHSBc (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 13:01:32 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:41382 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbdLHSBb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 13:01:31 -0500
Received: by mail-qt0-f182.google.com with SMTP id i40so27806360qti.8
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 10:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Gpu/7dpRD+cGfZ48F/BmcOT0vaNg++MQbe3m+T7YrPU=;
        b=ojoYYLNMf/Fy4pfb4rSnRTYvxdf1q9dM5qB8UJdzcHnI4xb7d4dZBc9JVd7Kh9N3U4
         fnvVi9tLm8u5yF5UTFwf5nO39JYebBPpMSWM7Aila+dTcLvlNvPvFEbDBzWTijFf7UAn
         lFChkFwzLReNwd1utIMiqJoL//UhNX3ZwcPhyBLy1WewzIkWD4nATV1pAGDqxRC7D+an
         K+pEsZoyD/mV2UN61I+SXM/Nyf5fAJTt/NRjLSXjBOqExeN1hy1P1uPo91Apxr93tgOc
         vjSJtMbVE7oRA034lHWcSyITd1fX/nNzgjtbihrjfy0EEpPpZ2XijHF/ZU4L4yshfuYL
         pWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Gpu/7dpRD+cGfZ48F/BmcOT0vaNg++MQbe3m+T7YrPU=;
        b=T2n6mQlUbaOTsssFt7VOjASLCG4wqkT77oAHj1hLG/KlJE0WmkkhZEzOrHgzwkWedb
         EQFDV9oTODiHM+Aucik2wWg9R26ItyKRcJcgkfcq14Ud/A7i5lDyQmrd6FluvrBJBM9P
         V5tjNMRvV8C7IGi2IJHHtvgYqGuqvEg3eFdCHHmmj9j4yBnlXcZaO/U+htNZjb9cwBuP
         PvCKIXygkAljCUIJR4X0n3UaDYNOMWszaK9ts0j1crgM0/wHtDYFUwmtCchAMHbqXJxa
         lWsTR7uP951JsEkbZI+Ww6w2IdINcJIzOynCbkWSfQmyDKEito5rQuAdUrWUVcTXYHYv
         b5xQ==
X-Gm-Message-State: AKGB3mJub8OtACIA7QEuXAz2I0mduh954nvVBFiaoGCAvg5ZSn/TXsei
        FTsanW9qicCHGDC01htOknA7Lk8V5IxmQIiyZTk=
X-Google-Smtp-Source: AGs4zMZsUOZlJyGgtvsYDUxos0VD0HtGqzjP5WcLKF8LQqEqBxdiuRC9VdpK9E1Uq9E40aAlP6vvtyDUznjTjzW1CiY=
X-Received: by 10.237.59.22 with SMTP id p22mr16560185qte.34.1512756090277;
 Fri, 08 Dec 2017 10:01:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Fri, 8 Dec 2017 10:01:29 -0800 (PST)
In-Reply-To: <20171208151807.3569-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
References: <20171208151807.3569-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Dec 2017 13:01:29 -0500
X-Google-Sender-Auth: 4yfBRXIarDWvioFQIE5TXNYR-Ow
Message-ID: <CAPig+cTgJepi6xVn0+qP3SW0Y0g-6Nf4LvCjCkvEHfZwugY1Hg@mail.gmail.com>
Subject: Re: [PATCH] doc: reword gitworflows for neutrality
To:     Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Cc:     Git List <git@vger.kernel.org>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 8, 2017 at 10:18 AM, Daniel Bensoussan
<daniel.bensoussan--bohm@etu.univ-lyon1.fr> wrote:
> doc: reword gitworflows for neutrality

s/gitworflows/gitworkflows/

> Changed 'he' to 'them' to be more neutral in "gitworkflows.txt".
>
> See discussion at: https://public-inbox.org/git/xmqqvahieeqy.fsf@gitster.mtv.corp.google.com/
>
> Signed-off-by: Matthieu Moy <matthieu.moy@univ-lyon1.fr>
> Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
> Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
> Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
> ---
> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
> @@ -407,8 +407,8 @@ follows.
> -Occasionally, the maintainer may get merge conflicts when he tries to
> -pull changes from downstream.  In this case, he can ask downstream to
> +Occasionally, the maintainer may get merge conflicts when they try to
> +pull changes from downstream.  In this case, they can ask downstream to

As a native English speaker, I find the new phrasing odd, and think
this may a step backward. How about trying a different approach? For
example:

    Occasionally, the maintainer may get merge conflicts when trying
    to pull changes from downstream. In this case, it may make sense
    to ask downstream to do the merge and resolve the conflicts
    instead (since, presumably, downstream will know better how to
    resolve them).

>  do the merge and resolve the conflicts themselves (perhaps they will
>  know better how to resolve them).  It is one of the rare cases where
>  downstream 'should' merge from upstream.
