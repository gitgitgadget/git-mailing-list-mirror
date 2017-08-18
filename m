Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A73D208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 19:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdHRTeH (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 15:34:07 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38218 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdHRTeG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 15:34:06 -0400
Received: by mail-wm0-f43.google.com with SMTP id l19so6991452wmi.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=SAhy5qHdkbjsGXmnCkTVPVp5FD9PsWyk8XJHANu9Z1I=;
        b=J5OGDkon1zq59ChpGdG8V5Bckwjd1RiZMmwaw+qCxOKegQ6nCow509M/GunHhFlm9F
         Q3H20fz48DPl8No/FFWeT0uV0rM3IhaomZzQ0WNeguQbnnIH1/e84nbIaY5XHPfBAiUd
         omoINl3J6Pvhws30pu6K6FnBSD2mtRr/CULwUuKM9llpGq3a+U9b2Z5xzybKPmTa/qu5
         UV6ZH0tm7HSrtbgL6arIqCWv/ftBkpXsqkessvvsL+qCLyTFql5Jih3abLc88Xi48Gx/
         BzZrIHX95ToFJ0Jpaq/zykc2RdkFPPlbc6feXN7xQtQnL+mW+3n67XDHrA8+BJnfhoTM
         6qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=SAhy5qHdkbjsGXmnCkTVPVp5FD9PsWyk8XJHANu9Z1I=;
        b=eFK4OlpAfam5jzxM+S/d4nMH3oIbhr87yIAryzOhDwOIhkz7WGZfZwKeFqtFp6+X13
         pGhhA3OwDTmJTeuVR1lutKCwOGYOpzI3gWs7dDTfGGni1g+EiBLZNAorZteETpuO4UDp
         KfwuYYHTiJ3snP3drhhBcs4awMe/w6CAWeUEJrVaSA0NkI+0ZMBgWsqoGl1nHP+fk+/X
         T40UxB58TV7Q+cOA/0mb27zDnnydE/ORxCxR0CnAVhMYs0HKrTkTwk6YhEJMjJ6Jo8lR
         /rrI473SBSbGTgB4DF2BpVyCtKOrcTBK5XOkXRT04JRSDl46Vrto3uXMPlrQRyqGRnKX
         eeEA==
X-Gm-Message-State: AHYfb5gBGVnisfdO5S6KinLPINwFgU6/1eju+rmnYxKtXl5JXVKYxKea
        1kiFHZ0oBR+LA4+xlXzJqIche365Gg==
X-Received: by 10.28.107.144 with SMTP id a16mr1814226wmi.178.1503084845370;
 Fri, 18 Aug 2017 12:34:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Fri, 18 Aug 2017 12:33:34 -0700 (PDT)
In-Reply-To: <xmqqlgmgbshg.fsf@gitster.mtv.corp.google.com>
References: <cover.1503020338.git.patryk.obara@gmail.com> <cover.1503079879.git.patryk.obara@gmail.com>
 <9a4548f1d0832d036cad152771339d853b5885f3.1503079879.git.patryk.obara@gmail.com>
 <CAJfL8+T3vqnmFJmx19H-v8yGiY4Se78SM+ax_q07_PF4VHDv3Q@mail.gmail.com> <xmqqlgmgbshg.fsf@gitster.mtv.corp.google.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Fri, 18 Aug 2017 21:33:34 +0200
X-Google-Sender-Auth: xNlCu81nYkOhMZoZm59v0y1j7OM
Message-ID: <CAJfL8+TdKm6ScPTG2gD4R39cagxN3=+RSA-KGTpMP6fYjoK0VA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] commit: rewrite read_graft_line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, so that's an option - in this instance free is not actually needed
because it can be triggered only in phase 0, but it would add a bit of
robustness.

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
