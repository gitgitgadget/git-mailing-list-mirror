Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B6020248
	for <e@80x24.org>; Mon, 15 Apr 2019 12:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfDOMxp (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 08:53:45 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36600 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfDOMxp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 08:53:45 -0400
Received: by mail-vk1-f196.google.com with SMTP id w140so3599072vkd.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 05:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTQse649Mhawyz8HtDMb1VD8qv5MPkO57MS4VJ9eglk=;
        b=qcpeFVK7EzRE9pzE0vbzo4G7tBNEk0wxNammrxpBHHqgyY1loR+6DH6PuR01i9rWaf
         UXusluVg4AXZETELaXdlLu1NFCPOikl99FBi+YmM84WVuN2M5d1tISrYmZVrOLwxstY7
         WqbOM9FMeTLX8h8JrGqMYuidrQhpOK5QRmqfFPhfNiUFVQfH0QGwKhnMKJVO19zvakgY
         fQNjrinXzrEOW+jzZCQFC5t4b/Mffyj+aRiPkEB+97FOj80B9BE1rhAS3XXjfI8QvTT+
         /KFk80ZaKHFH31aOcKii24NJM/99FKvzz+wtz5eOIWk8JcmfipSqziu7OCNNS31+TT9U
         Dh0A==
X-Gm-Message-State: APjAAAX4wTJrx48Qeb14hun0v0zxstEs26dw79VbQRj4vK/BQ9Bg7cqA
        XivtGOY9TnctvjbAKhjJevIix4mJgzFO2eWiM0Q=
X-Google-Smtp-Source: APXvYqxfrF4SvC2Gnytc+daHZzAfGuF3mZBNnIeSp9WbeXkhb6Tlyg8SbnAeitpEk4pe4xNfCnTszF/JkvMx8jYsLI8=
X-Received: by 2002:a1f:a0d2:: with SMTP id j201mr40173323vke.37.1555332824220;
 Mon, 15 Apr 2019 05:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.179.git.gitgitgadget@gmail.com> <pull.179.v2.git.gitgitgadget@gmail.com>
 <6161c76702246ab34a520dae8104ad489b89b6a1.1555276767.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1904151434520.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1904151434520.44@tvgsbejvaqbjf.bet>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 15 Apr 2019 21:53:31 +0900
Message-ID: <CAPc5daVRq+tisZqpGVXTwHo7kgKUSfjB6dmjLTUQKqQ+Xh_5eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t9822: skip tests if file names cannot be
 ISO-8859-1 encoded
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Luke Diamand <luke@diamand.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 15, 2019 at 9:37 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> It seems not to have made it into the js/macos-gettext-build branch,
> though. Would you terribly mind picking it up, please?

I think they are separately queued, so that they can graduate in any order,
even if/when one of them turns out to need rerolling.
