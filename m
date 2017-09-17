Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB61F2047F
	for <e@80x24.org>; Sun, 17 Sep 2017 20:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdIQUaJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 16:30:09 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:45003 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdIQUaI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 16:30:08 -0400
Received: by mail-it0-f44.google.com with SMTP id r131so4851785itc.1
        for <git@vger.kernel.org>; Sun, 17 Sep 2017 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BU5dVPDAROfwOPaPQGyil14NgnS9DGh7VC6YOaz0Mg4=;
        b=sxbTlFa/TH/Kn50Rdiz4qWtpMZMkmR0UEsnKuBtRLhOueWNuV3yQq4Iyh4jPMtnZhx
         Y6JUZ3a6Y9gQ4kb+zGijIeIY1ukEPYj0DvnstA5L31uDGrhSxoZI/EzVVKDN/mm2Xuqc
         lXsP7yuTuc88mOMZ9duNvfPAd8wZGqTXiCpUM6ubwqbDYjc5MfBFxhmGKCVFjBAJ78Do
         xIwQox0zc6ToXEmiSUVKAR7xXDnbKOCXaDeQYGIEgcMow7hxnEXMifuUOFrYwU0q3sKu
         g6fvn5VTTpIpCO432anzc7sMdMnk7xm9+a46TxpBfljigogGcXIuhyXgKGZjsVh4daS/
         Y3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BU5dVPDAROfwOPaPQGyil14NgnS9DGh7VC6YOaz0Mg4=;
        b=IeFdfALSVKy74YUGsqRrh0T6WOalNCviwDzhqajzGlIKXaamRnFyn2uCajfsI1zD5z
         VTub6E36I8V5aT2BahRVY3l579mtVDo/iv+tqus32AEn2l3LksJ49J/Dpn9BJnTLTdNZ
         4foVhUeqa+GXwp+ffJyMRniRSlAhcojyv1dmV9dyXtDSNpf7SgmQNQOrQcWwz9Yhw4+z
         5Gf5OdfKqJQEfIpBzbexGsnse9LgX8T5KLSrq6Yuf5dYTuKSGyLia7b2QsKpHWxLkc38
         ufrkfCL824g/tTysY8wfdFA+o7UJVe3SoHRTPWsWtLDLaNhbb8DQM9hWt8SfkUWc6+NR
         k17A==
X-Gm-Message-State: AHPjjUhlTgDV2OGiFdPfV/C+6MQshOn5veTkO2iCbzLvetwzdVReiMB0
        hT0nlorVdlcROdLr1DQ4nbdgN+RtrfXhT2WSuBVczQ==
X-Google-Smtp-Source: AOwi7QCou5iYHjlwueBkpQOxnDe8Z6JIdNLWzSGMp5QOuTTO5Y9Y0k/IUiUg3rS+3FQMPYKt1miSao65jpaZbtMFOq8=
X-Received: by 10.36.111.4 with SMTP id x4mr12987642itb.144.1505680207728;
 Sun, 17 Sep 2017 13:30:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Sun, 17 Sep 2017 13:30:07 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 17 Sep 2017 22:30:07 +0200
Message-ID: <CAP8UFD01QdwWdeobXDG19X1ggk88Dcu55DJGMdbyoMoR-uc2XQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 31
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-31.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/256

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus and myself plan to publish this edition on
Wednesday September 20th.

Thanks,
Christian.
