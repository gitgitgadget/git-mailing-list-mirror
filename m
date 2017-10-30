Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3379B202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 18:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932600AbdJ3S6Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 14:58:16 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:50039 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932490AbdJ3S6P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 14:58:15 -0400
Received: by mail-qk0-f194.google.com with SMTP id q83so17471969qke.6
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=56q7m7HeOYXz/sGIbRqewD6dtxow/lc2KdbdesWbBGQ=;
        b=mO0dr6nhfR3c/KBcWLJj3jEg7r0jUO5apfvJ60YRaO6/68m4j2zno6sxZcvR7J3E0/
         xdTQoODgTd3Mlfi1gz/kL3KCESIaO7MZIQXKAP9dYIK7TyrWh/rtE7rN+y48S0fSpTn2
         qXS8XHBklJdFLzPQc4GMVdvIWeO2tlE0jtUdHB+NLOQoiTXMrerN693A1eZJ3QZTPgn+
         ZbFaMtBZ4x4RQCp3XEkNTPKzG+TffBaJtYASKcQyX5KebXKy0rHmtVBv+q9eCLlVQJvI
         KP0dPNIBT1NSHAeGZHlpRHs6NXjWMzCjX0+tgK+addrj1zQB0fXsD1GrHzXaWBGlFmic
         IwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=56q7m7HeOYXz/sGIbRqewD6dtxow/lc2KdbdesWbBGQ=;
        b=URwFM5sA2ua1E743fJzlTSrTMd/CZOUkH9m/PsQS4YNXBbpfnFUxxvou2/vyfeAvCt
         OlxJbYRFlAhFmWhZXF6dsZBQ9SGpZvJnBR3H6/elHXPb67pq/C35aN1mbcWIBWmE9YdA
         KdxmCk434d+heUtymS08BNEGAq+1RHsxKDWT6mBR6w0nP6zzrTXjLEMen2FUzWrTI61v
         mUmsCNMFXogRMv9TBWCm7aV0AFtXZcQ+I08bWpTpHyNIJxWNdYHv3YxrYIShicWV0BkP
         MhP2Wibb5NnuvsVSSkqPaqo7zng0Myv/mS/qH8GKslOJQJGesjQrRVtsBoQMOd8EaOep
         acSQ==
X-Gm-Message-State: AMCzsaWQONT4y6lsraDkplpiLvGt0MAri5A1sLmIF4ry5gnwp3nKcGfp
        xlnNT1bqUT9CPF6j/4VUD19XQ75nKOaVk6Fm5KM=
X-Google-Smtp-Source: ABhQp+QRhxUmmO7cLNvLxp2wO1yYGEHyfGQdPLLZGBufkUFN4V87PC7HZhf+hyUIavgPKy4MjtAJwitNPAkAXcx+vLg=
X-Received: by 10.55.77.214 with SMTP id a205mr12849309qkb.196.1509389894976;
 Mon, 30 Oct 2017 11:58:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Mon, 30 Oct 2017 11:58:14 -0700 (PDT)
In-Reply-To: <436f0fb010709fe0d90460dc7bc1b3482237b192.1509382976.git.johannes.schindelin@gmx.de>
References: <cover.1509382976.git.johannes.schindelin@gmx.de> <436f0fb010709fe0d90460dc7bc1b3482237b192.1509382976.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Oct 2017 14:58:14 -0400
X-Google-Sender-Auth: jOvS3EuqGXutxMXRt2xWqBy1Kbc
Message-ID: <CAPig+cQs+6xCn=OR_Mw8vbEwEJ0c=sqnaEChOxuVw=kV4PQwsw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mingw: document the experimental standard handle redirection
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 30, 2017 at 1:10 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This feature is still highly experimental and has not even been
> contributed to the Git mailing list yet: the feature still needs to be
> battle-tested more.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> +`GIT_REDIRECT_STDIN`::
> +`GIT_REDIRECT_STDOUT`::
> +`GIT_REDIRECT_STDERR`::
> +       (EXPERIMENTAL) Windows-only: allow redirecting the standard
> +       input/output/error handles. This is particularly useful in
> +       multi-threaded applications where the canonical way to pass
> +       standard handles via `CreateProcess()` is not an option because
> +       it would require the handles to be marked inheritable (and
> +       consequently *every* spawned process would inherit them, possibly
> +       blocking regular Git operations). The primary intended use case
> +       is to use named pipes for communication.
> ++
> +Two special values are supported: `off` will simply close the
> +corresponding standard handle, and if `GIT_REDIRECT_STDERR` is
> +`2>&1`, standard error will be redirected to the same handle as
> +standard output.

Consistent with the Unixy special-case for '2>&1', I wonder if the
'off' case would be more intuitively stated as '>/dev/null' or just
'/dev/null'...
