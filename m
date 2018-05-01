Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E4421841
	for <e@80x24.org>; Tue,  1 May 2018 11:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754523AbeEALiS (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:38:18 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44048 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeEALiR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:38:17 -0400
Received: by mail-oi0-f68.google.com with SMTP id e80-v6so9828292oig.11
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tf1mcTFmt85W30K3kMncrHkA6eVfLretN5EaBm2bz4Y=;
        b=FBm9DabAPJyVo3SbQ/VEulo345bCAqx7OsVDn5vmxOjMQmfcNIBPqlIrzx5FwS0sbO
         Qro7Ql5IHcEpJzTBz9qfk29eO/enrerqAhDOwMWTjV5rd1BYgIgPLOhlxE09ZRSHxf8N
         KqOnuPO7ZjcRyQMGKutYFOlsKrma+lecH5WOTpmhcKfbxQq4PBpqvGlMmjqWyIz6bsWC
         eU6Dtib/EnOa0vIBK42fLycfyqD9dhae//7TrvV6G4uwC8Nwi4eGQHjrkFXi2P3dCdeH
         TkQ23HOjPAUkjuMaMZ4wVh0TlRp+BPZGhRqMG6L7q1g8/q4eJUePEMRCnPh5xo7sNcpD
         xlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tf1mcTFmt85W30K3kMncrHkA6eVfLretN5EaBm2bz4Y=;
        b=OATTsbsgrgy9GzY9SAmVaQnY8toEV2Z9PRkDdy2VIXfPVQjXybDCupOwljTQSfV7+X
         tDYn6Dqi/tJRyI7dB4RZqaq3/lYXsMLYRs63n6cOz8hmTHAD+pD3wbuBPx7aEkLOTN/p
         W2fdIf/8mmU4uY6U9yyc6rigoKePL056y3jWzh43mdzu+mZ4Of9d6XLisiKUUbDxe0fi
         q7pMPiVsqNCfgcFuKkJJubaDwzzgj0eN/UvJviMCjrDNRj97weHdouKx10aA9667Frz7
         YcGb5nvNy78oC55iEiECFAMUKmhmAtUdXsLg4ffMHoKc3BrG2K4+lNBrAEqM0H8v92cB
         pkOQ==
X-Gm-Message-State: ALQs6tAsCTwnWX2kTTvFaC6Mg9MuFFVfY+AT/3aoC3b/oQM7suZwdlmU
        4N8OrN4EmCp/6ozDrwK6RTQPeFNMSEPt2R7Dcic=
X-Google-Smtp-Source: AB8JxZqWG74PGuBqvV2dcCdJvDK/V5Le3m5oU9i/U0DupIl98MUUcwg1+POG5k9rwqmSLjoL5W6V+fa3b/AhHHxZ+9s=
X-Received: by 2002:aca:2e09:: with SMTP id u9-v6mr9739328oiu.228.1525174696753;
 Tue, 01 May 2018 04:38:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Tue, 1 May 2018 04:37:46 -0700 (PDT)
In-Reply-To: <20180430095044.28492-1-avarab@gmail.com>
References: <20180430095044.28492-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 1 May 2018 13:37:46 +0200
Message-ID: <CACsJy8D3ERpbpHRh-fdsuBm1e31Z8zdyRmjSm=btKaSU5mnFog@mail.gmail.com>
Subject: Re: [PATCH 0/4] subtree: move out of contrib
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@wilcox-tech.com>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 11:50 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I think at this point git-subtree is widely used enough to move out of
> contrib/, maybe others disagree, but patches are always better for
> discussion that patch-less ML posts.

After narrow/partial clone becomes real, it should be "easy" to
implement some sort of narrow checkout that would achieve the same
thing. But it took me forever with all other stuff to get back to
this.

If we remove it from contrib and there are people willing to
update/maintain it, should it be a separate repository then? The
willing people will have much more freedom to update it. And I don't
have to answer the questions about who will maintain this thing in
git.git. I don't like the idea of adding new (official) shell-based
commands either to be honest.
--=20
Duy
