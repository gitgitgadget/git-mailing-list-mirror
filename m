Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0584B20248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfCEXnA (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:43:00 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40527 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfCEXnA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:43:00 -0500
Received: by mail-ed1-f48.google.com with SMTP id 10so8753469eds.7
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 15:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4UubowK0QTbsSWOPiLxA+tGbR0PpQ6KhbFeKXZUoCps=;
        b=n8M2xS4hP0EaNPCki9lbiE+jywFkkNhj2nkhBPYF5oN7Y9GuEJPNoJGPArRN2C9frB
         lsSxMdJCOpj6htkh+rnTl0bETWct7zHCDFOsbnsZH/vQg/0DTSqGdT0F8GvEBacfSII2
         GGE0qyxi2B5mg1FvEdtDKBXefuJ6cuB70LHS1MaJ7dwDlo/PGcPnQ91zuqFQh1nTkfu6
         uFegbY6gRkxPI0Qlbz8N9OegTlpu0yM1RGDSiqrl/xvGpPPTCoqgwlFoRwS8FXtuZC5n
         u+MHTqlAdeI2ujPxrNZuOi8f2Q41zUuLikyfdpEJFl/Ejrikz0Z0D6RCOVhRsWMJaWT6
         FJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4UubowK0QTbsSWOPiLxA+tGbR0PpQ6KhbFeKXZUoCps=;
        b=LEtT5xdDYCH51Bp2cB0jFc9Aq1kzdEsMmiPsR9k7nAUDmRHGY4GToSz9tGOemngpiN
         nyQzxagNaQt71YXrAHFSeq0gbikshbkSgjehnV+33tynA07x7I4nY7u7gE4ax8V+DMRP
         0+i8DEkwncSny5Tb0sMPH/7WJq9Z+M0uOn+6hy7avcG60Bs47dXg636UdakPNNeV9egs
         fZElRS6jyLFCiaX2+YmI8iM4ItgXtVFihKlNy7OExuuvF7V+BrPpjqav4jbhLM4CWHXd
         ZPG+SCjlF6im+jt4C7oB0onAkMVqr/otk6oYuxdSMI4hRR6UGJMvYeb8+7rLRU7vYI4K
         VjiQ==
X-Gm-Message-State: APjAAAX2R9kKw697c2xc1nVJnNoxjvviIZNyl7/lUqtubXV++mEaLLff
        K5/b0Xy1khHi4UFL5YIDu3allZ6eRL4YcXdkuIo=
X-Google-Smtp-Source: APXvYqxBdN2JDyZukzSr+IlPGpSvUNeqoe9MloWox3NnbzIuMsSF/ALWc3oOXzSKfWchWWZYg6LMvszT92OJRsaau88=
X-Received: by 2002:a50:94ea:: with SMTP id t39mr21558705eda.262.1551829378904;
 Tue, 05 Mar 2019 15:42:58 -0800 (PST)
MIME-Version: 1.0
References: <62307e7b.399f4.169479a611e.Coremail.wuzhouhui14@mails.ucas.ac.cn> <xmqq8sxvvzvg.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sxvvzvg.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Date:   Tue, 5 Mar 2019 23:42:22 +0000
Message-ID: <CACUQV5_VCYdBoi=Vz97KVSWipzf+tbi2wrkY1U2h4i78FxVY-w@mail.gmail.com>
Subject: Re: Git log print commits between a revision range (inclusive)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Junio mentioned, "A..B" means all commits reachable from B except those
reachable from A. Understanding this is just a way to say "B --not A" is
important to know you can take advantage of:

`--boundary`
    Output excluded boundary commits. Boundary commits are prefixed with -.

In other words, git log --boundary <older hash>..<newer hash> should give y=
ou
exactly what you asked with the small caveat it marks excluded commits
differently.


Cheers,
Rafael Ascens=C3=A3o
