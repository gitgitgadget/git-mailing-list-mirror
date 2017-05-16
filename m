Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B79201A7
	for <e@80x24.org>; Tue, 16 May 2017 03:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750786AbdEPDcf (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 23:32:35 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33413 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdEPDce (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 23:32:34 -0400
Received: by mail-oi0-f42.google.com with SMTP id w10so10517113oif.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 20:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=a1nRZXe3YCHrYaEH+WRNBdZwvWa/LvAp6kl6Fvdt4Og=;
        b=Cfw+r7hnqMD56KlVJxz/phPeLbpJhTUc3WX5z0IRAhmqZefvpLMOy44UJO2I4dznWG
         sEUbY0t0PU4yATf0kzVCLLSYhJC+oiCzFvZEahqovPASJjgBGP0dzA78mwKMVnKUZ1S2
         30ttpS1hfIqS2clsLvHqtBhp3sIHUNnN3SqVJRdVfpZ8Zj6sDvhcAhFRbuY4NPUgqHrR
         9NmibETkHVM5yhye78+XZ6hurahn7RT4R6yVraynfTorHs6HUN+O96q2vvmCzOurnW84
         IIZIdJRTHiCQ1T1HohxE+TegyLWGzRDIyCj70b1TSQKWHYiDs7kWdTStpyL0w7kdip1L
         8DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=a1nRZXe3YCHrYaEH+WRNBdZwvWa/LvAp6kl6Fvdt4Og=;
        b=LFfrW1IhlZAXgd7uaiZZNxbobKbqa81b2vD6nT4Ydi4CIbUtI5IwovuhQJOiPF046L
         HLRROJ0miiaXtbUPJWD80Nwb6BXnRomhjbSt5Lwa2q5BG9e79HHy7HtkgQlyMYQj2SLq
         7Np/FECBAadpWbKghDVpz1aW+CcS1nLRxJqvhTGNZUYXmlEbClPtwWiKyE2oBlPT2Mid
         5db2dLl+W3T157Eo4LH/SfNxrFFrxJMYcVibhpUNCeZIwL1Quh4J/JZM7wTYi8r84bmC
         5pdl+dGrQEX7OUSHb34F/69QBeL7OZrcLnW0yBLzjhMDRfO8cF7jH/YHEOluqxGyzhqD
         XLRg==
X-Gm-Message-State: AODbwcARjio0fyXrFvf6chP3E9sC5Is8yjx9+0yPKgsnAjOI4PuGrsmg
        3pjbt3BnW3HDLVPWztlhC2Eri5+MSQ==
X-Received: by 10.202.199.69 with SMTP id x66mr686848oif.215.1494905554122;
 Mon, 15 May 2017 20:32:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.22.199 with HTTP; Mon, 15 May 2017 20:32:33 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <xmqq8tlx4h1y.fsf@gitster.mtv.corp.google.com>
References: <CAH8yC8k8sTGDA=C8vLCE090Y1B4TK86bOnZMNjj13C-JXVEBHQ@mail.gmail.com>
 <xmqq8tlx4h1y.fsf@gitster.mtv.corp.google.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 15 May 2017 23:32:33 -0400
Message-ID: <CAH8yC8mOc68A-0uM8b3AKAYo9VqYNUjHkGw0knbXL0suM25tfA@mail.gmail.com>
Subject: Re: How to force a pull to succeed?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 11:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeffrey Walton <noloader@gmail.com> writes:
>
>> I scp'd a file to another machine for testing. The change tested OK,
>> so I checked it in on the original machine.
>> ...
>> How do I force the pull to succeed?
>
> Git doesn't know (or care) if you "scp"ed a file from a known to be
> good place, or if you modified it in the editor.  When it notices
> that there are differences you may rather not to lose in these files
> (because they are different from HEAD), it refrains from touching
> them.
>
> So the way to go forward is for you to make sure that you do not
> have such local changes in the repository that your "pull" is trying
> to touch.  An easiest way would be to do
>
>         git checkout HEAD -- <paths>..

Thanks. That's an extra command. Is there any way to roll it up into
one command?

> before doing a "git pull" to clear the damage you caused manually
> with your "scp".

There's no damage. Its expected.

Jeff
