Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0FF1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 09:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfAHJuR (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 04:50:17 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:40073 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfAHJuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 04:50:16 -0500
Received: by mail-pg1-f180.google.com with SMTP id z10so1500680pgp.7
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 01:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIipwU0lQWBtHcGP/HXwe46nU9ng1nvZoDG0QRfSf2A=;
        b=GsTnLwIyWbn0zCukUPRh4x+qtC4JOtbL4Y+vF/UyvwExBmtC9VvNhTlzRxQLPKfApk
         2vgmy9IWkIMy+YTJb0MGObfu1XO+tGyyJHz2+cN7RyJex86eeuYelXht/MM1jh7UZnTg
         t11r+i1jaMA4S/vz+HCgZ0MMLVJC+OwB5hMN0mxhORXZ/s7y2rMvhBlq1lnrNzyMQDmn
         VPtEwMRRGOG3pGAH4LWdnzmDpCBiIAruriOjGWEsqp98ECsI2d8e4pEJxrinAuNFrWpg
         mGDOxZ43V9JQuDk176qMNFlJbuqaU3Gk4gsej8FHciNkBYzuVmH5NX5Yfq2SQOkkwH8C
         FBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIipwU0lQWBtHcGP/HXwe46nU9ng1nvZoDG0QRfSf2A=;
        b=Ay37FjObgtwF2MZEqueu7q/HXiqTLcx0crQU37fnzpwWqh6fkbKBm+YWv3QKtkS5vM
         0zU13rj9t36HCl34aKEyUGRj9btt2NtX0w0JLDYAcldJh673tT66RXMInw4R/XnUEeWs
         OcT9jaGaUMKa5ZtIdn+X9MvgXYoFe3fZLfb+VkPUsnTPJLfms83zA96/RnvPmJuwvFhp
         q5uRhPr6Zd0YvqQpdMvVjkzANJsm7HnOO55TmcSJLgo3uj5HmezcTg+5BtIlT9E8/LJ4
         o0SxEql/RGGTurkJYNFRWYQ42Y+h5DraJzU8p+mPL2xJ0fLmHuQAlN+yMu4iwKE1JuZ0
         UqTg==
X-Gm-Message-State: AJcUukcdvjmoo+HwQ5o4Qxkw2j+taNnSyZULeA8gDNHyyXv84ATX7Wa3
        qNB4R0o2Q6yHDbJJZ7VDtm9JV//Cz0ZaC3TE/CA=
X-Google-Smtp-Source: ALg8bN41ulKaaBUIDr5aCBThqNu8PHhzWtsy2gExXyTq2Q7WigIEbgs+cuN5+WZ0Fa75jKjY8EwjW6lEukMiCg+50hM=
X-Received: by 2002:a62:53c5:: with SMTP id h188mr1031937pfb.190.1546941015862;
 Tue, 08 Jan 2019 01:50:15 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
From:   Thomas Gummerer <t.gummerer@gmail.com>
Date:   Tue, 8 Jan 2019 09:50:04 +0000
Message-ID: <CALgYhfML6UBgG0fs+_hpc9k307ZtZCM-OmhVNcWvCKxSJO+e2g@mail.gmail.com>
Subject: tg/checkout-no-overlay, was Re: What's cooking in git.git (Jan 2019,
 #01; Mon, 7)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 7, 2019 at 11:34 PM Junio C Hamano <gitster@pobox.com> wrote:
> * tg/checkout-no-overlay (2019-01-02) 8 commits
>  - checkout: introduce checkout.overlayMode config
>  - checkout: introduce --{,no-}overlay option
>  - checkout: factor out mark_cache_entry_for_checkout function
>  - checkout: clarify comment
>  - read-cache: add invalidate parameter to remove_marked_cache_entries
>  - entry: support CE_WT_REMOVE flag in checkout_entry
>  - entry: factor out unlink_entry function
>  - move worktree tests to t24*
>
>  "git checkout --no-overlay" can be used to trigger a new mode of
>  checking out paths out of the tree-ish, that allows paths that
>  match the pathspec that are in the current index and working tree
>  and are not in the tree-ish.
>
>  Will merge to 'next'.

Please hold off on merging this to 'next'. There's still an
outstanding comment from Duy and Eric [*1*], that should be
addressed before this goes to next.  (Their comments also apply
to the documentation in 8/8).  I'll send v3 of the series with
this fixed today.

*1*: <CAPig+cSOyCQZXiG7sJWb12WzzujM-nsqqpt+cFZTFvXB1+-SVQ@mail.gmail.com>
