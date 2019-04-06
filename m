Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2974C20248
	for <e@80x24.org>; Sat,  6 Apr 2019 09:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDFJQu (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 05:16:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42688 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDFJQu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 05:16:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so3174931pfi.9
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 02:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciV+M9QJfWffnn8sbnW36MnbeESaXpn8G46HivHujEM=;
        b=oxiYtFDuOFNfAqS8zfTlaGCBbOWiuGoYxOMQIHHYl3mxeZyrscs9L1oDhkZ4bdAtqL
         rcY7l7B1pk1/GLS+FjnXWmUx10WeZht5epteKbno+KNP9NWtCwSS4auZUQZs2qcxd7P7
         Ct9Y2OxaEH3iV/OqO8DwOmuk8Hm4Tr3fSzT2EDRmq/FD3ksTXxMTzp51DlQt3t04jUgb
         9HBI1IyxICT8IUmyaJsq7374XMlw2EazddX6GWcACpEVohHSl/VkOS4KuIafcVjO9znK
         wQM8faJ+RCml6LI+OYTPOpNFpZADv86M6nY1vInjAR1A8pTkVUxCKT4CF1+u+7fuR4y9
         7lXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciV+M9QJfWffnn8sbnW36MnbeESaXpn8G46HivHujEM=;
        b=rJULa00ZFX4lo+a5iGRm8wsBqR+6xfGN4mdB6Z/jgvoIraypb9/YGI4o5yVC0FiE8N
         rtqxjlAcSmv15zFOTXQ0fRShqddlmOm2E++87chPivw1603M4n4qqephg26ugofET0IN
         R8aAjxr0PM9nf1Pl2ZH+bJeHbnS4753/6z+lZYoT3Uwu0yMkHvmXrU6Ti54V6Rhx5nQg
         KRg/jMSoHyrjXvUZEUc9NlxtthPSgqH04jCpoAaImsxTlIkcwX2ZbH80eWp+69C4+733
         eFV4HyVNlvPxU8M92n13H8JBZPGfUXzm/R994yFyZoyvqbPm+jd+Hiy8xifgr0Wb391R
         crIw==
X-Gm-Message-State: APjAAAWhqipob5lXDSHU6FCZhkxh7/zFGCHVmwnJlM+/Cd8n3ilTxQxs
        TsT0cSW2S15tI0AL/CW8mIlqR1fCYRMMErD1zI3/Wz8k
X-Google-Smtp-Source: APXvYqzoTB9lZVtQq/IcP/fk8EGmPErwgn433uvxqxQ5yomx3HXVOnR6EhoWz/MznjVY6cJUV/BlEPvKsnlvLrpUaBQ=
X-Received: by 2002:a65:6107:: with SMTP id z7mr16859347pgu.313.1554542209447;
 Sat, 06 Apr 2019 02:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAN0heSrbjRExHwch0K_W+xwpERnFUJmaiHhCkAaK9nnxFnXEhw@mail.gmail.com>
 <20190405225115.3882-1-tmz@pobox.com>
In-Reply-To: <20190405225115.3882-1-tmz@pobox.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 6 Apr 2019 11:16:36 +0200
Message-ID: <CAN0heSrPx+_dB+NZzRzidZFpfLMpQUHk-Wi8rTaer+stam0NPA@mail.gmail.com>
Subject: Re: [PATCH 0/2] a few more minor asciidoc/tor formatting fixes
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 6 Apr 2019 at 00:51, Todd Zullinger <tmz@pobox.com> wrote:
> Here's what I have currently.  I haven't tested this much with
> asciidoctor-1.5.x releases (or maybe not at all -- it's been a
> week or so since I worked on this).

Tested with Asciidoctor 1.5.5. For both patches, AsciiDoctor stumbles
before the patch, but not after it. Great. :-) For AsciiDoc 8.6.10, the
first patch is a no-op, while the second patch makes the difference it
intends to do. I'll follow up with comments on the individual patches.

Martin
