Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9BB1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756222AbeDYSW3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:22:29 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:43903 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756098AbeDYSWM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:22:12 -0400
Received: by mail-qk0-f171.google.com with SMTP id h19so4243371qkj.10
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=An6o4qgyvclu29ZVtMjuTtRaSJHDy/nGU6SddTuwLl0=;
        b=ODHGXRYDsx17ZPl79A94KoqFzw1EEa8zKilgQh4gQP/8MBv8I+LoJtvIsovsZLjaYB
         qpHekacYS4XjgHPA+Jd6pzm4XwM0o5N11mRu3XYj1s+s8HprEaPzI4l01Y29VvmzzK6k
         L51kRW6lTxAww2UXRjjN0JX7oxmpv+Zr6fcVIBoh81zdGwspxxcf+911w14rgxDBfmSs
         n+Yk6mYsVMNBL320I8fhiDBSGNhBvyETUvLDfMuzJUqsjHG2JBfQN8PFLs6vr0w9uw1p
         umkRlmgjuqWh70OfGFicK7r9eJIvrNqz8xraJbAE0fZfFXGrWnNRa8ynclzIdxkEMGO6
         OWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=An6o4qgyvclu29ZVtMjuTtRaSJHDy/nGU6SddTuwLl0=;
        b=KKwyHI3oxvybKXBwJlUUpSxo1b0c2amzf9AT4Bdpd7h5OVYVTvmp0r9CD9kl8Jzy9P
         JGld7u8e0aU8NmjzaehdgD+nVsQ9nrGMGJNjLcTFYS7WjzZw9CWY3zHjod4h/CbTHfqY
         GYEioz84qikgyuC1lMfCIsYyNReqsP06JVL3MnaoMxH8Hy5aggZEjD9xhDWKKWu4W2Gj
         QctuOldkXOGs/TmgbX7J2ev7D+z06NlUscBTFUWywLgeUzN/EyUE5lQyEGj238PkDGTI
         c0NjVb4GHucTl3t7TWkCV4PtVSwFzTxtW5vlDVVvSzzZMDDr+Sa8xfDk630ZXdeSJwAb
         gFhA==
X-Gm-Message-State: ALQs6tAfL/AgI/tnjrX4noDtCqUuRweXxJhFCb9gPhRUlAz4n13BfF1O
        t+6Lur6VlrS81pSA3SY2C+xkFBBS3boQ4cSpLLk=
X-Google-Smtp-Source: AB8JxZoQLCyyEryUTQfx40jH/vMIDmrZhKf/vwRTOnYU1IHKJgx6bEi8Mtd/Hcxkb74pbHzJcERhkYBz7HRMDBzLMjk=
X-Received: by 10.55.190.134 with SMTP id o128mr29201733qkf.141.1524680531321;
 Wed, 25 Apr 2018 11:22:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Wed, 25 Apr 2018 11:22:10 -0700 (PDT)
In-Reply-To: <20180425163107.10399-11-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com> <20180425163107.10399-1-pclouds@gmail.com>
 <20180425163107.10399-11-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Apr 2018 14:22:10 -0400
X-Google-Sender-Auth: ITNaZ2gbbdv4yqEWm0SJ2LxHyzM
Message-ID: <CAPig+cQEOxFz-0UAKHFYSzVqnxKdgVAmvV3FoJ8fT2SnWvRwLg@mail.gmail.com>
Subject: Re: [PATCH v4/wip 10/12] help: use command-list.txt for the source of guides
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 12:31 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> The help command currently hard codes the list of guides and their
> summary in C. Let's move this list to command-list.txt. This lets us
> extract summary lines from Documentation/git*.txt. This also
> potentially lets us lists guides in git.txt, but I'll leave that for

s/lists/list/

> now.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
