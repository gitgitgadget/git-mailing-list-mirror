Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7111F453
	for <e@80x24.org>; Wed, 13 Feb 2019 09:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391412AbfBMJ4T (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 04:56:19 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:56296 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388917AbfBMJ4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 04:56:18 -0500
Received: by mail-it1-f196.google.com with SMTP id o131so4391096itc.5
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 01:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBF8TfpkdUxoScUC2azHqU5GchF6RURHvdgfHCF92CU=;
        b=Pa2mULafMXjJg6E6K80+HVmYUFL7h3wclQQnkx//d/ipEU9UxSCqF9iqhhlwUmA9tg
         FvWyHrxtL/Wpxsvtiyzbj3Q+2JNAESsI1H4cSUqP+CF/GY9ADg6S1d16AzRbvad+UtfM
         Z1BxW11USkzqsRF5jLgu6cNu6GdZ0BtnLH9e6GdesdyjN4jRQ4H+vlUC34KW/ELmQRPm
         aR01if5jXc4WKibW78DDe1ZxYi2w5qPKE6xlgHP8rUCNPmCUovq8ndWvqJW/qaKG8wfq
         Uf+PgDBCOUJhOWfE8esug/e0oR50+V2fzcWZHiI673h8cwAQ464SC3JQwYT8D+CK2Z85
         gSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBF8TfpkdUxoScUC2azHqU5GchF6RURHvdgfHCF92CU=;
        b=VgKyNKUCub/eSTTIve+zfkiVI2SstO/+CNKPpZlR9VVIVJ4zNbRXxmp8LmJpMFtHcY
         eRI+IUHcnTdr3c0sha+F38mXFUehckUjvAgr8jx5OFZornQig0FED/HROOmEea0leiqh
         WTdwEI3CjnYW+/uUVmqGtLQd0SFOMZpQo9xaCGNydQf4OaBJXPtob99WP9RHN/xVsYLz
         07p+a0quMzbIimxzG4kKjI0wZ45gw9FhTKp+hBZJ99VqPTMxOikWZF954rH4gkNoRVnq
         nvTDZEGtvmxvplbatxJvOrNaTuYENVXqhoMaVJdPH5zSUFX6wnSjxkEVuAWNXk/0KsTs
         zJAA==
X-Gm-Message-State: AHQUAua4X4ff1AxiHlgLcOsUGMEBCMUhOJ3TNKqsR4pcx316pJg6xJ2v
        x1GkaSqmqQjTd45Ze32VT0Qi31vQeolx9Sg44Lg=
X-Google-Smtp-Source: AHgI3IbtsbKb9Si+6PnRI3yYuIkHVfkssJ4qpuM77Wh6jkHYwXHdhUmTJN6isYXGCQeKmEmKCPyyOkafoH5bKKBD1Ig=
X-Received: by 2002:a24:c056:: with SMTP id u83mr1475502itf.10.1550051777063;
 Wed, 13 Feb 2019 01:56:17 -0800 (PST)
MIME-Version: 1.0
References: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
 <cover.1549965172.git.liu.denton@gmail.com> <b0c124d022bfa9a0bbe0c9494df24780b67c8a08.1549965172.git.liu.denton@gmail.com>
 <20190213081518.GA21926@archbookpro.localdomain>
In-Reply-To: <20190213081518.GA21926@archbookpro.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 13 Feb 2019 16:55:50 +0700
Message-ID: <CACsJy8A2M2vc36OLN9jMt3tPq+AwNquyxjrdQXQ7zNZ8pAjTSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] git-submodule.txt: make subcommands underlined
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 3:15 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> On Tue, Feb 12, 2019 at 01:56:11AM -0800, Denton Liu wrote:
> > In git-remote.txt, the subcommands are underlined. Following that, we
> > also underline the subcommands in git-submodule.txt.
>
> I'd like to retract this patch. I realised that between git-remote,
> git-submodule, git-notes, git-stash, git-bisect, git-reflog, it's pretty
> inconsistent between whether it's formatted with the underline or not.
>
> Also, I missed the underlining of the subcommands in the body of the
> document.
>
> But if someone thinks that unifying the formatting is a worthwhile
> pursuit, I'd be happy to reroll this patchset to include this fix.

Making documents look consistent is always good, I think. If you want
to do this, maybe have a look at the "Writing Documentation" section
in CodingGuidelines and add a note there too, about quoting subcommand
names.
-- 
Duy
