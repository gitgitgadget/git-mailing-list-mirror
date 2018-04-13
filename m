Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666D31F404
	for <e@80x24.org>; Fri, 13 Apr 2018 18:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeDMS5i (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 14:57:38 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44147 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeDMS5h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 14:57:37 -0400
Received: by mail-qk0-f193.google.com with SMTP id n139so10167746qke.11
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PB764+GyYqR7U8NHaUq0XSYEg2YmN/qV462jqYYlBtY=;
        b=esXZ2dOmc5KS5bB4h26ETW7EqBgnNE0IJG7YXxxCm/uLHaEicPcGHfDZYJSL0q9zeQ
         X+FSRlfpnRfjs+5KW/ts+TTE/Z0Xf0OzxLz/sjtK/BGY3yAHQ1ZfbGQbF59b2zHLxYH8
         c7kj/Z+hTH3DdifZtOfG9qDEN7jhmJCUxjK5L9ij3lz3w0pu1QVyP9pGjQKMsMD/Cxyo
         k2aYKfM/BiB/8N35k1hxPPVeXZbtvVR1VBu5xJhJJ2xDk5suPF4VWQBDVnwVAwnbv+4v
         KLuowvcZBwNrQaAOZ6GWsEbOZo0pCoKl4uj/WQlT+235yFG66dNXi4h3XImVOhGSe84/
         +G2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PB764+GyYqR7U8NHaUq0XSYEg2YmN/qV462jqYYlBtY=;
        b=szbvhq6N0DXU0UQWNvDIYhSbbBAlbPAcCCZ5EV9GJJJPyBRez9d2rCu6VdcJ3G2X25
         hfowcuWJDWHl3PkBWyggFiX/4zV1D55V6uem8A3m17aTkhVjgG1xK+U7OBAqF7xjFY2z
         RFy09nOz5+wRwlPj7l8J0pUHLIG+0FlGDqB9jfwJ3CXWoOkYXjxMr354lHq1ofemkY7n
         UZFtlQUpIiwpmFBkV1UbW+rwMOqGGvr4fbfLZ9IVL1SNR0Mg2CQeSLSqJNDehcpJ0qWz
         Cuvgz+NGa09mQ2JxDaj5rzzDLtPku+N65O9k5LSs1Z+iGsCGsVDBdq0xvGWKT0fDVzDi
         qOng==
X-Gm-Message-State: ALQs6tBVHguCH1IoKFi5VDIoTZevrZhHxwPl9rGBSsftfUAkDO6LqcH9
        d0DeLwA3OyY86Hi1EXKb5JpN/QwEEB2K2zJjdJ0=
X-Google-Smtp-Source: AIpwx4/UlfUuhOvknv7rgP2od5mO5V2h8vFDT+R+ijfp2uEZK8NUPJuOQRUa4iWhmwbDm7oB+1uEWTcaAFEzPhlYgBQ=
X-Received: by 10.55.43.18 with SMTP id r18mr5682601qkh.152.1523645856497;
 Fri, 13 Apr 2018 11:57:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 13 Apr 2018 11:57:36 -0700 (PDT)
In-Reply-To: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Apr 2018 14:57:36 -0400
X-Google-Sender-Auth: ImgMD98JteCV1j6NT9er0Jl-JII
Message-ID: <CAPig+cREYENM7Y8SqtG2ket9+oJ6w0OU1_Qa8f-+O_yDyH=Aww@mail.gmail.com>
Subject: Re: [PATCH] Deprecate support for .git/info/grafts
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 13, 2018 at 7:11 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The grafts feature was a convenient way to "stich together" ancient
> history to the fresh start of linux.git.
> [...]
> The much younger feature implemented as `git replace` set out to remedy
> those limitations and dangerous bugs.
>
> Seeing as `git replace` is pretty mature by now, it is time to deprecate
> support for the graft file, and to retire it eventually.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  advice.c                  | 2 ++
>  advice.h                  | 1 +
>  commit.c                  | 9 +++++++++
>  t/t6001-rev-list-graft.sh | 9 +++++++++
>  4 files changed, 21 insertions(+)

Perhaps, as part of this deprecation, the example in
Documentation/git-filter-branch.txt should be updated to suggest
git-replace instead of .git/info/grafts.

Maybe, also, Documentation/shallow.txt should talk about replace-refs
rather than .git/info/grafts.
