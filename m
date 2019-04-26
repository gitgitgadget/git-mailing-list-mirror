Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA1A1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 06:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfDZG6i (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 02:58:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53327 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfDZG6i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 02:58:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id 26so2387783wmj.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 23:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyCIgUu85tpACQAb5eL3nLHduejzDs9sHcg4sPxJtzM=;
        b=nf3w1W6jhoiiOjyvQ0Ky19g8Yiri02gkPca0LmiCo+q5cdMKmFKhceKUm42ncJ29Vr
         EsSW+AkH3s+dqnEGfAgmMAjFOyxv8aik4J+lcdzTiXr+S8GP1mHT6gZcTwDv5JfAcezM
         31ue5m8OVEauumqwLJFUOqJatDDI0cAXCjeham6vsfid+kpB7TnS+IIcyiOSjAcJC84V
         b7VzzGLqdhEcfUjErrgy+J+V8OZKY+4jdwZZMZqQx6sngcvLKPUnQNo/5H96/FkeZq8d
         fWBPmI2pUrfuRMmgJ5g7P+hw1xfSwsv+NG3nMGvMm/drQevm6jdAAitNv4gtDU+Y60V3
         aueg==
X-Gm-Message-State: APjAAAWdUmY/w6BsNkNX9b5yB5VzSVQwDFZoYAXTZ5GprUYV7N5gNxFL
        wln1RakTG0m9sjCKM+ynbqWZBnR2PsOvO0nC5zc=
X-Google-Smtp-Source: APXvYqwgpPuWXGGVTK2fPv1gkqqsuMMrFYsqn6loWgsxfnRcQBbjNUtRKe4RAGl0GrqP5Vo61rjWIbX7gCm4JAOlG7I=
X-Received: by 2002:a1c:a184:: with SMTP id k126mr6358091wme.71.1556261916702;
 Thu, 25 Apr 2019 23:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556226502.git.liu.denton@gmail.com> <c0c7171e3d523e5d4a0ac01810378447a38854da.1556226502.git.liu.denton@gmail.com>
 <CAPig+cTdJv9-M+zmp+Jo2bjOrkO3NgsguJ2xM+aXhf38OjjEEw@mail.gmail.com> <xmqqtvelv5t0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvelv5t0.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 26 Apr 2019 02:58:25 -0400
Message-ID: <CAPig+cQNF1LSwBO_hArCfPGdy-Y=mhMYbEO3eOY0Z6xNW9AJbw@mail.gmail.com>
Subject: Re: [PATCH 1/3] t2018: cleanup in current test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 10:50 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >     test_when_finished '
> >         git checkout branch1 &&
> >         test_might_fail git branch -D branch2
> >     ' &&
>
> Perhaps.  Be careful in choosing the quotes between sq and dq,
> though.

Yep, thanks for catching my mistake. Definitely want double-quote, not
single-quote.
