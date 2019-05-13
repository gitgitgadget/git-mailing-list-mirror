Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0064D1F461
	for <e@80x24.org>; Mon, 13 May 2019 22:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfEMWVD (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 18:21:03 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:32919 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfEMWVD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 18:21:03 -0400
Received: by mail-ua1-f45.google.com with SMTP id 49so5465723uas.0
        for <git@vger.kernel.org>; Mon, 13 May 2019 15:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ham2r4iRcMCI3uHbVlJx5UCg0YAK849m4ygOl+xg7SA=;
        b=cGqvlAhTc+Is9a0NiH5g55Kddg3ihB9eKS8sfaAFxS/qN/qiszgoxjhpRIprepVFwh
         yghVRHPEj1M9BdgUwYiIlWzZdkzmvNJkA5BFFnpoRKokA6i54+baJlP7GSBjngDNL4fV
         JXaQWFhgNL+S9bZuS7QC/Z4tpeACGvrJHhh6AJn+GCJv3HFODjpAH3F2c8z7ivHnsvVA
         /KDE5HGjf4JOzsWXEOKPibj7Pyos4cIgSweRu89aA5piF3AULIol3KiONMFNWaK5jrJS
         Ey3TsMnUChGPYR7nIFLxpj5kQiRZ/gH9R/5g8ACjZxdRKPTazPfOJaWL4IIHMbb2C+UX
         5K1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ham2r4iRcMCI3uHbVlJx5UCg0YAK849m4ygOl+xg7SA=;
        b=bHIlsThfxLjx6whYPMwC3+Fm3EuzK94Vq6ITl3kk5MAZP/rrFv5hjjWilvh9ybUk3T
         HGHWCiYjejNOewErg/LuqQGJDWyky2yO6R0IuvSoEvnjj0nWIP4a4X94spiwsHVVnBLM
         mQKOWLf8NLKLUj9BfWUTDzZ4RQvBX/htvijDwyUimGhp9OPzMCY6wqOcEEGgNz85yaR/
         ZDgNECXoAeWUaoGuw+uAF72uV3ELwH6c/8y8tl1oxuc3butEBEMK4NtXxW9AgsmtTi6k
         o4o2A5PjpINn4q0VxhTgPPb99BUp9DsEfE3bDY8IXaXJDdgjUsmflygLeLvzK5r3r0jd
         sxCA==
X-Gm-Message-State: APjAAAWcOc6vKxYBvXvLLti+03UYq2SS7cKkud6KkznnwvBuLQULeDtB
        Xr6l/3gLMpt6xNLyg7AKs6obFMJ3rnAMwi7NNhk=
X-Google-Smtp-Source: APXvYqyPix/bA4LVA7/rvF6v0AcwaCm5RLmrccW29RGCgLrCUZlc2Rr6cjIIb63rX5NbsahKbMUZprJYmQAGsxVx3Co=
X-Received: by 2002:ab0:5930:: with SMTP id n45mr3349868uad.87.1557786062410;
 Mon, 13 May 2019 15:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa7fqbahj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7fqbahj.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 May 2019 15:20:51 -0700
Message-ID: <CABPp-BGPrDfHjQoASFFbyt2v3Aa6vie5H5U2KOWUnu=_NEiPyA@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2019, #02; Tue, 14)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 12:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> * en/fast-export-encoding (2019-05-13) 5 commits
>  - fast-export: do automatic reencoding of commit messages only if requested
>  - fast-export: differentiate between explicitly utf-8 and implicitly utf-8
>  - fast-export: avoid stripping encoding header if we cannot reencode
>  - fast-import: support 'encoding' commit header
>  - t9350: fix encoding test to actually test reencoding
>
>  The "git fast-export/import" pair has been taught to handle commits
>  with log messages in encoding other than UTF-8 better.
>
>  Will merge to 'next'.
>  cf. <20190510205335.19968-1-newren@gmail.com>

I sent out a v4 this morning with Torsten's suggested YES|NO wording,
your suggestion of more aliases for "yes"/"no", and based on Dscho's
clarification I was able to update the tests to be more precise.  I
again tested with Dscho's gitgitgadget Azure pipelines integration to
verify it works on the major platforms.  Could you merge it (cf.
<20190513164722.31534-1-newren@gmail.com>) instead of the v3 you
currently have in en/fast-export-encoding?

Elijah
