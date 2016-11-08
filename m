Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5052B2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 23:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbcKHXQj (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 18:16:39 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36396 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbcKHXQi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 18:16:38 -0500
Received: by mail-yw0-f196.google.com with SMTP id r204so7567407ywb.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 15:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rO3ffYK7ZdroIA/xbo1KNCsriTi3rWwVbLaMIwlgW+E=;
        b=V7LSYJCnsg2qTB2udyqj5Kp1X2dehADTEN8AB3h2zdLdeSNFQL84pUhWgsKCfZOqie
         sw7xZxpAgwlimKsjiAJ+QrrbGiOnBjw5QJGC6ccQDrdiTYjZdOTIsCCdaMSGdsgKbkYt
         S/XRQGrkjktRa9JVUsAEqcxIbLYr8YkN/CeN0OuZijziV8YdiHjcNpsrt7ha5ITBtTSD
         /5ZkbhSH+u4OtUCSkStzc47QOsaqaTSkqtPYVNYHsugOxQLsekaqxzW6poKF0JfhUVIL
         ZgAJl7DNeCc7Yg2QSj0vUN79/jY32UfwhC2AIGqk5o2+c7ax+S5h6Cf+oA2i7sZfPcjM
         u32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rO3ffYK7ZdroIA/xbo1KNCsriTi3rWwVbLaMIwlgW+E=;
        b=Q3s5wL7pVgmhU95F/ako/dOnrMRXYtnR9Cyp2Yf2fa+A+DRKy11aoE/c0arXKK9uD8
         yOnNo+in/aiO2zCrsoqyeP2piEWOpZhoarefoVf7EA4VFVKRNITHlEG4MO3fxMBCN2AQ
         +E3tMlWQ+/5MQA96AKTyJDZdcUUd0JEYeMPVKoWl0Z1H6NxRc84HqE0aAIx/GT1rReRn
         qDNICVaotHcF7k5yCe0wQrFianT8WmU9mEzBoYHrPjX+k2rxAxRqqVHHvMugSk6M53Sb
         W9+P6RJ6jq5sFcZ1kb9wUKUYvwk272J6NlzotqyYlasCV6wWB5GszstIoxfLDTHcXnvR
         mZJw==
X-Gm-Message-State: ABUngvcUkylud3MIDw4fLFTByZjh+lcRIrpMfYSjiHypxcNQOWpBrq5wRva46xnmKxG5X6WqJCON+1D2wwYMXQ==
X-Received: by 10.129.74.65 with SMTP id x62mr14145010ywa.59.1478646997627;
 Tue, 08 Nov 2016 15:16:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 15:16:17 -0800 (PST)
In-Reply-To: <20161108201211.25213-3-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-3-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 15:16:17 -0800
Message-ID: <CA+P7+xqVAEuc12eQJ7-Et0CtXc12t5zDUg3Qsh3214cTh_brbA@mail.gmail.com>
Subject: Re: [PATCH v7 02/17] ref-filter: include reference to 'used_atom'
 within 'atom_value'
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> Ensure that each 'atom_value' has a reference to its corresponding
> 'used_atom'. This let's us use values within 'used_atom' in the
> 'handler' function.
>
> Hence we can get the %(align) atom's parameters directly from the
> 'used_atom' therefore removing the necessity of passing %(align) atom's
> parameters to 'atom_value'.
>
> This also acts as a preparatory patch for the upcoming patch where we
> introduce %(if:equals=) and %(if:notequals=).
>

Makes sense.

> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 8c183a0..8392303 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -230,11 +230,9 @@ struct ref_formatting_state {
>
>  struct atom_value {
>         const char *s;
> -       union {
> -               struct align align;
> -       } u;
>         void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
>         unsigned long ul; /* used for sorting when not FIELD_STR */
> +       struct used_atom *atom;
>  };
>
>  /*
> @@ -370,7 +368,7 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
>         push_stack_element(&state->stack);
>         new = state->stack;
>         new->at_end = end_align_handler;
> -       new->at_end_data = &atomv->u.align;
> +       new->at_end_data = &atomv->atom->u.align;

At first, this confused me. I was like "we dropped the union, why are
we still referencing it. But I realized that the "used_atom" struct
actually contains the same union and we were copying it.

Ok, so this looks good.

Thanks,
Jake

>  }
>
>  static void if_then_else_handler(struct ref_formatting_stack **stack)
> @@ -1069,6 +1067,7 @@ static void populate_value(struct ref_array_item *ref)
>                 struct branch *branch = NULL;
>
>                 v->handler = append_atom;
> +               v->atom = atom;
>
>                 if (*name == '*') {
>                         deref = 1;
> @@ -1133,7 +1132,6 @@ static void populate_value(struct ref_array_item *ref)
>                                 v->s = " ";
>                         continue;
>                 } else if (starts_with(name, "align")) {
> -                       v->u.align = atom->u.align;
>                         v->handler = align_atom_handler;
>                         continue;
>                 } else if (!strcmp(name, "end")) {
> --
> 2.10.2
>
