Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F5CE1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 20:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933247AbeBWUEZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 15:04:25 -0500
Received: from mail-yb0-f177.google.com ([209.85.213.177]:44812 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932515AbeBWUEX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 15:04:23 -0500
Received: by mail-yb0-f177.google.com with SMTP id z90-v6so3298078ybh.11
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 12:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P844ou43m8wWHVUENERKl4AtjjbpRTOKY78hGUZ6v40=;
        b=ptv3LGaGCaq4NylDQs8Ly8qP8FP05M+Ta5l8p9ABfBRYsUomynLGJpRWUTZaOItMRS
         rqZXJY0ZigqANEUwRwcjAwQK0Reh1SLLFay4j1vxpXoNGTLyVoLJ9SXnMMd+HTJZWV82
         C9bkq6p2o//5huW4sSEPyv3Qb8cQcW3yaP7UPK82rP2iQcU5VuZoNDwUAte8ZeuGmMu0
         uIkugYNjoWJzASg41yktXnkiCHScn317xcyJEQr4QmwVZr5qUHlhlbw69iArPGvydyML
         Ra8lzZORL5M0iN0q9+Yxb0XsnxqxeRvXr46bAWwEZUzF63NPCiHkGoC2/8SiUKJqHtrP
         zb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P844ou43m8wWHVUENERKl4AtjjbpRTOKY78hGUZ6v40=;
        b=KStakod6Z2Omjqo0EGzsKeQRYGJDOUKwS+fnkBgMpdlBiOTZevM1sAG7lt7uhWzr2l
         mAvWJ+Nep9dNKgK0nVCR9vT2KQvfdIZZWA6d2sUL1WC71aXt28+ScoEmFmzR9r1hTeTL
         nGaGe4I0z9h6qWrmg+sujvb6ZqVM769szFTxRkKQGnell+eGTEmpLs0oPQn2j42o/Ud0
         D00TXILrRLJpJfrQ/AyKhG/bsGX2kVUo2RdHCzhi8KYwA6NJefHUTzA/P4ptA+GJUOFn
         qhZvjVe+JDpkleM0ScMbo1QDLjqiWmvUMjE7gJ8qSQ8jXL27ifrPrdvbSWhWa4bT8Ocp
         t9cw==
X-Gm-Message-State: APf1xPBuHJbjeDnXKrS+fskI07hqCaJjuI+pPtM43kuQBu52p20TwQjd
        h2+SOQoqoXEx43UbBn8fJYlfc3LtigsyvlLhKcf1UA==
X-Google-Smtp-Source: AG47ELuGk7Hwp/D34vNCoNw8ENe1ThPWyKdtRQpdOocicvvfi6A1s5khWYWoCl6ZlV2Cxdw6/zILo/NKJXXk84B+7qY=
X-Received: by 2002:a25:7d42:: with SMTP id y63-v6mr2050685ybc.307.1519416262576;
 Fri, 23 Feb 2018 12:04:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 23 Feb 2018 12:04:22
 -0800 (PST)
In-Reply-To: <xmqqfu5rtrhg.fsf@gitster-ct.c.googlers.com>
References: <20180214180814.GA139458@google.com> <20180223095640.25876-1-pclouds@gmail.com>
 <20180223095640.25876-3-pclouds@gmail.com> <CAGZ79karK7MT_qpFyYfVkioeBsBHidGdC_QfisPmG1a4dQuk5A@mail.gmail.com>
 <xmqqfu5rtrhg.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Feb 2018 12:04:22 -0800
Message-ID: <CAGZ79kZUyo-C8FvphXh8dO8s0V5-Sa=fP=faXEiyD3xSezQsRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "repository: pre-initialize hash algo pointer"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 11:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I wonder if there is yet another missing case in the enumeration of
>> the previous patch:
>> Some commands are able to operate on GIT_OBJECT_DIR instead
>> of GIT_DIR (git repack?), which may not even explore the full git directory,
>> and so doesn't know about the hash value.
>
> ... because GIT_DIR/config is not known?  "repack" is not one of
> them, though---it needs to at least use refs as the starting point
> so a standalone OBJECT_DIR is insufficient.

Yes, I could have worded this as a question:
Is there any command that operates on GIT_OBJECT_DIR
without trying to discover GIT_DIR ?
