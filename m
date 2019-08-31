Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875771F461
	for <e@80x24.org>; Sat, 31 Aug 2019 12:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfHaM1N (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Aug 2019 08:27:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46071 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfHaM1N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Aug 2019 08:27:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id l1so8800266lji.12
        for <git@vger.kernel.org>; Sat, 31 Aug 2019 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=uqszGZ/t5qx7jvA8XTqWPPnx3yz8AUfI6trqwo/b9/o=;
        b=LAcsH+misB+mBT0Gt0nU67OVzzmOG8JRILybjVJ4QQKvqMzOyJovrBJvdANY5nRN7X
         mcmFRdaRYSacKI5J/P3eJgnyiwaVJIXHrt09utoEuzO3CM41ilb0rbNz9gvOZUuCdxQs
         jPZS/9mBjCFYHGBZJHhFxF46BTI/gL7T9vUtJdtezitySw61jxQGwiEpxfgK8zlCjxaz
         A0jq33hETk2+rhX7XMt6yd55LbKTXjkdbMnFJETrnF2wAXO8cgxY+cHSo++YHE1CfRCd
         SGkAPyD45tjqquObVYhPpEzzlFQez9XNNtVo1TX/VYqs55MUbcWu4zQ+2boNr5XSwRqG
         qpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=uqszGZ/t5qx7jvA8XTqWPPnx3yz8AUfI6trqwo/b9/o=;
        b=VFxc1cVdSi5cDyC9VjklUsdweWfgfzqYcsZFPhEd6iV6ogStYefHI+RrsMt5nBTafb
         nonFon2SDM6oYD1Y12dhQU+SjooEzca+VwAI1PhV6SscfjlkkjGMz1vNyof695FbPgqX
         aaMldMEjjld/jHcyGyM3Sj7KblhG8gOotLg1uKkivmjFWOVFOtfLAojIA8wkZQKOktby
         f8OPOXmG2hH8sEnN/rSvCsEcdNerP2xIulB4uZptu5ZIXShzEDAJvrlnVTO6rnOy5a94
         7Lv0kOPld+e9PHWkH8wvMkF3oAn5MglCVgzyro01NKHdY+EgMfdSSVNQZH6Gc8g1r3ds
         b4jg==
X-Gm-Message-State: APjAAAUmHY0U+9M+8e8L5Wfjp3h2PheqCFrHhLXObVKgWM3wYfP6K5U+
        TK/PPDiScuygvEwRa5bJCrjiq9s63iMgVZS1r9VvjQ==
X-Google-Smtp-Source: APXvYqwMxnvD4izHQspm1hYLyDOt39VkEgi3mJfPJYUKJkm4eNycwZD1Tf1p9CDObaixxA601E6of0C+yo37OiSed7U=
X-Received: by 2002:a2e:7a0c:: with SMTP id v12mr4611098ljc.26.1567254431252;
 Sat, 31 Aug 2019 05:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com> <20190831122326.9071-1-birger.sp@gmail.com>
In-Reply-To: <20190831122326.9071-1-birger.sp@gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Sat, 31 Aug 2019 14:27:00 +0200
Message-ID: <CAGr--=JbyagKMFMjZ2P0er8wvNYte5evMh8xn411z6s-b2z_FQ@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Add hotkeys to set widget focus
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Finally picking this up again)

I've been using this feature for about one year now. If I may say so,
I think it is actually really great. It's really helpful for me to be
able to use git-gui with just the keyboard, and I'm hoping others will
find it useful, too.

Let me know what you guys think.
