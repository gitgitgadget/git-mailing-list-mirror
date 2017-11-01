Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90E9202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 17:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754608AbdKARR7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 13:17:59 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44336 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754593AbdKARR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 13:17:58 -0400
Received: by mail-qk0-f196.google.com with SMTP id r64so3580294qkc.1
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q9fOt6kJ9rtCTzrNu4Nd7FpDSNyjFVREhlb9QI/rHv8=;
        b=iwz0SaLmzxJmvKqGKFykQmEqVzQ3g3AxMEQcL/WNcVouLdpMp4VA4FIqi2Vi33wcKw
         ZZF6LoLXvfQhC+r2nqdFtVL5jNA6iaP52g5Wth+7rbckMiwAaGb25WYiugOELuADCa9v
         GwvlPE5/01UC3bmsiX6NbBoX9xqqWzAAtWC29XYGjOjkA4E5Z4LZKRwMgf4SbZLGwRXE
         3HNPpnMzRtJz+1I/Z5630UwwdkaGZKm/tUfVDNLGCXsTEkkhaHa6yDCZcVyTtb5gv0Rr
         ax+GfUfRlbzTOwIvAvi6vKkxG0KLtZOyzmStMbGxUZo/MqrI7kMC5rG+XwUv4CQFd+/q
         33gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q9fOt6kJ9rtCTzrNu4Nd7FpDSNyjFVREhlb9QI/rHv8=;
        b=Yt1h4UW8kGqC79ZOX31+wQeAe1v6uk1ElyBpwDjZRn8ox7qxUzY3nJLd8bcUEWwCtz
         q2GtgfCXGZASaYNx70KqFLwBrA+mTnj7ucFmelfsXy3v5KnRw1bBRPNH378qNow3/KYb
         tOEWIlqHULm1H2OPu/vRnF7H4lEqyJzQwVflEe3d2vGnZwR8xMRfENdgdLxUPwt6Sza5
         tIsi1KnMoLTtd8qH5T+7jjfjj4YoZu4kYQ/AOXkD2tbtncmmNdqfWY3yRXQU2U7uEMUf
         BIY+bnEhmtr83aIxdYzbEfp1gO1P0C7Sv+qj9RuYZB+V07AclHcOSy03xAs+Q7GqJxOb
         hy0Q==
X-Gm-Message-State: AMCzsaX3Q8oOc+5EQgouygoKEN/vyfzfRbiJQz4UppLwvtbzvkgxFjLY
        vJgOXLFtdQfJJC0ScyNKRwTvEvnZ5hWC+ZtdAH+ZniQD
X-Google-Smtp-Source: ABhQp+Ruj1aIEALdsomnhCX3JpZBW2UYomoNmfStdYYVLrjGyaO0BE+XGr8B4yV6AhiboLKr8aB/0mEGYtPfQeZm04A=
X-Received: by 10.55.33.203 with SMTP id f72mr902243qki.176.1509556677855;
 Wed, 01 Nov 2017 10:17:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 10:17:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1711011737460.6482@virtualbox>
References: <cover.1509382976.git.johannes.schindelin@gmx.de>
 <20171030205522.hur26cumwusk7wwa@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1710311809570.6482@virtualbox> <20171031180933.styinoik4npmd53b@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011737460.6482@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 10:17:57 -0700
Message-ID: <CAGZ79kbQW_EdYrvst+vRPY_uqdFuqesKzpgTwx=yr8dCx=8yCQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] mingw: introduce a way to avoid std handle inheritance
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It sounds a bit stupid to cater to myself in patches *I* submit, but I
> refuse to believe that there are many people with more time on their hands
> than myself (last time I tried to research this, it looked as everybody
> has the same 86,400 seconds per day available, give or take the occasional
> leap second).

Try traveling west bound every day.
This one weird trick with time zones will amaze you!
