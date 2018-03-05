Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E581F404
	for <e@80x24.org>; Mon,  5 Mar 2018 22:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbeCEWVw (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 17:21:52 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:52021 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbeCEWVv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 17:21:51 -0500
Received: by mail-wm0-f45.google.com with SMTP id h21so18991403wmd.1
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 14:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=IuiNicqmGdblxPeLG6CfSuFk0am1nsV/GXek4ykDdU0=;
        b=TaZ2T8N7ey/ruRNhdBrFiR6bBza/wpXnv9G8Lxn/znQU31/s+err3NtXvEk+nSPmnv
         0bftrkp1zaKa9c8xdOFWvGTPTEdbb4JRuqBU5vj5E9rECs3nKh+/kiy4QrN4Wcqcjmph
         KG7dl/WmdbmLHsR0Bf9fl6/qKHvW2qn5JvmbPLjAQXRDyaHeFVAoz877MNRlhrYRcizX
         y0K3kyCmV7mUN7JAQZgkjaTiFnZYHo1jw5YBCHkpSjcGCn0J0PqeN3hrwOJNMs7Fnq/b
         SfrTFVdx7rzZp49aYGrsXZJL+qnT2oTYoUGjxq8HBXxCVDJDz6t8WZtab3tbZRC9NVrM
         23xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=IuiNicqmGdblxPeLG6CfSuFk0am1nsV/GXek4ykDdU0=;
        b=ULG4kIJxYDc2ixHeXld8OdfMYouSmjkvTBMeLk1t/Eq/bWiERNLbNMzJoWYCu9Q03C
         7Jqi3/lvyMEsdK19xr1ZyI817yZJjDQNg2CLeY2FddL294h0IFKg7Tyv3dKgwXc8bsUv
         gPOkbcAvmzFqEPzuaAmoX0cBS0Bvg/QQNjWePqDCdZfYWECL64jouu4hRb5GySc/NwNR
         HUxiVYaNjLhmcaUs5WoYXVZkuwcVuwQgn2HUOtEDGVIO1YL34AjlHznDmIX4bE6Y8DFI
         MXee5eui0QLKNKWord6ET9YmrPFUWiG8hmoQm/fhZ4I0uWdYfWT4YzQZ9kdl1fUVTIBS
         0Uzg==
X-Gm-Message-State: APf1xPANqQOaNQkC2yhjeEaNBp7Hkf/ogadzirNbNJwpb+8dyROdqrvW
        kOXgH6Mzr1xbBFkt+2/79xM=
X-Google-Smtp-Source: AG47ELsB+gDS4u2EyzYbuZgS+rcWpBdJxB7qSQi49bMSaOvN9s9/YIWqUPhZPEMW5U/Tmb7zNxT2fA==
X-Received: by 10.80.179.55 with SMTP id q52mr19858354edd.75.1520288510253;
        Mon, 05 Mar 2018 14:21:50 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id h9sm10865453edi.79.2018.03.05.14.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 14:21:49 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Ad-hoc pre contributor summit dinner & drinks on the 6th
References: <20180303103010.GA21068@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180303103010.GA21068@sigill.intra.peff.net>
Date:   Mon, 05 Mar 2018 23:21:48 +0100
Message-ID: <874llunoxv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 03 2018, Jeff King jotted:

> The rest of this email is all logistics for attendees, so if you're not
> coming, you can stop reading. :)

I'll be arriving in BCN around 17:00 tomorrow. If someone wants to grab
pre-dinner beer or dinner, preferably in the Eixample district (just
across the street from the conference venue) before or at Spanish dinner
time (around 21-22) add me on WhatsApp @ +31 611 763 987.

If there's more than one person interested I'll create a WhatsApp group
for it so we can keep adding people. Or reply here if you prefer E-Mail,
but I'm thinking subscribers to the ML who aren't there tomorrow will
thank us...
