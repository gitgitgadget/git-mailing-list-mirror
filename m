Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD1A1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 14:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeDQOEz (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 10:04:55 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:42910 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeDQOEw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 10:04:52 -0400
Received: by mail-qt0-f178.google.com with SMTP id j3so19005398qtn.9
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=269yzsA4gekdsbUjZ7CwLxeUs1CIIN9/zK37WlWFh2U=;
        b=QXbJPL5a/oQ95iULi9CuhntYtaI0RPRjHH8UKSN1iDNm3HfeMhzvjdm6HnTWUoWNQd
         QW+8ml2b/kFGFMtvd7bZdA8G2HQFzDrNT8ZZp3B7ZUpgKTQstNQm/PnoBttbLvusqLIe
         lcxiss1mQzAxGwziz9x3E5bqvIapFWob5WeDYpRyWE8huAKbsQ7f0LUqvy+7IfWKmQ2P
         1mqtivpvMHhBij1KQLbYLMNeIbeDVoXzT2R5QnAASLBJlnHLZhRw4G7DHwA3Oo/xOsrK
         VDsJc9657IhUSqEdZQVodzgzbt2FL4hShdGKJjrmuEM4ptRD6A45p85+pkivQ2kKr+YP
         aj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=269yzsA4gekdsbUjZ7CwLxeUs1CIIN9/zK37WlWFh2U=;
        b=Z9xv8R6vQuQ2NHHe89vHOoRerJbCjgptPNqrD4VtbqbCbpVefZpA+ofhLmnurv1mtU
         nBG19TUXLMMwa//LeaRI+XVltIlTbbBIJ8dO+Ti2UiEzWuqSn0C+zusNfcRnbxvygmVi
         5DsRr/D7fZSjvuFw/nmbxTkC3CXGEED3VtqanoLnL2l+/Nx5WN/PnUm7cwtlJORHodVE
         6qRSnypSMsvWe4WMhgXA+kvZKNROPV4d7y+9dHX5q1R9K8KnibRcOajB+EPaIb160QZv
         jAmAE2B5BOHKxNj8TzBDaCIX/fQme9CEBSEIELI1PyBGhiM1Us8Ysqkk3Klq3qgj7hw7
         vbKQ==
X-Gm-Message-State: ALQs6tD/xcfM+KqPatDW92VazEXQtvZGwBAjhaUJ0Ix957ls3JUlCqcr
        AJmCMoyDRlcOcvnCKLEO61iOn8OEbOL+bg29d2IJzw==
X-Google-Smtp-Source: AIpwx4+Yq1wz6ZWptIKtQZHL/E//wJuxwU+G73A+eDAL0EDsqn/0u4Jk+8uZtD7UcCKDHTazlVtRx9G43SWzQ3YtaQg=
X-Received: by 10.200.42.37 with SMTP id k34mr2653790qtk.101.1523973891798;
 Tue, 17 Apr 2018 07:04:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 17 Apr 2018 07:04:51 -0700 (PDT)
In-Reply-To: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Apr 2018 10:04:51 -0400
X-Google-Sender-Auth: gOwAvSKnzf_sLelLLqcVU-ly_yU
Message-ID: <CAPig+cT2gRK0Giq1UBqSKv82JKqSg-c0-LjhXzGXa9fODW-i7w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 2:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * so/grossary-ancestor (2018-04-17) 1 commit
>  - glossary: substitute "ancestor" for "direct ancestor" in 'push' description.

s/grossary/glossary/
