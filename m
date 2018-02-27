Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7C41F404
	for <e@80x24.org>; Tue, 27 Feb 2018 00:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeB0ATb (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 19:19:31 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:44438 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeB0AT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 19:19:29 -0500
Received: by mail-oi0-f52.google.com with SMTP id b8so11603216oib.11
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 16:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j15S+cWKXcBTCsaOtk1FixYJwPUy9Zs8PDSto2JlxUc=;
        b=Fnr16patCWc95CxGNGzf4W+ar/YT2d7bn1eflXquXBFsHZ3lSpmuXZ5OCBNQ1/QTSi
         Y/8dfb3/EbiqvmE6bugjC9BaRWEWopLHQcmZOTVe6GASwSD4yIeEpJM3Cl9seO8iDs/z
         gLSjRGXSnCfosnsnbO3WVWzt2/kHN8D2XPDKpDF1pqdnesOak4cAy2exqvywsc2nJTKX
         KUZ9P1+D5Cezm/N72Tb0EFgsEHtn36MUmrxbgGcY63akTDNhvHVS41D3M3L/G9O6v8DQ
         /bNOJdh8A1YwTSl5AjbkQxnoCLzlC94t2kFDXpYWDfoPHQ3rPeUakEZm2dtjnyWmI/7Y
         p3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j15S+cWKXcBTCsaOtk1FixYJwPUy9Zs8PDSto2JlxUc=;
        b=Y2gDeTPiSQcNEKtk1tvmh6XO8cmGVhU+dDPkWP5he9VxGkRetFJhj8D1G9ET7u7v7F
         PWFK/s2pFulTlzjh0nflnlsaQzjuVJhX/PdD3JmM99iIHhRj7RUig9cCFJo+Tq4N5cx7
         0vNXVFF/MGbJY5J6w/6o4Ycumi1qOTBIBFl0YKXTzEwlQOAiD+JNHwtT+o72vPwlLCj9
         OEkQ6sXnVsJLyXg8IiCHaUrixR7ZwD3fAn1uJVA2NWPyAXhSdw3aVM1gRMlvchL/8Jo1
         3dziNrcWcWqRpbP3Xn2JIr38g9k8UmyHuoHaAluRdB4kTgAXrMMByXOdQjlMyqfC4ydU
         e9XA==
X-Gm-Message-State: APf1xPCZsidKEto6U3v6aLxe/z1eaPMdNUbFsvcldYXr7LWHG45YXCYO
        8axOkp/oByVwHZ7C654moQBVK5EVK1ajQhheHWs=
X-Google-Smtp-Source: AG47ELuhbwECahDD3cvY0kpEpEZqSB6PX987fBkEzbKI5HByX+qrnNIELt4dWF1XX7Qk1AdsIKclVj6mrzVKU2G9JZk=
X-Received: by 10.202.15.21 with SMTP id 21mr8163173oip.216.1519690769321;
 Mon, 26 Feb 2018 16:19:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 26 Feb 2018 16:18:58 -0800 (PST)
In-Reply-To: <CAGZ79kbyrOc6zDSC4cirUW4ZLbDtEeOB=JwPrqxyye=wFR197Q@mail.gmail.com>
References: <20180214180814.GA139458@google.com> <20180226103030.26900-1-pclouds@gmail.com>
 <CAGZ79kbyrOc6zDSC4cirUW4ZLbDtEeOB=JwPrqxyye=wFR197Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Feb 2018 07:18:58 +0700
Message-ID: <CACsJy8AK_q1FK7mzAUOMAy3324YrMrTD3oRaAomDXetFLDmiXQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Delete ignore_env member in struct repository
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 3:46 AM, Stefan Beller <sbeller@google.com> wrote:
> What is the plan from here on?
> Should I build further series on top of yours? The next series will
> focus on the pack side of things (pack.h, packfile.{c,h})
>
> So maybe we'll have Junio merge down my series (and yours as it
> needs one reroll?) and then build on top of that?

I think that's the less painful way for everybody.
-- 
Duy
