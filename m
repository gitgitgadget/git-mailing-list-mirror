Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B521F45F
	for <e@80x24.org>; Wed,  8 May 2019 18:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfEHSCx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 14:02:53 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41393 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfEHSCx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 14:02:53 -0400
Received: by mail-ua1-f66.google.com with SMTP id s30so7709398uas.8
        for <git@vger.kernel.org>; Wed, 08 May 2019 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWUeVaDBIdhy3sZeuyZwMtO3mtmkTWHrJIswRLPsCq0=;
        b=q+VzG3CSlrU8siAfFW3v2hePZdHo3VaX0TyyKfup328xqgpbThHibKwwIlRK2+RhsX
         w2QW2TDCjWrw2JxvxubVIaNTWjNmFyyySi9Y/TaLPHBV5jqUAZsYmTE4azMFV7TDsjuF
         4rIJRx2t1N3cQZvwx4gCyaCVDLa7Ee4sDMX8xASKVqTg0QUBiFhODxjlsvzedLV4B7TK
         xK4L5bMQWjfQUDZsRJGV1csDCBtmvSDTdyEKYHjUrNVjXe1ertAXj9e7xuC8cdYbaPjb
         K9nVFXmzFfGCuO6PY3vaC0sub2temE1fySPWTU6w8TwGZ8iNs0b2PVRF4/FbFBMK9EgY
         wa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWUeVaDBIdhy3sZeuyZwMtO3mtmkTWHrJIswRLPsCq0=;
        b=T8rtq16wbL55+k1jy7YIvkUV/N7SRmOtxVTmnfzcJbtbVnH01cLJPlqRbRSWQeOU7S
         twpUvlwLE7Y/oln4aJtkBVtveEY3Gp1sqloY4k1iObI4hEnCE7eizIVtN5HfO7BOTS5+
         NAPZjIbED/hNP+yo2qv0AoVNiJ6QbHcqd/du+Qo1Rxp84kEq+t7RybHALAxZ39wb2us4
         3/eaNSsKSiakU7YaepyRidNONDlbi+hoanixpIVXeLTQmRnJVOvsZlBKkUUyzHhS+KCF
         Ym/tWEQYuCPNJAfOV9DsEkwTOLi9mJJVpeRmYUCbDesb4OccF1AiVFBzUKGOkZQ9+lNV
         LrWA==
X-Gm-Message-State: APjAAAUviOhzEXOZFtB1PCWk13rr0iINIfJMsAyPFDj6mFX0CLmatSaN
        SlK9rSvFqpF/hBnF/2RiIhXj/kvsbT2XtC47NHw=
X-Google-Smtp-Source: APXvYqwgHVQsq9ziyfLMUc/VE6R+D2Va4m8FrU6u912uRpeSK3yvRmDlkRfYSmA28oJcqftjUZ47ZyhUAB3EexZF1ok=
X-Received: by 2002:ab0:7087:: with SMTP id m7mr15175868ual.87.1557338572374;
 Wed, 08 May 2019 11:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 May 2019 11:02:41 -0700
Message-ID: <CABPp-BH5jjyQFXoksajA6dn307LvWM1m6kmtE5O4HXtgtZ6r5g@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2019, #01; Thu, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 8, 2019 at 10:23 AM Junio C Hamano <gitster@pobox.com> wrote:

> * en/unicode-in-refnames (2019-04-26) 1 commit
>  - Honor core.precomposeUnicode in more places
>
>  The names of the refs stored as filesystem entities may become
>  different from what the end-user expects, just like files in the
>  working tree gets "renamed", on a filesystem like HFS+.  Work it
>  around by paying attemption to the core.precomposeUnicode
>  configuration.
>
>  Looked sensible.  Ready for next?

I believe so.  en/unicode-in-refnames represents v2; the last "What's
cooking?" email went out with v1 and I responded that a small commit
message cleanup was needed as per Torsten's review, but that was the
only issue I was aware of.

However, I think your summary of this topic still needs some minor
wording/spelling corrections; here's your summary with my suggested
revisions:

On a filesystem like HFS+, the names of the refs stored as filesystem
entities may become different from what the end-user expects, just
like files in the working tree get "renamed".  Work around the
mismatch by paying attention to the core.precomposeUnicode
configuration.
