Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0989F1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 07:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfARHLa (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 02:11:30 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42759 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfARHLa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 02:11:30 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so10730595lja.9
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 23:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4u8Ns5fbH/NPkvsIvcJ7zVEg9KrkLcRIyh45B/uzaFU=;
        b=OIXT2ZSQ4TS4/fCJBphqct0phhoBMSEFovE+GAyMl1XkbZogffoNvrZq1US9sx/epJ
         8GjfE3TGdsAuJ/02OFBTJMMZlosoFXpnAFL5YSNp/MywZPucAzjLUBB7/BH8hwsh4dGs
         Pwnfvh7lV4Ua5PY6Mbxisq2hBnUfpMwt1TFei6kC0l/fjTqebuuh028MqL2qtHMGpTrD
         MGBOpw9DY3DaSGRtDpfzCTvTqHbtAMcp7SZYOHKYGEbskvO55xi2AnD+yjAK8hhUwaF4
         9dkMeI9RkyTMtx3Uh4WlFP7XAAKYCxz7vXPBaWhtSjPIRHe81zDqNjL9Xzil/PVWgQfV
         sEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4u8Ns5fbH/NPkvsIvcJ7zVEg9KrkLcRIyh45B/uzaFU=;
        b=kzt+I/4uKC2/o6h8stgog/4t3tnPzw8D/iaW0cNXWsYuqjqkcxwq31rT/uYhVb87gM
         9wuJvnCJMY6CqEWQ0ctyoBR74f6yE+JfwSFoy6JqRUXZiZcsDcJj3Hf+mxLLMXeFLfgt
         sBIxpRjE6BSLcvc/0ee6lY23XxyNjlx2dagtlekugyKJrgBEAflSa98GeugWblg40JCu
         z5H6c8Kb3HvEu1Hbwi3mK5oMgw7dl7Is69KbRdlvRxRQD+GH7eeTA7bZ0jYCCFOJBO5x
         RqsPy4e42U/LjhGeDpit/7Sg0pUT9XCQROH+mY8XweL7N+W9U4Q/6yeXpoPkIJJHdjMu
         vwhg==
X-Gm-Message-State: AJcUukfmzfnLL26tpBNRcA22V/bDYmXhKkMERH22rd+y6wZ7rvkdl3/i
        fBpnP7z5r4r+QFLYoFf/QR4hW9/xnEk28+iGcXP8F5UT
X-Google-Smtp-Source: ALg8bN70WibcnTE6jlWj1lnQ9nh50TgiUBwuWrZ05rsQqRbqGAW2XHmrCjFghdIVcPa594g8ptdQYV1KBXvuBNqI478=
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr10984583ljd.137.1547795487945;
 Thu, 17 Jan 2019 23:11:27 -0800 (PST)
MIME-Version: 1.0
References: <20190118010918.43705-1-brandon1024.br@gmail.com>
In-Reply-To: <20190118010918.43705-1-brandon1024.br@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 18 Jan 2019 08:11:16 +0100
Message-ID: <CAN0heSrE3mOnjyrzw76Gp6wBuq62wgM6jBV1u+vn3b6ySm0EDQ@mail.gmail.com>
Subject: Re: [PATCH] commit-tree: add missing --gpg-sign flag
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Fri, 18 Jan 2019 at 02:12, Brandon Richardson
<brandon1024.br@gmail.com> wrote:
>
> Add --gpg-sign option in commit-tree, which was documented, but not
> implemented, in 55ca3f99ae.
>
> Signed-off-by: Brandon Richardson <brandon1024.br@gmail.com>
> ---

Thank you for an updated version!

>  builtin/commit-tree.c    | 8 +++++++-
>  t/t7510-signed-commit.sh | 4 +++-

Ah, a test, nice. :-)

> -               if (skip_prefix(arg, "-S", &sign_commit))
> +               if(!strcmp(arg, "--gpg-sign")) {
> +                   skip_prefix(arg, "--gpg-sign", &sign_commit);

I personally find this a bit convoluted, compared to just assigning "".
Maybe there are reasons for doing it this way that I don't see?

> +                   continue;
> +               }
> +
> +               if (skip_prefix(arg, "-S", &sign_commit) ||
> +                       skip_prefix(arg, "--gpg-sign=", &sign_commit))
>                         continue;

Looks good.

> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -51,7 +51,9 @@ test_expect_success GPG 'create signed commits' '
>         # commit.gpgsign is still on but this must not be signed
>         git tag ninth-unsigned $(echo 9 | git commit-tree HEAD^{tree}) &&
>         # explicit -S of course must sign.
> -       git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree})
> +       git tag tenth-signed $(echo 10 | git commit-tree -S HEAD^{tree})
> +       # --gpg-sign must sign.
> +       git tag eleventh-signed $(echo 11 | git commit-tree --gpg-sign HEAD^{tree})
>  '

Thanks for providing a test, and thanks for fixing the "9"/"10"
copy-paste error. (You might want to remark "Fix a 9/10 typo while we're
here." in the commit message, especially since that line requires
editing anyway, see next paragraph.)

All of the commands above are suffixed with "&&" which means that the
shell only keeps executing as long as the commands succeed. If any of
those 20-30 commands fails, the shell will jump out of the &&-chain and
land ... at this line you're adding. If that one succeeds, the test will
be reported as succeeding. So please add a "&&" to the "10" line.

All of that said ... if I add the missing "&&" and run your test on the
*old* implementation, it still succeeds. The reason is that I grepped
for the "best" place to put this, and directed you to a part of the test
suite where it might be a bit too easy to copy existing code and end
up with something non-ideal. Sorry about that. :-(

What happens is that git commit-tree reports "fatal: Not a valid object
name --gpg-sign", then we go on to happily execute `git tag
eleventh-signed` where we've just substituted the empty string produced
by git commit-tree. The verifications will succeed, because there's
already a signature there... (BTW, the verifications happen further
down, so you'll want to add "eleventh-signed" to the list of tags
there.)

One way of making the test more robust might be to add a brand new
commit, similar to how it's done earlier in the test.

It's not your fault that you fell into this trap. If you want to look
into making this more robust -- and try running the test before and after
your fix -- great! If you feel it's out of your comfort zone or interest
range, just let me know and I could try to take it from here.

>  test_expect_success GPG 'verify and show signatures' '

BTW, here's that test where the signatures are verified.

Martin
