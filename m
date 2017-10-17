Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F000F20469
	for <e@80x24.org>; Tue, 17 Oct 2017 17:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759498AbdJQRmt (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 13:42:49 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:47616 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757860AbdJQRmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 13:42:47 -0400
Received: by mail-pg0-f68.google.com with SMTP id r25so1990313pgn.4
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LZ7RjTqMjzpGS2GOJSb/jYUyzhsk2ky4UUoX8SMRYHM=;
        b=A5rNq033O00RxULnGJ38fo0ny15iep+0eLaZiM3sSJJ95UQCwbVnh2Wq8+1f6EgcDM
         p79UusjP0s3jb1bDYkQYcC+kbdLqfce6fHb+4O9b+h3hH3KW1LzDD3d3uco+4CwI62Qh
         cMDHaZR2f4Vl8U7gUpas4wroI8lFNs7gFjNWDHLMGsfjpkS3JPBo1zd2JmSYibWm6+3U
         M6gLGKR9WyDV4zdenvr0mD7tU0KODZ+Fq4sWSwFH0PC2GhbzgAmT91glup60+8Q9geSD
         +nPtkgRF04Va9NtY+DBK/soES+YWaFqUeiO3kKbjnOmEIyKPUsxtLFkLHKHCLJKJB6/L
         Dk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LZ7RjTqMjzpGS2GOJSb/jYUyzhsk2ky4UUoX8SMRYHM=;
        b=QITZpu4dvgyZsWqR+IKephrzt/oFayohIIR0oY40e4pnA021H4iD2X118nJd61jS3W
         e34H1irT9kHRxheTU/5f0R1RxQwLLW4UWVk8j1Ig3RSYN39/VjinhwHYyMHJwep8p0qX
         kmkGE4XdmjMUzFhBfObv5PSH4wabMJ7Z/5zzETwNmn/6tW88hqQxEb/Yg8MaTeBdflz+
         pAQeTMvIAu/LTG/QWkvk7pbD35+G7HtpA4XOn3CAUxzjhQ6/oShG4KhFSndILSqmDR5g
         0NN/yGflNbbZVVqw7F7wHB/5DFB8CU6cfPujNjv1/zivu0TS8s2Vi7WTLzbPTQSBxiXD
         dCsw==
X-Gm-Message-State: AMCzsaWODpE7hVd1sG/lWKMDUz4jhUrHEZDWSF6QeXIcaPz93OMN9sI1
        c2FnsPVaJA4E6ojWz/qe1Tnye5up0vroiP2ON+wjYY5F
X-Google-Smtp-Source: AOwi7QBFZWWhTyCR6KcdCoWmgWiU1ckzNxjS/I/LWSahmeuVnbv36EH//zCf/2QQHXKUKwAhSJiinbe+EujV0eOsL/E=
X-Received: by 10.84.178.164 with SMTP id z33mr12518744plb.333.1508262167108;
 Tue, 17 Oct 2017 10:42:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Tue, 17 Oct 2017 10:42:46 -0700 (PDT)
In-Reply-To: <f66f3fc2-8f51-03f5-c242-cb6d776af585@web.de>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de> <f66f3fc2-8f51-03f5-c242-cb6d776af585@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 17 Oct 2017 19:42:46 +0200
Message-ID: <CAN0heSpk+PPX7cAXT+jTZZ_LCAY=z6W4wxP38DqH89wST4PSWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ls-remote: use PARSE_OPT_NO_INTERNAL_HELP
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17 October 2017 at 17:39, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Since ba5f28bf79 (ls-remote: use parse-options api) git ls-remote -h
> without any other options has shown the short help text of the command
> instead of acting as the short equivalent of --heads.  Fix this
> regression by turning off internal handling of -h for repository setup,
> and option parsing, as well as the corresponding test in t0012.
>
> Reported-by: Thomas Rikl <trikl@online.de>
> Analyzed-by: Martin =C3=85gren <martin.agren@gmail.com>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/ls-remote.c  | 1 +
>  git.c                | 2 +-
>  t/t0012-help.sh      | 1 +
>  t/t5512-ls-remote.sh | 6 ++++++
>  4 files changed, 9 insertions(+), 1 deletion(-)

Documentation/gitcli.txt might need updating. It says that "[c]ommands
which have the enhanced option parser activated all understand ... -h".
Of course, it already was in an incorrect state, since it pretends like
no-one uses PARSE_OPT_NO_INTERNAL_HELP. Probably better to leave that
until it's clear in which direction "git ls-remote -h" should go.
