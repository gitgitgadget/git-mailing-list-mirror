Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C90342082F
	for <e@80x24.org>; Mon, 17 Jul 2017 07:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdGQHWH (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 03:22:07 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34702 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdGQHWF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 03:22:05 -0400
Received: by mail-qt0-f176.google.com with SMTP id 32so99504166qtv.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eCeIo9PVSFCHoNVDVdMmOFniWJDLCgv8Xf7OAbsT8rU=;
        b=aOy+qJiD9N2C1ZbvtYdP7+LN8d7p0KtLrWe/NqehSpUtg1+S+SqALfNjWgTjQA3HoS
         gsOkmoYbOv7gfDAWjiSyozDvoMVSsiJO1DiC9xiwuaH21zR9T0pJsOLzgkzvBO1FUxDo
         hC53K3qZtlAMAcKoasHnwDtHXzEuk9n8KA99Y918+nv1HEwyiZj2tclZX8fStGR1Y525
         YdStff9bziiUQ06f+aXucZWowJm5Exz7/+7MB7cM1sh3y6F7bagNZMhRZnIrmMYphkeQ
         EHrJ+kGUPEI5CkS6zff8A9gnf5c3p+L5d/nx38WEFLx8qo813bqdh00FRgxfl3V3CRzt
         /vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eCeIo9PVSFCHoNVDVdMmOFniWJDLCgv8Xf7OAbsT8rU=;
        b=UPEAckOkypxSzIkJWSk1h25KJf0h6XXWyYCQZboSb2aFoluq/DzNcF4QEy6KqrcbBd
         FLGDqhfZaUm7965qXQBT9hRy15XRd6pf6UXgB9ZYUXFx9QEVq6cs91Ep0j5qZ8RR69YJ
         5ULmu/Nt046m+HQA22rLLswdhWkuZFvRPYGrepaNTs76biw0ogQYKBtPHXFzQH5WPB8c
         5nX7ocBnKUhRzqou9wXLtEgvK6WwzHp6QOnTcKg/E5vRLYb+Q6FcjnuH4ufyOvEM3OXp
         5rbWt3mzKCf/UQv/k2QhoJ3Qq/o29vYoDwKUZb0ZMMHE0BlTYcCOP91ra5iGhhTOwM3r
         DJMw==
X-Gm-Message-State: AIVw111IiJz4a9+cx8BvkwSvvR5TKTRyA2qBPLQOGZd2wl5pjMA4CwC2
        VtTCM0rxORxkQk19F9BLJ/lGHfR6ZYE6
X-Received: by 10.237.46.99 with SMTP id j90mr27758646qtd.76.1500276125057;
 Mon, 17 Jul 2017 00:22:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Mon, 17 Jul 2017 00:22:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Jul 2017 09:22:04 +0200
Message-ID: <CAP8UFD2w5_fpmEVMrJzOevJvXV76YtSWKZNO_VefSKC1nc0_kg@mail.gmail.com>
Subject: Draft of Git Rev News edition 29
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-29.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/251

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus and myself plan to publish this edition on
Wednesday July 19th.

Thanks,
Christian.
