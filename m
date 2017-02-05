Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E38A1FAFC
	for <e@80x24.org>; Sun,  5 Feb 2017 10:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbdBEKjq (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 05:39:46 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:36150 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbdBEKjn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 05:39:43 -0500
Received: by mail-ot0-f172.google.com with SMTP id 32so44251357oth.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LjApsXwlAu7RvKwildmH1r4FFiCNv7lUOy2nX9ll+g0=;
        b=bsateoopQdidlnY4LQYcj6htQ9SYGcM2gxTfE4fD2RBhHT4OlkC76g7bej8xwcA/FV
         PhKzJPuh/npr8hrdbv0vYxLpPeYxkuJS2Qxnhyc0bgmT3iaGjRg56Dfhmb2gpZ4tI5hl
         uL1ws3fIY7Klu2Zet8Yu1eJ96LY4Cj61TWR0tKBmgV7XtRfx26BT1i/1ghPovmBBnb2r
         pW9fxqnE9edQgRuMxUrtANBHZAtFRjfj/JSdZ4ZgMERMnRn/16hejThMqaYs5m8qwgua
         OvQOMYFl+bOkuzHbOqLoSAkEqAsPmd1P6AzOXwDvudvH60MNXpAW4bFroi2JtLmcWeBl
         ml3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LjApsXwlAu7RvKwildmH1r4FFiCNv7lUOy2nX9ll+g0=;
        b=Ocxid9ZBii+uJpchouAE/yidWWtJ1BprIFbQ9Jbd8qy8k6fCe7nUXzAWQ8RqIymPsw
         vRBBF/QobZc157l92DRqlr0lc6RBUvGW/WjnCdYm8Jw/qVaLIHgS/Yd6MKWtFJdwinRG
         E9S0a/hgJc8QT+CtgyeoeJuhUEtd1I8B8ZmUNvLohNlE7vUWClVst96cXirodNQbxFgk
         mMKBymvCfI1CdLPCUJQE6fR5CLiItZSrwbo2+5ICf1RWq162q10HBfBIxfjxSbmFDJ1y
         BMlCtq1q/7vYWKBwapbIvRiAB1jD7zFLANm2YnZW01Op3HAGqgxwfYs0WvWiiGjSSw6G
         7TvQ==
X-Gm-Message-State: AMke39kpGFRl/okkAsXQ9io7uEicM4Bm/njM93uvNtdrTLM5fgHzEl4QuBZ0S9FUob0kixffc1sfjpvYRZX5Sw==
X-Received: by 10.157.9.214 with SMTP id 22mr2609158otz.128.1486291182765;
 Sun, 05 Feb 2017 02:39:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Sun, 5 Feb 2017 02:39:12 -0800 (PST)
In-Reply-To: <CA+P7+xoMTX5n_h+5MytZwVqKjqa0wdNKCeDtH29A_+WSfr6gTQ@mail.gmail.com>
References: <20170120102249.15572-1-pclouds@gmail.com> <20170120160942.srqf4y5w5r6feidw@sigill.intra.peff.net>
 <CA+P7+xoMTX5n_h+5MytZwVqKjqa0wdNKCeDtH29A_+WSfr6gTQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 5 Feb 2017 17:39:12 +0700
Message-ID: <CACsJy8CTRcDuRiNeutG82iAj8qQFp+z2nadFfdkkHQGk6GKppA@mail.gmail.com>
Subject: Re: [PATCH/TOY] Shortcuts to quickly refer to a commit name with keyboard
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2017 at 2:16 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> I would be interested in the code for this.. I'm curious if I can
> adapt it to my use of tmux.

I stumbled upon this which does mention about git SHA-1. Maybe you'll
find it useful. Haven't tried it out though.

https://github.com/morantron/tmux-fingers

-- 
Duy
