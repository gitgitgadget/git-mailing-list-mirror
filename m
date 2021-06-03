Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A39BC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 06:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EEC5611BF
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 06:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFCG26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 02:28:58 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:39572 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhFCG26 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 02:28:58 -0400
Received: by mail-ej1-f41.google.com with SMTP id l1so7514990ejb.6
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 23:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BY0+X6fI3NVUQtyDSptda6R05K3l4FUAUfTKGHDf/JQ=;
        b=cJPuhBlmK2wKB098wpai8Dbdd4C+kSx5D92iljK+QZCBQkC1PvnNTEjMLscZyngyxz
         hkEOcKawmSD3T+C9lgZoOlMPQ4I80a/4ptQzr/P1Byy0GBZd9ADCOEvHhnH7M922kBDK
         ZQpJ+staSNWCqBKmi9hMkfJfM1IfgDb0rLyDD6Wx7TqhNd+jbGGyqKYcHC7fvKVzCPI/
         rIAvOizagcA8l+Cl5i+Wg9Fb2iCy8CMK+jEn+oX2MB755UKXBs5KkPhZwDPKl1sSMWSt
         IaFC8p1q+vS1a+Zd6umwt3QGew6jaGXEeLx+pxPrZxUbs2RtuYG6+ZNM5BsoXeNoAvK4
         lzyQ==
X-Gm-Message-State: AOAM530fXPuxyr/0W0OqtoLFLzG2FQVQ3s6kRgiKdz5ZWextBwz+xAw1
        rSJpVaOCbDAjyvn8eIwcwTwYZwscJiFvDUOW979RSlfJM0ExkA==
X-Google-Smtp-Source: ABdhPJxvqppKEjoHQFIO4i/KiyhAB6+8H5Mh5opwPP+BjU5fhD9s1zY+KbYImbH+Dc6hFY5s/+iO6mT5pXLh7iB3Zhk=
X-Received: by 2002:a17:906:a293:: with SMTP id i19mr2658777ejz.311.1622701617082;
 Wed, 02 Jun 2021 23:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com> <YLhx7nIptHUwXfBD@google.com>
In-Reply-To: <YLhx7nIptHUwXfBD@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 Jun 2021 02:26:46 -0400
Message-ID: <CAPig+cRvCd5fG18n=XsqVLRcPHWJ1XxGvrkfxDY0fg3OgRbR2w@mail.gmail.com>
Subject: Re: Gmail OAuth2 in git send-email
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 2:09 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Bagas Sanjaya wrote:
> > We wonder whether git send-email can support Gmail OAuth2 so that we can
> > seamlessly send patches without having to choose either action. But however,
> > we have to create a GCP project [1] first in order to enable Gmail API. This
> > can be overkill for some folks, but unfortunately that's the only way.
>
> Yes, that's how I have mutt and other tools working with my Gmail
> account set up.  See [1] for details.
> [1] https://bugs.debian.org/905551;msg=5

That link leads to a "no results" page. This link seems to work:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=905551
