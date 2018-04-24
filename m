Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE271F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755976AbeDXFhi (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:37:38 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:42719 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755905AbeDXFhh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:37:37 -0400
Received: by mail-qt0-f171.google.com with SMTP id c2-v6so2855618qtn.9
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BTVR82rq24j8FnMpdyn1o295CKS3A8LbEb80rWsFKl8=;
        b=o0wfN5iALvF7nk0pZWXZGVgmGypIgWZoDDVMKPPyCDf0YTQ2RFIlZdAUFPkmDdQTqp
         h77OPb6gdRtB5CBWig19GIzGWXdzi+PzSP1ErjpbYA+iZK6J+iFkgG3q9C4rOZ5jt0cl
         /8r8zja1QuiOiLZVM6FLelTGz2TGp0X5O5X16d0cAfDUpGgUf08KIXf5GOcWPjMXAold
         03ljIyqwLhSOSgALPHdE0+12z7ElZrnEojs6vnyEU8Csejn28lsK9qFoDC9hsAyf5Q2F
         PbDtpVjIJSDwwq+LnFglHQE04lXMbvCO+zL+24CfYBCjIGCYaL8AUCmIIr6obBP9fFWW
         WtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BTVR82rq24j8FnMpdyn1o295CKS3A8LbEb80rWsFKl8=;
        b=pd9h4JoXLRkT+xPGzlT5ffKnua70rJ2ka/nsvhwf0oIvDju01pFuyIfpRCF2qSNU7R
         fG3CMKs6YMOXQMHb5Litgv+hnkJmEdT3wEFcJgHls+rhieVR/Ap2A3pzBvTzcAjjs9EM
         uhGuJ8Ta67MqsFnAz2PQEkt0HNEcBZ5csKYGTrUHleO4H2xt/nyURu4Mt4hp6ChjKQor
         WpL7O9UDZGl8AWO7XyuMfUmAAQqsYsJk1B7XPrDwdamlw0yZJNcLC2OUnJtzOVwMYis5
         grJ4O8gvgwHmmQvNLGOmCaNNCSfVka59mYIYFFNZ/AgGW+frCzA3ga+mUZ0cJpgUugyN
         ft3A==
X-Gm-Message-State: ALQs6tCC/1nZOc6OLvaiH9xxwLlwGvM37qFDxitLsOCa2nqGDSo2Ij+X
        pt1erlDIZOxXxzEwqAaRm0K7vAaEYj/25BoC2yM=
X-Google-Smtp-Source: AB8JxZqqV244wUvn49C0BahYVGjiiI9QpCYjH1OUeg6/08d8xQTJp1A10Kr0jGx9+V9Ds5irFU42a8CTjqcquklTTbM=
X-Received: by 2002:ac8:3267:: with SMTP id y36-v6mr26571883qta.25.1524548256700;
 Mon, 23 Apr 2018 22:37:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 23 Apr 2018 22:37:36 -0700 (PDT)
In-Reply-To: <23ea226b544e9e5fcdbbcda3adb5982e2cae2123.1524545768.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local> <cover.1524545768.git.me@ttaylorr.com>
 <23ea226b544e9e5fcdbbcda3adb5982e2cae2123.1524545768.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 24 Apr 2018 01:37:36 -0400
X-Google-Sender-Auth: nuu3zQdInW-6_DSPiUVqJOmkcXM
Message-ID: <CAPig+cTep_WuRy3qVHpZUMstc9Tgt9gFW=F8_0E8CZQQ8Jyq7g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] contrib/git-jump/git-jump: jump to match column in
 addition to line
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 1:07 AM, Taylor Blau <me@ttaylorr.com> wrote:
> Take advantage of 'git-grep(1)''s new option, '--column-number' in order
> to teach Peff's 'git-jump' script how to jump to the correct column for
> any given match.
>
> 'git-grep(1)''s output is in the correct format for Vim's jump list, so
> no additional cleanup is necessary.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  contrib/git-jump/git-jump | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Based upon =C3=86var review[1], I was expecting to see git-jump/README
modified by this patch, as well. Perhaps you overlooked or forgot
about that review comment, or perhaps you disagreed with it?

[1]: https://public-inbox.org/git/874lk2e4he.fsf@evledraar.gmail.com/

> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index 80ab0590bc..8bc57ea0f8 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -52,7 +52,7 @@ mode_merge() {
>  # editor shows them to us in the status bar.
>  mode_grep() {
>         cmd=3D$(git config jump.grepCmd)
> -       test -n "$cmd" || cmd=3D"git grep -n"
> +       test -n "$cmd" || cmd=3D"git grep -n --column-number"
>         $cmd "$@" |
>         perl -pe '
>         s/[ \t]+/ /g;
> --
> 2.17.0
