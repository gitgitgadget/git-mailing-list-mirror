Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D7B208E9
	for <e@80x24.org>; Mon, 30 Jul 2018 14:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeG3Q23 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 12:28:29 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38234 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeG3Q23 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 12:28:29 -0400
Received: by mail-it0-f67.google.com with SMTP id v71-v6so34359itb.3
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEc9F9+VuBaEzFs5pueNt7i1W4s/l+qq4TEEt8ADS9k=;
        b=VQVblT0smpz9mErYWu2yBgiqsyTQrjkI/x+vi7MsbcM5wv9F//5HdichRf0WRg0fpr
         6X3XedWscZUMQ6DUpnxo0z3TAOR4Uomvl0OHYa5lF2ezu3torZlA4cvDiBAn0Hsg/vFB
         wTq58fNFPt/jdv9aECKGpaMgQ9LC72nCuQcuYaCNwf2WsF9GpcvowbQwdFAAYN/A5w5K
         3UknmIycem2iX7aZH9DUkKaAI/LKIqN+KjvjZDDc7pGdCcPf/La4wGnDduiBXMtv39RW
         jDj5AwS/jXCNg5RwKbS1c/UIjZ7jSdG6HBVVi11Ohzv4U3wq7WywFYDIFJ21jCUsVJ2b
         UqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEc9F9+VuBaEzFs5pueNt7i1W4s/l+qq4TEEt8ADS9k=;
        b=FJCnDloANniqc2EPhQIxijEJo5MIzmvX9K/enbLGV9EbBdOZya31I30oNjr4FXlwgq
         mg2dF3/3lQktl3TwJaoDsNZ+TvwOpAkn8N+mTHsL5+TtUXmrZ4avTwoZ0KdSkIZuT7ha
         JbKkZWCiDodfPd03hAu2fpT2/Yh4/6mI9y5sfSQ5RvcjQDKpDgXq1q1rs33EevxLO2lG
         2Ety1qS85okZZyyn+Ltcg0hxZ+061sZZBO6DJk8R0KxM3lHqDkU48iwz9OSSfqXxTL8F
         oYWULmLBwAczlWzQ3x2aha5JPFwbApZggpmtNT2kN5jygmMPHBoKndx7DqVIgb7SsRYM
         naEQ==
X-Gm-Message-State: AOUpUlG+DuzQCWbW1Vn3bNURTYI6vv+aMIyS4LtAMvyVjKu+4ZSY/rsi
        GaAZ0p29gOH/IGCoDgDQywcc8N2SWFy7A3cdQK4=
X-Google-Smtp-Source: AAOMgpf5I+YQ+Oe5emsglb4yOfYYIa/iAXheHIID4BFEyDYW+lgGwDyznrF+gaZEyvYVeg26SWdwOXgKPbDF+1cjidA=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr13832373itf.121.1532962387713;
 Mon, 30 Jul 2018 07:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180730123334.65186-1-hanwen@google.com> <20180730123334.65186-2-hanwen@google.com>
In-Reply-To: <20180730123334.65186-2-hanwen@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 30 Jul 2018 16:52:40 +0200
Message-ID: <CACsJy8CSh5uqWepdY7wCzP024WYcRFM719uXoKzJ4oziHHxwjw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Highlight keywords in remote sideband output.
To:     hanwen@google.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 2:34 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
> +       struct kwtable {
> +               const char *keyword;
> +               const char *color;
> +       } keywords[] = {
> +               {"hint", GIT_COLOR_YELLOW},
> +               {"warning", GIT_COLOR_BOLD_YELLOW},
> +               {"success", GIT_COLOR_BOLD_GREEN},
> +               {"error", GIT_COLOR_BOLD_RED},
> +       };

Please let me customize these colors. "grep color.*slot
Documentation/config.txt help.c" could give you a few examples.

I think we also add a space after { and before } in most places (there
are a few places that don't do that, but personally I'd prefer spaces
to make it a bit easier to read).
-- 
Duy
