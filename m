Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21ACC1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 23:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbeHNCVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 22:21:18 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45865 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbeHNCVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 22:21:18 -0400
Received: by mail-yw1-f66.google.com with SMTP id 139-v6so14901463ywg.12
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tvm+YwwYBGAC4ZfMHY4VBthUOB6qtbhOZHsUWg/uQ+o=;
        b=vua22KXPiAAnpUmlZR+ZQNJWzDA/r56IMpzmQ5m6GQa0t81hjPnciFi2vXANDevXIQ
         wzd7AIbLrFHwAZoMeTr153Cvdnjsg+N7OnZyOORwc3uQWfkzuUVLPW9O/8t+GfI67Wpz
         Ie1VE/LRAlsFfQhfkLvSRM3ldGf+mz41sYKV8uzI2Q3aqE3askPSDybIJnwJgjzP7oEE
         0jyRfrtqZKpOo6L3jBaifCEEty7RX3/fpwLsJ2DolbST+1Z3okgnG1Xl56haxKeKgVed
         eajPZajh6TepYqvGpLvN8L3hlZuAo56n4Y3ywc3VpzRHXCbNw2C1/LEdvUwsLSBFGZzd
         STHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tvm+YwwYBGAC4ZfMHY4VBthUOB6qtbhOZHsUWg/uQ+o=;
        b=J7HDGDSKqiykxv+xI4xTPiwOuhCBPItuauNaL7Xd2e9xSr2SdfGnlAtUmSOYHluBao
         fAAvfPrrKVqeHGfaCj1QQg5Bur2NWAs02cMiZh6Q6385TVnRp+4FEMYg2imqx9i7FHnC
         2tQ8c4LgmDBW+rei0iLB6Z1Sk3HJsHGCoAiQmp5U5fdizpbguhV6uV7iUALT99XMSeeJ
         Aaq/gWnnRjUQhJMGyQRSAEBjdbSji3qBpHLCLAry9qZ24Eluahlr5Hf7b7btpPw8Gr8f
         ut42+HusrI0Yfkjh8p7+g2yhoxkUNCvypE3aW2uQ9O3UuZr1Q3IofzcjhwBjV4VREMTG
         t44g==
X-Gm-Message-State: AOUpUlGqQZYXAUwtevRaQAjP1vUd6zdjt/jbAoWlLhs+K4cyq5JUtlnZ
        hS86qmtAqG6NpZAgKpnEyTGF/WBu+/CrT1AZk/pHbQ==
X-Google-Smtp-Source: AA+uWPxPYemt5c7C0Son4lsIsTNtKy+fqZ4pfO56JoSdcMg7mlH6bMtm+L0DGaXvxcDNB4M6ZlAGMMWYQ9KbWkvwZSY=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr10273115ywj.33.1534203409707;
 Mon, 13 Aug 2018 16:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com>
In-Reply-To: <20180810223441.30428-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 16:36:38 -0700
Message-ID: <CAGZ79kZvdNNF-TnT5=a2HrMZCpTTZXRuiAoKQ3L5cKjAk9UruA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Resending sb/range-diff-colors
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 3:34 PM Stefan Beller <sbeller@google.com> wrote:
>
> This is also avaliable as
> git fetch https://github.com/stefanbeller/git sb/range-diff-colors
>
> and is a resend of sb/range-diff-colors.

I thought about this series a bit, and I think we would want to break
it up into 2:

  * the actual sb/range-diff-colors consisting of the first two patches
  I can resend them or you can just rebase them without conflicts.
  These two patches (test_decode_color: FAINT/ITALIC + t3206: color)
  are essentially just adding the tests and making sure the colored
  range-diff will work correctly in the future

 * The refactoring, which might be titled sb/diff-refactor instead.
    Given Johannes review comments, I will rework all patches
    that are "diff: something" to have less confusion for Johannes
    reviewing them.

And once we have these two we can have a resend of
https://public-inbox.org/git/20180810224923.143625-1-sbeller@google.com/
which might be titled sb/range-diff-adjust-colors.


Thanks,
Stefan
