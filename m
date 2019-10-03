Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DEB51F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfJCU2O (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:28:14 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:43060 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfJCU2N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:28:13 -0400
Received: by mail-ua1-f53.google.com with SMTP id k24so1345960uag.10
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CZ8dHvAbkksZeNIifxVMcAJGlyxE9rZ+6RKwKSBVGL8=;
        b=qF9NfIFWynJWIgTasOoNgMnwfCNVaFSK4lgpUDgM4JdygBDsBReX1fzcYx9h9LMh3U
         z43kzQMFLVG97X9nJiU2OZb1zm/IgBT5cwzL/QJG/2LC0dSn6VvoJItyjre/qfYG7G62
         6ldMqnWkOFsMVTYtCR2hC2WPZghK1bWGIQlLbSrjz+1oijDEDm3MofoZNTJFpT6qo+bc
         cKucjndReNeFAhkqKwZOX9RIcPCvZ0U9e45nRLvifHtexPTn9abCn4N5ZU+MfvITMKkz
         pJJtLL+Av/PTT0JyImkXN0IqQ95efUBVM+/OouVdIcaU4JdCenbPx8fpilitZGE5qKFF
         w3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CZ8dHvAbkksZeNIifxVMcAJGlyxE9rZ+6RKwKSBVGL8=;
        b=MT8rdVgVfAtkx3WmcXJ4aklpPSUDtULLbGEBuHBdsldE1UWJ4X3pMQIVRyRKBBenH+
         mlpoZn+U8dIvor0hzwnurvX4fl8VwhZP1N6uGMR5Ontp0mTcnIKoZxzf4A4usVAnX1jO
         l0Ad+HEYuMPVm1SmWRT0HjB9kKyNQ3IKoETiAmmPYbQVFJ0nm7CNHB32Xzk7g3RntARc
         wgYmS8deqyw3vq4Df/c7ciN7ClEvZVhFJz4mQeww4v2QOj0xghQ1bvV51HSM70e88rGB
         gogngSAU56JJqeG+dG7+4wpE8PeIEl7s9e/Z+xOYxrDGFjlvxvRC1hpRavhD2jfLyBY3
         xqeA==
X-Gm-Message-State: APjAAAURrAm7QzvgUu7FPi1BQRdfr+hAYbnn3Z2uu34sIikzKRiBlXcy
        UwTVW6d+gqrZeWL5+CkrHh0gLQHhZ4ecMhnZhhk=
X-Google-Smtp-Source: APXvYqwdFtl/TsMAhpKjx5vk4hxnpYxH8GXFKWzmYP/rbeNRD5q2bw1v9pRDBI12tH+l22Upc00GaJWaULlpZ1rXMQk=
X-Received: by 2002:ab0:734f:: with SMTP id k15mr6095429uap.18.1570134492814;
 Thu, 03 Oct 2019 13:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsgoabes8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgoabes8.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Oct 2019 13:28:01 -0700
Message-ID: <CABPp-BHvzyLf=Wwhv45qKdKjiTVwHtsMdfA0hd5Ejf5fmhHyPg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2019, #01; Thu, 3)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 2, 2019 at 10:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/fast-imexport-nested-tags (2019-10-02) 8 commits
>  - fast-export: handle nested tags
>  - t9350: add tests for tags of things other than a commit
>  - fast-export: allow user to request tags be marked with --mark-tags
>  - fast-export: add support for --import-marks-if-exists
>  - fast-import: add support for new 'alias' command
>  - fast-import: allow tags to be identified by mark labels
>  - fast-import: fix handling of deleted tags
>  - fast-export: fix exporting a tag and nothing else
>
>  Updates to fast-import/export.
>
>  Will merge to 'next'.

Actually, Ren=C3=A9 posted a code cleanup suggestion for patch 2/8, so I
sent a V3 re-roll[1].  Could you pick up V3 instead of merging V2 down
to next?

[1] https://public-inbox.org/git/20191003202709.26279-1-newren@gmail.com/
