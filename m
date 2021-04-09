Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD295C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE20610D0
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhDIWFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:05:22 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:46037 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhDIWFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:05:21 -0400
Received: by mail-ej1-f52.google.com with SMTP id sd23so2252846ejb.12
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 15:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Bt4LNYf9KPMrjXY7KRMTe6ImorjlE9OoKXivCIkQbQ=;
        b=FghFTctau0jujTBeEpN2PaAPhKVCcoEWp3X7y8p3ejmWgjjgK0xNeTpIe106TTzqOB
         6R7XbPD7afSVSb2B00IJqCSDaXx9uZj+GaCHQY37fsecsUnr4ItLxk7ESnSkNmvDQmMn
         CMy1IJpLV+T0Y50Uc3eRVcaY+lWag8/vg+igUaI4SIJawQAGgWczr4rjy23zXsRleE0z
         gSnZN9tZx6oQ3rCRdgSIy3ydcXl5itqS50cnbl9++oEMbva/uRUSkg8Me1p0G2thy1WN
         IWUTeYtF52FzzV3eSnfmI41fqUygTQzdtI1XBuCOxTd/w8Gfz1QF0I0V/r1RIzAsxajx
         k0FQ==
X-Gm-Message-State: AOAM530rXCOqjnCkNM7wZRGOCXdhGzPXwUvsiIfkL9WdCyIR9D1MZbeP
        rHjhZsQXui0ahlotB/F8d6OhisrgPSJ/kAmUcxAwZ74cOCU=
X-Google-Smtp-Source: ABdhPJz2V0ND6SWchVyNqkRRCqqjbi1tzF5sipOxwXvuBAlS+QXZm+SWF8rpwOeP051wAFToZbX5nP8G6xdbwEIlCPQ=
X-Received: by 2002:a17:906:2988:: with SMTP id x8mr18143989eje.168.1618005907410;
 Fri, 09 Apr 2021 15:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210409211812.3869-1-sir@cmpwn.com>
In-Reply-To: <20210409211812.3869-1-sir@cmpwn.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Apr 2021 18:04:55 -0400
Message-ID: <CAPig+cTnd23pk9GyH2p-6AjW0cvPD6nqK62moTfRA3FXgROkRw@mail.gmail.com>
Subject: Re: [PATCH] send-email: clarify SMTP encryption settings
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 9, 2021 at 5:18 PM Drew DeVault <sir@cmpwn.com> wrote:
> The present options are misleading; "ssl" enables generic, "modern" SSL
> support, which could use either SSL or TLS; and "tls" enables the
> SMTP-specific (and deprecated) STARTTLS protocol.
>
> This changes the canonical config options to "ssl/tls" and "starttls",
> updates the docs to explain the options in more detail, and updates
> git-send-email to accept either form.
> ---

Missing sign-off.
