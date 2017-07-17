Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB92320357
	for <e@80x24.org>; Mon, 17 Jul 2017 15:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbdGQPyA (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 11:54:00 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35434 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdGQPx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 11:53:58 -0400
Received: by mail-qk0-f175.google.com with SMTP id p73so60642928qka.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gW7IXmEGXse/GXhrP7dOPnfi6K/WHL4swr85VBoI+O4=;
        b=cCpTxCBDxlDdGhNMTLFtfAoC0GBvbfAat79Clu6LM+7FXcUAigjCaJtpJwWneFZj06
         iIie5bvfy4tse6M72hZNrTyPtrwDgP3Kk+ICy0NSq78m4b0V7qhOzi8DDjFFhsgTAFSQ
         EIJ5oLCAbE951gJMcY5k6A22syT3KHm1majaE1B0ImDc8S3VaFIwGIef23ezN5Lv0xIs
         yp6yegRw4JHjX6ZrQzYRk5TncaxK2LGgNqy9qwEGj4HsOIkJYGEMrfPzD52SNgs6+aLf
         VwGZ+SdV+zKITDNAbRjdIOvQ64Fi2mRxgQH8fbG2iZPeARsBAeQzgw+Kit0M9h+XC2iQ
         xqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gW7IXmEGXse/GXhrP7dOPnfi6K/WHL4swr85VBoI+O4=;
        b=SkVUKew9OPJGo4HG7Uiu3+A7RFHctDbtPsZH1+OlsgAQFbIYVzz3LN6BL6+9G/MLxr
         RGBd86KG+v2smZTA80Bky9f9w4lyhIPII6sSD2+6ZuZ1opwo2cV3FPwkAGUbMzQb4IJL
         xaRgrIfdeFthkcvLasaKuJgyeS2JW3S4W+9jOoKYZRVlCGL3KhBKvIhgTvN0cnaTN+da
         uOr3LzBcvwJ6XDX57zZfSHr1vRI/BfGXc6M40+JxYuakEWM+jUX5fg0jJ0bKA1tYVBKj
         TmGf6TifDsv51DSVaZUV2ONL9QB75MFnJMHlzrCNB5HMKbxUJl+ZfmSfVaRzITKCgKLY
         lC8g==
X-Gm-Message-State: AIVw113IM4AA6AspEr+7JvpgJ+q2Z6VV4dnWUkZi1gCpyCy5PsJASjuZ
        GqI8n1+fd51mGu0XpHVnhUppOykXcTIFe2w=
X-Received: by 10.55.40.13 with SMTP id o13mr25565350qkh.116.1500306837998;
 Mon, 17 Jul 2017 08:53:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Mon, 17 Jul 2017 08:53:57 -0700 (PDT)
In-Reply-To: <CAA=CdW25uWyZA_7RVnr35dNuK06=8_+fk_tBMt5OSf_xY4LWFA@mail.gmail.com>
References: <CAA=CdW25uWyZA_7RVnr35dNuK06=8_+fk_tBMt5OSf_xY4LWFA@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 17 Jul 2017 23:53:57 +0800
Message-ID: <CANYiYbFF380s2T_TUJ8Wa3pA_zkZc+L7=E-QhyFr4hycqMdmCA@mail.gmail.com>
Subject: Re: [L10N] af.po: New translation workflow
To:     Jacques Viviers <jacques.viviers@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-17 1:37 GMT+08:00 Jacques Viviers <jacques.viviers@gmail.com>:
> Hi all,
>
> I have started a new translation af.po at:
> (https://github.com/jbviviers/git-po)
>
> The translation is far from complete. Should I wait until it is all
> done before I submit the patch, or is it better to submit as I go
> along?
>

After you complete most of the translations, send a PR to the l10n
coordinator's repo (git-l10n/git-po on GitHub).

> Although it is unlikely that someone else is busy with the same thing,
> it would still be better to somehow notify other potential translators
> that this work is in progress.
>

A work-in-progress (WIP) branch will be created to let other guys know
that l10n on Afrikaans is working in progress.

> There is a few of my colleagues that indicated they would help with
> this translation. How does that collaboration work? Do I merge
> everyone's contributions as I see fit and then send in the set of
> patches?
>

You can review contributions using pull requests on your GitHub repo
(jbviviers/git-po), and squash them into one or several commits before
send pull request to the l10n coordinator's repo (git-l10n/git-po on
GitHub).

> Some advice would be much appreciated.
>
> Kind regards,
> Jacques



-- 
Jiang Xin
