Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45BA1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 17:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbeGWSEO (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 14:04:14 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:42358 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388984AbeGWSEO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 14:04:14 -0400
Received: by mail-yw0-f176.google.com with SMTP id y203-v6so479043ywd.9
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LmZFz532t+i9AqLx3MY9iQYmhwHM25UEpA3sICW9OiM=;
        b=E2wwrB9CrqQNBPiNA2tv1FHFtSj3l10L2UFzUJ+xvCy2JIwrXfXuu54AN+V3/YhvBN
         t+BGq2ou0id4bCLLTupjoVBmIhY9/YzrbltITI7HhuZcoR12mlJ6YrEruPpkm6dfry2+
         naF2JPWdJZXn1RwAQwYdYeVypeMQxwgsAEI88NNf0F+z6FIjs8/8MaonIJk4fzjHM+tR
         A+VJYgQR3QAQJZOnxGB1qIsLLGxt4JoNfUV1JfkHpR14gLqZn7J4Do2CJfDkpGQSnqQj
         N/VqnrnUypeF39kYl/TOEEVOX0LE6zEszqYoqao4M/2y+hddGco8+YbEpMTLzqx2caA+
         QPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LmZFz532t+i9AqLx3MY9iQYmhwHM25UEpA3sICW9OiM=;
        b=W0V7QUtWWw1eQ35NhxvBZWPD8lmnJx2ya7F+YEnFe9+3+adKRwKmkPa9wiQBdm6BEU
         1rO9i2tlh08IJaj/+Rg/N2t4KVn+UioibC6X9aZY538EpSQSTBi/8SeN8DkkwmpFK8da
         ZPoNFyrQn+88g8huVbNhX9EE5RBJQKFG5v7mNskcQtJK6pQOS3Kj426JQNdk5OOIDLkX
         oQs/KoWy8f1U1Gjsf+yIwJVNmBviY6WaBZveqOnYBwnexbSLFEPsY2vv371MoUootWC1
         oJ6Kg357R41JWtCckPw/6NwnAz6RsQdG3I2IAqbLvCJpzIptcg/mFItou5YlSexAeeOs
         Syzg==
X-Gm-Message-State: AOUpUlEBtF84lc/rzPEZvpJD4xy6Aaz6p9Do2fKSVzJtZEosD+XlAFew
        vn/XXHw1eny3RwE84Hkk1gRPpVgFXNVWQ3Z1KwRvTQ==
X-Google-Smtp-Source: AAOMgpd1DXRVThlq04oRMLa0lvPPLx1Xu9x9jW3Kwl4zrrvPaBVlyLLkKaBLrfCj/h61Tr75uzZld8E0pbLUA7VxOww=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr7118199ywh.238.1532365325772;
 Mon, 23 Jul 2018 10:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <208b2ede-4833-f062-16f2-f35b8a8ce099@web.de>
In-Reply-To: <208b2ede-4833-f062-16f2-f35b8a8ce099@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Jul 2018 10:01:54 -0700
Message-ID: <CAGZ79kb=iWobgBsWQBanRdWFBoj-w2Op=HRC6afUT2giNs18Lg@mail.gmail.com>
Subject: Re: t7406-submodule-update shaky ?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 2:05 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> It seems that t7406 is sometimes shaky - when checking stderr in test
> case 4.
>
> The order of the submodules may vary, sorting the stderr output makes it
>
> more reliable (and somewhat funny to read).
>
> Does anybody have a better idea ?

DScho just posted a fix for this, see:
https://public-inbox.org/git/pull.12.git.gitgitgadget@gmail.com/
