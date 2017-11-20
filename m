Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA622036D
	for <e@80x24.org>; Mon, 20 Nov 2017 08:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbdKTIdp (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 03:33:45 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:36055 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdKTIdo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 03:33:44 -0500
Received: by mail-it0-f46.google.com with SMTP id 187so8712058iti.1
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 00:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6PSEBst3JWUluuLQsUVmTkK16gjIyxYy9czUYLPLZto=;
        b=fjFqeAj6RsIKL/w8G4xZ6H4rJrdOyX0qE/bETvn41L+Ti5wjwCFdW3BdUGUWYXkuLR
         +sZ4R3s6lQYsZwm0oVZHO4JkQX2PpTlMo8mA9XCcOhYEwK5vgqAiP1Yp6SDpb/QVnH3e
         p5QNfqtML/Tq/Hmv1u3assaKcKA6pPlDye5ebPsz6aFFjOyRjv0QnKddG3eMGztqV6al
         MwNK3cPSu302mcu6AD31wMQoaOGl00teqSalvE8kOLYPeDVzJpQFk0d48wjqRH15T7q6
         T9GS0fU+c1uFCPjlEMJuyzwuC9WclW+OxLPrUVvrJUF3nRatUe3W1SAAgvO4UvkauJg7
         5tEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6PSEBst3JWUluuLQsUVmTkK16gjIyxYy9czUYLPLZto=;
        b=Mg6cTboL8Vqvfr+tPpFybhaht2dbbvxfVpEoJxtMSlGbVpswLHijPBux+CFpZ3fd17
         sZyLRBxcH8Q/fkWbC7YYwmrXbvxnhP1kioW8cYIXWdCNAr5y/3Gx/ckqAbNryNsZxibj
         c+yRpAWrTGIm7WjhPe/4HfaEXEhDeswTnUWwZGGcCjQgwnvf2AYO7lRYKUI6+53IGRRF
         h6TnD8mHTQX9auRQYtJ4Q4WFHGltMcEUdPTZC4PBtNxd7bmLtqtotpjuLkSHN/Dq1NXo
         Z5LoE+YDkyVr9FyB5w5M4PhoaO63WbbFeana0ArsN3UxS7Ai5GyEL8U3ZbzlkQv+7deh
         tv7Q==
X-Gm-Message-State: AJaThX7BlbN1VsZfLV6P0W6mGXO925LjQHa40SDIiQZkfUGsXQVQubHs
        GtMkVedX4uGwpcNhIFXL05EiUGnOP7Na9Nhzi6qboLLj
X-Google-Smtp-Source: AGs4zMbIySPV5z6XolPSc3x29ck1vs8dLBGu8qM2L1EgwaslrKq/YtiKb5ExvuP8rG0YdMpTOHUXMoPmg3i8wZ72GnE=
X-Received: by 10.36.78.73 with SMTP id r70mr1208041ita.75.1511166823645; Mon,
 20 Nov 2017 00:33:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Mon, 20 Nov 2017 00:33:43 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Nov 2017 09:33:43 +0100
Message-ID: <CAP8UFD0ggpUGGoOEjAt3sB9=ek+Av+6GemiyqZ4kTCHLC9dWoA@mail.gmail.com>
Subject: Draft of Git Rev News edition 33
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Ross Kabus <rkabus@aerotech.com>,
        Henry Kleynhans <hkleynhans@bloomberg.net>,
        Charles Bailey <charles@hashpling.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-33.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/262

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus and myself plan to publish this edition on
Wednesday November 22nd.

Thanks,
Christian.
