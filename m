Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9321F404
	for <e@80x24.org>; Thu, 22 Feb 2018 23:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeBVXx0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 18:53:26 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34281 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeBVXxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 18:53:25 -0500
Received: by mail-yw0-f178.google.com with SMTP id c193so2238017ywb.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 15:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nSYtgMCH+A9WEAArfQZLBK6L9lexLlEyWgrCjLSp7lQ=;
        b=rTZX8Pmnuwl8bH+4VfCORPrX2Zb2lKU/rQGpNEIRkL3cHVpPjnpqMezRJnTpxtm0Kr
         eQSpU/AAmHhwdlaIF9DlxFyXVQdt8S54hE1dnThxItbfR9KgYog9rwHnd3GGg+1vHdqB
         5XNGGR/wLBjVwCQabVikQ99BRSrn4fAPfuVEdB+mmsCOHCRRC5SqHx6yRbn91howpQmf
         TrFcT/vdecl27f971CQGl/EALNoUswJR0BdZGQctXmEYnyWJtWWFdtVXaGUtJxxGqE2u
         gNpfnUNSoBMU/dx65Lgq0UBUECnPVITgBXcRBQLRblWhNfvRi/Ya2FWK61Ck95xcw8mv
         DL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nSYtgMCH+A9WEAArfQZLBK6L9lexLlEyWgrCjLSp7lQ=;
        b=VrzR2NYumQMZ03ahvKTLqJU2ldunv2vm14rZSOauPoNge4NosGkNv5oRNkxkYUCrAK
         UXyOu56bSyp+7AfkfwxtQHC6oc/57MgGL7ETmNMGyB1QkcPdZ4dN0v9D/h35pPSBT6SP
         ZSLkAqlLKiBHH9wnavAqv8ZW2bvEu50oPiofWo45UvTiN6zKjNJNKW9nHkAa6tMZra2E
         UU4HgrcRWlRpsifps+7TNnnHS8fWavdzOLLz2KLp8bw+dBBSOhcCR46Tj9VjYj0Gce8h
         rPMdaCOMLnYPrXOXhj3TbG02INGTD8z/xgYL8cZ6PowSsQJHuyzxNq8hrUCyYzZbknMN
         oanA==
X-Gm-Message-State: APf1xPCKzi8ia0JJhM7bj/XzFy/RKJSgO8Tjdv1SZWiZej+tbD8Hk300
        ARfJ/f1sEY9uv6uzpHu1WdYlokh0Og3ZCe1NesuQdg==
X-Google-Smtp-Source: AH8x226lB+v6An4bseER5dhX0+MnAUFxA9TdS+B+4oHL17n8vhdGPIWiA98J4KQWYP8PR/hlXEt1QZdtpVfSVa7vSns=
X-Received: by 10.129.196.74 with SMTP id s10mr6110734ywj.33.1519343603782;
 Thu, 22 Feb 2018 15:53:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Thu, 22 Feb 2018 15:53:23
 -0800 (PST)
In-Reply-To: <6add3709b4eb469bb7c8d6319637b53a@USEPRDEX2.corp.kns.com>
References: <6add3709b4eb469bb7c8d6319637b53a@USEPRDEX2.corp.kns.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Feb 2018 15:53:23 -0800
Message-ID: <CAGZ79kYS_yJs2uFqLDwCgq4W0HrnMxZcCx8-dTXYf3hpPZYWFg@mail.gmail.com>
Subject: Re: removed submodules shown as untracked when switching branches
To:     Mike Friedrich <mfriedrich@kns.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 12:26 PM, Mike Friedrich <mfriedrich@kns.com> wrote:

>     git submodule add ../submodule sub
>     git add sub
>     git commit -m "submodule added"
>
>     git checkout master

The original behavior of checkout is to ignore submodules, hence it
will be left alone.
Can you retry this recipe with --recurse-submodules given to checkout.
(Or rather run "git config submodule.recurse true" once)

Thanks,
Stefan
