Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9856220A36
	for <e@80x24.org>; Tue,  7 Nov 2017 20:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933084AbdKGUx2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 15:53:28 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43474 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbdKGUx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 15:53:27 -0500
Received: by mail-pg0-f68.google.com with SMTP id s75so425610pgs.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 12:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MtL7fgxXmN9BOg4kc9uOl1WfFUBZ3aDf7QCR8zlidyQ=;
        b=S058EdrT4l4A4yDBbAfBqV42RjUNBk8ZhJeZ+BVC3MhAc1pRxmn1m2Tw32twAVR96O
         EewWCfGDujBXsFn07N+pbh/xNMKfaSOSKqZJ4DhsAbB++csrZr6MyQKJ5P9SsGlJBHkl
         Lp2/kWRxg/MC/+D1KrISmChhnXXun2yYM+Wmfo0YvoPAn+yTZwjYGv3Sbnlo+0fmXKjj
         aJFiftWeLHs7O/CpE00pYojSDXB478KQdaLq4R/qZlB4SJb9+HJc+aOa+NQzH0j2Grn5
         u5m1jf9EU6oMRvJ5stc0aP49q/4cjoCWJTeh0iCowdVJSKK5+XViEwIgM3QR0xxoaVc0
         5riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MtL7fgxXmN9BOg4kc9uOl1WfFUBZ3aDf7QCR8zlidyQ=;
        b=rdMvK8ztTcfFtl9AE/bKvf/Ptv41At7xSSuxEYz9k/9tSfweHJv/IR5qKKqJd/yqFB
         deHBn9drxWicpPqNyzJtgbH965b3hHGdz0EK22UC+c3OzXKPSNOjHmBv71LDkQpgJf3u
         bQtvQ0fzPj8+qKAtr8FkAyz7cN92uan9wmjei+iej80MlCf9DWOd4D8w8ghXpnwDqFW3
         8yJeFQ1rjeAMx6PR7WgZoGG0maOndcZBN7Nx2fLhFc/HWKlnPBkiK7VWxw4PcnuXI5Zn
         VGeRwZvthbTTKFc8WAEMvHgjYYQ7KpZXysJy+UwDu5V9vKMlhqBltnK1940/3raoBFRN
         KNcw==
X-Gm-Message-State: AJaThX4EHfKN6Cti3DNVagwll0kcGkkGGxagEXkoQbMR7pqad+NHmn6H
        q7Por/AZv/uqaMnSlkRKZJB2om5cWZpqJZVsDw4=
X-Google-Smtp-Source: ABhQp+SKCC6AQRzUyl+NUWXADTHMSPDBdtfS1r6tIW+xt90q9JWsr6zR37ewLNYzuYtMdIkKjgTAr5Za+iAhkd3JS3A=
X-Received: by 10.159.198.131 with SMTP id g3mr7536plo.337.1510088007191; Tue,
 07 Nov 2017 12:53:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.177.141 with HTTP; Tue, 7 Nov 2017 12:53:26 -0800 (PST)
In-Reply-To: <10901328af1e6e04e8c7c7b39977ec85f6c58142.1509870243.git.mhagger@alum.mit.edu>
References: <cover.1509870243.git.mhagger@alum.mit.edu> <10901328af1e6e04e8c7c7b39977ec85f6c58142.1509870243.git.mhagger@alum.mit.edu>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 7 Nov 2017 21:53:26 +0100
Message-ID: <CAN0heSpOpfCmf8k8kZz1L-1qb-5mDHMLbQYaLPKE=twOhgyi8A@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] ref_transaction_update(): die on disallowed flags
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 November 2017 at 09:42, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Callers shouldn't be passing disallowed flags into
> `ref_transaction_update()`. So instead of masking them off, treat it
> as a bug if any are set.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 62a7621025..7c1e206e08 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -940,7 +940,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
>                 return -1;
>         }
>
> -       flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
> +       if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
> +               BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
>
>         flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);

The masking out is for sanity, but also partly to squelch a
compiler-warning. Thomas reported [1] that dieing does not make the
warning go away, but that masking out does. Of course, avoiding warnings
is not the ultimate goal, and -Wnonnull is not part of DEVELOPER_CFLAGS.
Thomas reluctantly suggested that one could do your check and then do
the masking...

Maybe it would be worth a note in the commit message. But blaming these
lines quickly leads to c788c54cd (refs: strip out not allowed flags from
ref_transaction_update, 2017-09-12), which describes this already. OTOH,
since the warning does not hit these lines, but a bit below, maybe it's
even worth a comment in the code.

I'm not saying we should sprinkle comments for each warning we hit...
Anyway, those were the thoughts than ran through my mind.

[1] https://public-inbox.org/git/20170924204541.GA2853@hank/
