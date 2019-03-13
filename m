Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371B520248
	for <e@80x24.org>; Wed, 13 Mar 2019 06:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfCMGnP (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 02:43:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33922 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfCMGnO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 02:43:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so82297wre.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 23:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7mCORJt+y3OcH7Br0z1I5JgHQnLBK9s+eiSNDfFb4w=;
        b=HOX84fKjcxnVeHPeHq+0oJ2CHIPL7468jPN5Z1ybtnG47NO2sGg7IRNheshx+bODcw
         FLSMKsoYtCX18i1V6TvrSenQTuGgTKAfBJs2vRQBRd1AkLrR2QVYm+948ClXD1dXvRiQ
         6vJLvgwyeeK2+NmaNyBXQsuI8VBOS5QmsaZsKKf0ndjbqqXc5SZvzLIaCSHMBfJIq10c
         cApZ22E2Z4ap+W/dzuMzt+dO8UvyQTR1GT2Ub9zrOwWqBZXlvrTJzZ/A5zjDwH3+7EDE
         ZSqzijiOgu8RZtUWzO2lc5NU1QLVEm+f19V/2qPUsF3hlRw+8ioIv+x7e4JDdiiSOSYk
         L7GA==
X-Gm-Message-State: APjAAAUfDoJsx7nq0eV7SLuJYNVPLT/frDYEEoFU7Zykd2LJoaKvzuqH
        sECKdmUS4jbbbs59dmfHVYNtkzOMBPwgqRiI4t4=
X-Google-Smtp-Source: APXvYqx7WwBKIIYsIls7gk6a1//ZQdyUYZfDV8neO6UI1Tqqf8AqmXsD6RSr/zoO4/z2/dsjFPL+NgCEmmxgN2j8MkU=
X-Received: by 2002:adf:9f54:: with SMTP id f20mr27105901wrg.88.1552459392969;
 Tue, 12 Mar 2019 23:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190306130446.2193-1-corentin.bompard@etu.univ-lyon1.fr>
 <20190306130446.2193-2-corentin.bompard@etu.univ-lyon1.fr>
 <86va0o9qsp.fsf@matthieu-moy.fr> <CAPig+cQEYDay9kTUpBepw6kN_PgpG4dRXeNf82Kty+E7piXeWg@mail.gmail.com>
 <8a8944a6-9559-74be-afee-e6af262412ab@gmail.com> <xmqq5zsnfrhk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zsnfrhk.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 Mar 2019 02:43:02 -0400
Message-ID: <CAPig+cTxH9_mDwMdiRui5Lx7cmwg0K2PT2Cvj4YTn2gCg8Mcmw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] doc: format pathnames and URLs as monospace.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Git List <git@vger.kernel.org>,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 10:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> Andrei Rybak <rybak.a.v@gmail.com> writes:
> > On 2019-03-12 16:48, Eric Sunshine wrote:
> >> * drop the full stop from the first line of the commit message
> >> * s/futur/future/ in the commit message
> >> * s/There are false/& positives/ in the commit message
> >> * s/both, It/both, it/
> >
> > * s/inconsistant/inconsistent/ in the first paragraph of the commit message.
>
> Here is what I have locally, with the above input, relative to what
> Matthieu reviewed.

The range-diff you presented looks good and addresses all the (minor)
issues raised.
