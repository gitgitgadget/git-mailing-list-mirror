Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F941F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 06:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfH0GX7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 02:23:59 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35690 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0GX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 02:23:58 -0400
Received: by mail-ua1-f68.google.com with SMTP id m8so3801469uap.2
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 23:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4imJVte7x4b4kRPOAfWO97O9s+P3HdmgMIMZ3JwM+Y=;
        b=iaphNZ3G07r+C4c7HecUCwXm2qeVmgLqp/8kTbV4HIj9WiN43KKqRoomweULqHsuWK
         u3/DohM2N3nWdQRXELB6f4Lsxez+C/rlns/9kkecUl+LMZvZpdbmRJPvgcKEfJDXYR8F
         wsqm4MrN2uX+89IZ8FFgjQpqddWEixBso9NmCWYpqsPg0ohoOUeDkD0QabD7xoUTrHax
         QvWvIiU46HLKdOwoZ+H4ck/E70YmjG+c1onfYqe/gfJHkzc7OeWvgHq8kt2a+TchTOIh
         N3OmLY8lPnUOPYutpRVPt4RdkJgZ+PqydQW/kmo+2791iXZxSccoJJNC2o+uRRtmPukF
         zzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4imJVte7x4b4kRPOAfWO97O9s+P3HdmgMIMZ3JwM+Y=;
        b=ILyRu04SpB7g0cJ8E60iaXppDgB2MYbOwtgyI5Pmk/tlh9qWc1QdJWQTfU/gWs0D9Z
         Z0VP+HPPLZhdHNRdeASZ8a5hNIt/blqQ4gdSKoNEX9eeGBgCsCJ3Bovuup3W4o8FLl12
         NmWZE6i6KwtYoUiMQc6TtOd1cJndlTmYghjwHfF31nc6mwti57ZjaC9xf64HR0Uv5DO0
         ouYK+s1c5kPYoAqkpXqQkmNECVpj2O9LU+uA2o6wxqZgIQCkbej9hG85huKsx9jB5/OV
         mxYnVb00BdIJCK80H220dV7jW0Z7E0x5juiiZ8m1fm215JbH/1rL/OrI9YZrqZQAl1tD
         CTSg==
X-Gm-Message-State: APjAAAURljV5jkYEjmAQo/BaYm74qy3ptAoolDVshmcntvusWGmWFxJQ
        qFi5VrKVjzkW9f5iChu0vY2frjmvpYNnKtOEQ1U=
X-Google-Smtp-Source: APXvYqx8fRVvYKjL4tmBWOLbed4jzm4hBEQQstA0kIgBiHd0PQIzpeRlR33pFvSBaVqrGkC+ugu9eb7ZbbRCLGbiRHg=
X-Received: by 2002:ab0:4261:: with SMTP id i88mr10404367uai.95.1566887037670;
 Mon, 26 Aug 2019 23:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com> <20190826235226.15386-1-newren@gmail.com>
 <20190826235226.15386-5-newren@gmail.com> <e7df2ce3-f772-54b5-4e81-70510a897352@gmail.com>
In-Reply-To: <e7df2ce3-f772-54b5-4e81-70510a897352@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Aug 2019 23:23:46 -0700
Message-ID: <CABPp-BEBVNERNBApmWTaR03qS2cHPwQ=yRe6aSesOFUsX-2qFA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] Recommend git-filter-repo instead of
 git-filter-branch in documentation
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 6:33 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/26/2019 7:52 PM, Elijah Newren wrote:

> > +WARNING
> > +-------
> > +'git filter-branch' has a litany of gotchas that can and will cause
> > +history to be rewritten incorrectly (in addition to abysmal
> > +performance).  These issues cannot be backward compatibly fixed and as
> > +such, its use is not recommended.  Please use an alternative history
> > +filtering tool such as 'git filter-repo'.  If you still need to use
> > +'git filter-branch', please carefully read the "Safety" section of
> > +https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/
>
> Is it possible to present this URL as a hyperlink with a succinct
> description? Maybe 'carefully read [the "Safety" section of this
> message on the Git mailing list](url).' (I'm using Markdown notation
> here as I don't know the equivalent for our docs.)

Looks like the syntax is
  URL[description]
e.g.
  https://public-inbox.org/git/CABPp-BEDOH-etc-etc-etc@mail.gmail.com[the
"Safety" section of yadda yadda]

I'll fix that up.
