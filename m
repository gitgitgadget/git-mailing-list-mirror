Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDDE820954
	for <e@80x24.org>; Wed, 22 Nov 2017 14:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbdKVOAT (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 09:00:19 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:44883 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdKVOAS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 09:00:18 -0500
Received: by mail-it0-f68.google.com with SMTP id b5so6347827itc.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 06:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5A3My+HlAqke+gcn9HSLML/XUVhhP8fv7k7Zq3//YMM=;
        b=B/EayyuwGliVEj6BfnWaojRjHWh1kkbU+aqp+xb3deRd8SzPOeDYxPLP5sEcOXWmyR
         SaH1gN3Se0hm6W+HmbafUygyHMpOcRYrKjYMrZj20SgivsR/8NWGVz/6vjvK3TtwW79U
         qVreO/gAOkYWfz5Hz/HtIObOMRN3r+iDYI4GbVbhwlLgCsvwWgbCdrJuLlsY++Jub5Xz
         7jsUOSiCGlwlTTBme5gWfS+ytp9Z4L2caae0p3jaK2hE+jNLyHYhtQP6BC9JuQ+AbYPd
         fBupkrD7mjrif/mONqbXQQuHKx+kfNoRpGSWZDzZCVs55+B+BjTX0wAS7cEZ8Jxbkgg8
         d9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5A3My+HlAqke+gcn9HSLML/XUVhhP8fv7k7Zq3//YMM=;
        b=BWKBKZavTBCDpRJxKXFDLMbCAnc+jvfMdTz453wZhgFnF9ZXOst8dpGyC49u4EC/2S
         xEDppGqGDpRrfu5VzYlZJovbVFl5OLXabZpExf3xwV7rgeNUhgQWb6qp9WiG3PEfgP6C
         8ZeGO0Jwjj/0G1WE0AzjkUHKyGizZ5h2mvnk4ugY/b6VHCkAVK+Tk/0r8iuqiI8wBRiw
         MAwJxA/A6e/4jf0S5xHSQEx5J1590HthrsbQ1REWL/NOBUxu5iGlkmSHNNMD1UDMRzx+
         3Q3cdkcWJb0OM51IDKzfjQ3JG4a9QmhOWA5BiuP8zGqFwuH2O/kF6nhmLhj9a4f6Vn15
         HpZQ==
X-Gm-Message-State: AJaThX5vuxgbUKrI6akqvGDYVRXiZBmG+lHcJYXKmjziudUOX+vLRFGg
        WF0/vjzuMb7T1DLhnJYBJvwz7kAUO2Y1nqp+Uj5f8W0f
X-Google-Smtp-Source: AGs4zMbBFwzS8fOOiQCRIgYn0lwCXKewFzNmy/rUWyJhahAR+/Uu3lp+A5VkWEil5QpkmFTLXml87yjMMeTvL1MK1CE=
X-Received: by 10.36.228.68 with SMTP id o65mr7200171ith.128.1511359217602;
 Wed, 22 Nov 2017 06:00:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Wed, 22 Nov 2017 06:00:17 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 22 Nov 2017 15:00:17 +0100
Message-ID: <CAP8UFD2rheNa7HdLOZK3mQbGxw_zkJ3GDGE7doVnz8B=gVvGTQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 33
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
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

Hi everyone,

The 33rd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2017/11/22/edition-33/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Thomas, Jakub and Markus.
