Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C211FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 20:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758101AbdACUDq (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 15:03:46 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:32816 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbdACUDp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 15:03:45 -0500
Received: by mail-ua0-f175.google.com with SMTP id i68so227865193uad.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 12:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zcrTO7DWhOxvbBE1gjZuLa/jHf4iZThknNwrrYIAS/4=;
        b=S2qtYMv8cefR9CLxaCfJFEH6DiI3Xptr/LkyWI/p5xckN2PVJ7WlEhmVWTQKjOgfKR
         QtMui7ZT21YWqnELsKEBWYEnYZ0v/qm+ndGmFid4GG1/eSYtjy1U7WbeiNe36KYwpBuQ
         fdRpa2jw1g8f2Dx/bFBTwveAJZvDr63At30nxEeWgxnR3jaFimk8I1v23IpBcDS4gahx
         vk79nB3EM+ZMYHf41HI2hwLLR044kkYU+Gbi8X3bTTymmGsCjXy9atQnnNKFdk4HBU4P
         LPBH9U3tzyp0kpATvptIGuaIDiHy7iZhMecje56oRWEJGjxUONzVdK2eM69uSuujBLft
         WnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zcrTO7DWhOxvbBE1gjZuLa/jHf4iZThknNwrrYIAS/4=;
        b=pVvd5A0sjdVy3P7vDHooiJ1viC3FTulem0OQqHF/35jDhDVOkq+STOZxiwSiuRhZt1
         m5TiTr0JyxyGZ8Go7y7XMuhAWG3fVJdYEkBZkkK6myspZCfHg+isWGW9ll+yP1Nz5g7O
         AKtBxzY0JMO5SapFWWjtkgWHTk7BIWk4/0PBDkYPSzKizoJM2OP6sWIsR435vgRGyRGh
         Je3kTGdsaW9zMrgFCO74zpx8KPWI70J0Mmh7U+UMAGjmkrI9wtQkfYsronCylLU5PlgD
         UdI4uNPj0J/vGwbjWsFcGALLMaJ44fu1GGQj2ENjZLcylLbCSuw4S2/MiZdKbBmFvEun
         Z0wQ==
X-Gm-Message-State: AIkVDXI2JMAQ3nMSgF1VzDchz4aEfSYJJS1PK4UkNw7n14rWYbVRcZuesrxQzW+kGLfb3816jX7UuuTp6dWChQ==
X-Received: by 10.159.33.1 with SMTP id 1mr48098476uab.134.1483473799006; Tue,
 03 Jan 2017 12:03:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.87.152 with HTTP; Tue, 3 Jan 2017 12:02:58 -0800 (PST)
In-Reply-To: <20161229102223.6028-1-igorkuo@gmail.com>
References: <20161229102223.6028-1-igorkuo@gmail.com>
From:   Ori Rawlings <orirawlings@gmail.com>
Date:   Tue, 3 Jan 2017 14:02:58 -0600
Message-ID: <CAPv0x+PoQ+3ERAc_0gviYP5j1-Zg=X+B1OSC6vDKatqUhFtAag@mail.gmail.com>
Subject: Re: [PATCH v2] git-p4: do not pass '-r 0' to p4 commands
To:     Igor Kushnir <igorkuo@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks good to me.


Ori Rawlings
