Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6100B1F406
	for <e@80x24.org>; Mon, 11 Dec 2017 09:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbdLKJ6R (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 04:58:17 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33892 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbdLKJ6G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 04:58:06 -0500
Received: by mail-qt0-f171.google.com with SMTP id 33so37010964qtv.1
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 01:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2p/3HmFxSnLW+WNXyK/Ty011I0oU6voF8UyQ4n1KnyQ=;
        b=fjP/wyjB8tBKEnq2AGRpGFXXl6elJwy4DNKsll4wOuVPuWEWrjN8a1WQtKAjb6Q/3t
         2EbuwyihgfN2NmAsTBIMtakvn+wVE9kJTO5WYqeYsSvnQ/oTZZhG++oKhfTnJcuyMJRa
         Gen6Q2ZE6PDGjKYyP2hP8S6TRkopiNbpdw8dZ1Z/XbugPTuLDWAb3uXz6Ma8LLOHujwI
         nwwOA8uHjqCBJAt/tR6YCSwbSBZvZYxhdCFcXjBkyZsvwbiY1xJGameF3fsbZ9lCDXBH
         or1jgG+wDqdrZakGcSLD2+3WPNEQeteY6W25IDICC3WS0tzy4NFg49w42Kg+elLmMF6u
         AIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2p/3HmFxSnLW+WNXyK/Ty011I0oU6voF8UyQ4n1KnyQ=;
        b=n4+7WzBfYZ/SphKMVVql7h06O9Uz7tfZ6nQOc1JaHvo05dNzIb4J4iSieDy/DXBu0F
         5ZgM1B/BteEFQO2xN5kOs+RyJYHmWTZOI6k4w2ZA6uWElJ19J6NZZ0LTxkUhI7GFLLCQ
         bNzqTGRCC8gGTnoD2fAr7AaFNkvEpnEoOQVdcAUrlkK1f6Yo8b+NX+rXUzDO2bADelRY
         h4nxwPDA4E/oJ8WsuaUx6oUlSG/h5s8CECl64GO163RfgN2CCdU9APh1F74nkzHGQBNf
         L/iw7MVZ94UP7OUWFpBFx8g67uxNInpTcRXQg6dTiATpU2BGfs040E8Ls8Ve9DUW7/OR
         HWUg==
X-Gm-Message-State: AKGB3mI9PhesTbJNlbWVN8mbAHkmi3Dky9WFhTyCGsMv+4YCA0m1PGQL
        j5xr0/vKeEjsM4ecXnY0u6R1XpyRNnUWCCBQimo=
X-Google-Smtp-Source: AGs4zMY+Zc7xqgv53y8K+lwA4HDMOhgXg9U5KyXdMPXJ/P7b5Xax4jbl62cFtdcJEsqOu5WSFlfxkz7+7cnNKA/h+lM=
X-Received: by 10.55.97.209 with SMTP id v200mr48848685qkb.71.1512986286003;
 Mon, 11 Dec 2017 01:58:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.154 with HTTP; Mon, 11 Dec 2017 01:58:05 -0800 (PST)
In-Reply-To: <xmqq8tea5hxi.fsf@gitster.mtv.corp.google.com>
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
 <xmqq7etx9kzq.fsf@gitster.mtv.corp.google.com> <20171210145354.GA20367@sigill.intra.peff.net>
 <xmqq8tea5hxi.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Mon, 11 Dec 2017 12:58:05 +0300
Message-ID: <CAL21Bmnq63BNGwbkgbSpY-G+GMYBG4UC9+-YL1Gru84Be3EkeA@mail.gmail.com>
Subject: Re: [PATCH Outreachy 1/2] format: create pretty.h file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it true that I need to fix only one commit message? (a typo
s/futher/further/)

Do you have any other advises what do I need to change?

Thanks!
