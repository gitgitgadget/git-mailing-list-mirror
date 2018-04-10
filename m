Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ED441F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeDJStG (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:49:06 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46568 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDJStF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:49:05 -0400
Received: by mail-pf0-f195.google.com with SMTP id h69so9017995pfe.13
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OrqdLZzTgA6xf9asSnaIRGJOaBRo6TtCAmE8fKmbaKM=;
        b=JP3B+SvfdCkr4qaTnxYibILHNbq/3gdhMOyHuBSfwoUrzztR6LL5sa/Jo4Rf1MqNAS
         ZaLhi8BWzPmecHrSwEJdVPLuq7hvyFIzIGI5bRk+bQeSVYQJmQc7OTO2dWudvs67wJ8s
         ZTk7Fa42SPPIrdXexaY+8QWiMNxnVv/ql1DFL4hx49yvGjRLIgLy4hOK3PQLxTcD2/eL
         V3UrlyuHBp9IT7ZOj7yiZRzEXxVEFjyzU1hSix2lJGJ6ltSWyvH99TK+HaT4lq0+Dbqq
         Pu4DKZdDjOBj/a/IYDkG5IRHnf7/b6vzDXrtT6MrVAPR0F/OVubVcXD1IGxZISMSGoEU
         ZTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OrqdLZzTgA6xf9asSnaIRGJOaBRo6TtCAmE8fKmbaKM=;
        b=YNmiIp+sPdtOb4/fmojySqH1A1ItughLVFfbZp7AXBqEFkDopf4TiVpHnDI6Iqi9BA
         jPg1D0ZRt6jcCtza/YTsdKBG4BMmusqcPooeqOD9vnDCGwM0QygPYEf/ZWG/hgLyDj9H
         ojKaYRrvpElP0KAkc+ucCeL3/KiRQOeiUbIo1Fu/Sfi/0VrxRefw4pwGlq7zkxziO/lj
         zHuIqP7q1QKI0U1Zy7DNKkoxB9IfpnuuHRNwAJUkvcgpSMvKQ9gCjCnHrYkcjvRU/UK2
         takenf8G+tpP0rdt7zPIth9qbmJ6sDG4nRoWSHK5gJvbk/qAcYu/Z04IuJ4DLAN+ZY74
         sY6A==
X-Gm-Message-State: ALQs6tCljwJRjepa/0nhJJJZd8W/lclpwD9oozkX4MlbA5b+WjsV/RMU
        qF6B3Oop9E6X7zIZzZVjt+Yj19u3Rzla6BJG1dg=
X-Google-Smtp-Source: AIpwx4/3mHe2JgYFo67NRSjfXt9OeYiB6NDsTlPWSSUovu2E3otkkxUk8OY1oTrqPfxcqAzw10U0Vi159LwlTOGcOzU=
X-Received: by 10.101.70.132 with SMTP id h4mr1089986pgr.155.1523386145010;
 Tue, 10 Apr 2018 11:49:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.178.66 with HTTP; Tue, 10 Apr 2018 11:49:04 -0700 (PDT)
In-Reply-To: <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de> <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Apr 2018 20:49:04 +0200
Message-ID: <CAN0heSrSvKiRGxSS0jq9Hsxkc7NSuZkt+gLD7DhXRjkfNJd_hw@mail.gmail.com>
Subject: Re: [PATCH v6 15/15] rebase -i --rebase-merges: add a section to the
 man page
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 April 2018 at 14:30, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The --rebase-merges mode is probably not half as intuitive to use as
> its inventor hopes, so let's document it some.

I quite like this documentation. Well-structured and well-paced.
Already after the first reading, I believe I understand how to use this.

> +The `label` command puts a label to whatever will be the current
> +revision when that command is executed. Internally, these labels are
> +worktree-local refs that will be deleted when the rebase finishes or
> +when it is aborted. That way, rebase operations in multiple worktrees
> +linked to the same repository do not interfere with one another.

In the above paragraph, you say "internally".

> +At this time, the `merge` command will *always* use the `recursive`
> +merge strategy, with no way to choose a different one. To work around
> +this, an `exec` command can be used to call `git merge` explicitly,
> +using the fact that the labels are worktree-local refs (the ref
> +`refs/rewritten/onto` would correspond to the label `onto`).

This sort of encourages use of that "internal" detail, which made me a
little bit surprised at first. But if we can't come up with a reason why
we would want to change the "refs/rewritten/<label>"-concept later (I
can't) and if we think the gain this paragraph gives is significant (it
basically gives access to `git merge` in its entirety), then providing
this hint might be the correct thing to do.

> +Note: the first command (`reset onto`) labels the revision onto which
> +the commits are rebased; The name `onto` is just a convention, as a nod
> +to the `--onto` option.

s/reset onto/label onto/

Martin
