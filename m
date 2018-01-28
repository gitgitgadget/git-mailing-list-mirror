Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CEA31F404
	for <e@80x24.org>; Sun, 28 Jan 2018 22:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeA1Wcb (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 17:32:31 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:53224 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753715AbeA1Wc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 17:32:29 -0500
Received: by mail-it0-f47.google.com with SMTP id u62so6126434ita.2
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 14:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3luk3+qrXzaepuY6uD3VRtISVQc4ZJW2UPCPwk7oVNA=;
        b=W+4nHrlkVnX1DYEku6E+93ZViLcmt/viaozmcgitEhOxOV9Fj8nm9ZPLf8Dbg0q2Hh
         F1RwEq1DQHCbhhhiQextFZ56AUHyfozLIX/68WGbWyU+z7scUHF9OEL8IsQk4r0x8CEp
         nDU2LynWWnlLomEmQVjO8VqtmYX17P9b/bEgJQ2NH46wpLZnvf8pfPrhfIycS6S0WhN6
         FXAJDUqNT6K25MX3k9L0fEouS3ur3ZqpL+IeKDXKvOrE7Q/4OWBn275Du4EnCp0Jy1iO
         uDvUsBs7uCExrCIvny0pacHFIbS1mK2qOFM5RwNfrYGPQPqOtGSqLVoHICHz4BAYB4xO
         h/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3luk3+qrXzaepuY6uD3VRtISVQc4ZJW2UPCPwk7oVNA=;
        b=UrEucEhDd6/EC1ZvL/J2NwsyUzhh+Ste2Uxdy8RGWbgMUi8rAU97IJUvmKUMgROzXt
         IMAsR2nU08IT9lCfeqxHutlEj1WZ9dPMqZCwBR4yN2vYiR5lLwy1hm7ELFKwCKIjp7e6
         zRlQFocusoTnuPeC7vzHCcmqLZwOemdrSRXdB6wV79OROO80Ob9XippRxj1RHs6boMfr
         ja6olvA72cQVqsBV0ROSR8BTaq0tW00LfZukmmJlOKF4VygnvXTei9eqYLguGIekKhEK
         NQUIUJVVZbcy3s4MIcSmbGOZEwHxVqQdk4sX8AQketJuGiK27EZBTLUpj2DmtejFKDWz
         2oWw==
X-Gm-Message-State: AKwxytfQwLxQ7awgUj3CA7lIY8RXXjBHZr9NZSRtH8Y6ed1Ge84L5f3E
        ez48rf4I2bewJcbpL0+mTpwR5lbJJgahNvkABiCxFA==
X-Google-Smtp-Source: AH8x226sbI11h5yKAW/NibjTR9XIkMNKluKC+wEjdZs99i27TM3K3jD1Q4Je962fLAIAaX7sahUoEtCZqEHnTRPtC+k=
X-Received: by 10.36.192.10 with SMTP id u10mr24793115itf.73.1517178749036;
 Sun, 28 Jan 2018 14:32:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.47.11 with HTTP; Sun, 28 Jan 2018 14:32:08 -0800 (PST)
In-Reply-To: <20180126183230.0ae0c76b@kitsune.suse.cz>
References: <20180126183230.0ae0c76b@kitsune.suse.cz>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 28 Jan 2018 23:32:08 +0100
Message-ID: <CACBZZX7W4n9Q-uL0t1W1dttAxA=hU69fL9Tqsfe0wj5XP=O44w@mail.gmail.com>
Subject: Re: git send-email sets date
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 6:32 PM, Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:
> This is wrong because the message will most likely not get delivered
> when the author date differs from current time.

Others have covered other bases here, but I just wanted to ask about
this. Are there really mail setups that refuse to deliver or accept
messages whose Date headers don't match what the expect? I would think
that such issues wouldn't be present in the wild since SMTP daemons
need to deal with messages that are e.g. held locally somewhere, or
the only make it to your server days afterwards due to your own
downtime + client retries.

Now if by "not get delivered" you mean they'll show up on the Nth page
of your mailer because it sorts by the Date header, sure. That's a
problem and quite common, tricky to solve due to the issues others
have noted though.
