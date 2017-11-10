Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AEAA1F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 11:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbdKJLvw (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 06:51:52 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:52483 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdKJLvt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 06:51:49 -0500
Received: by mail-qt0-f182.google.com with SMTP id 31so11439368qtz.9
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 03:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cLzUnjFAdU1EyrVw5eH0jy1MT7hS45qJAoLfnjbg9cM=;
        b=Yx7c2o1nfgGcd2CIJh5GLfp8T0IbyAWXF94Yf66Hoh2+1XmueybERkN4auWhCIqG64
         L5tw2QbpWIE2QZjVIGl5F4wdvVVQ0stkQzg3MXtVX/j8BpNPgXarFs+AHV+Wj1NHun+u
         +cylOOMaVPUaNUsB2AHvdsUd2vWg+ygdpRScCWHjQgMxVjKGg2C2Lh1t0EEibfG6BTUl
         9gRFQJ9Qndlj4+elTx1cpBPOLXqHU4CDfx+Vuj+f4hH6YJ9mOBYkOBZEycMSaRVCheht
         d8QG1Wv4+o6HvCLDOcXousVtaQC9L2cBihSlRNUcFK+H5t0HsaRY1H1EVOYd20qJkrG8
         o/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cLzUnjFAdU1EyrVw5eH0jy1MT7hS45qJAoLfnjbg9cM=;
        b=paTmmDPdpLJ8F7HRsjlhQwgJoIcxCkXH8Mu1Pj+cj7KIWYeOKG/03nf19GVuvXGUsv
         ENaD2csrDDlVM66pN90W97QNlm9R/T9eBBdcO//+I50OiLXJuEfuQ+efwrcgwmkqRodZ
         MZshPFSikkrYDCVYQHW3qBP70NdSmM/sI1b45uZIcohgZAIXLFcsxTJ7A/Trc5mjQ3KG
         OI1AVXcOplhweVTiMYSuUAWg7gCOGCk5w4+zV+AmjbLNMD6ozKXLgLTM1dN+KZWud6oX
         6GUN2yKYhpxqjraTqSqS/pU7mJKQJ61Xx5kSKGr9aXeGC8wjL50kEalbXJm1q4Ezze9C
         90Vg==
X-Gm-Message-State: AJaThX607C7uHySSAg20Gml/HtDimnB/Gb9Gelj49H2iDy/SVBkUB+lL
        iFhRTZ9fyoAgKvEA/FJfMbYhqCzNaxEaKJxq44I=
X-Google-Smtp-Source: AGs4zMa75+jzakJ7dK0HyyartT1tT8P2sYcX3C7GijBYwolehPz/KwV5W0nw8+KzZAco/0+v/aKguTqPD9xfs8lPtUA=
X-Received: by 10.200.43.167 with SMTP id m36mr110854qtm.174.1510314709035;
 Fri, 10 Nov 2017 03:51:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.62.25 with HTTP; Fri, 10 Nov 2017 03:51:48 -0800 (PST)
In-Reply-To: <20171108042219.xfx7tevgkwzrqdtd@sigill.intra.peff.net>
References: <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <0102015ed3e9b1a8-74821a55-aa9a-4e5a-b267-c3d2462e3eed-000000@eu-west-1.amazonses.com>
 <20171002082020.c7ravpwgz45osrmz@sigill.intra.peff.net> <xmqqshdpmtm9.fsf@gitster.mtv.corp.google.com>
 <20171108042219.xfx7tevgkwzrqdtd@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 10 Nov 2017 14:51:48 +0300
Message-ID: <CAL21Bm=+p0bTc7R5mHbrSevkGc6vw4FT=U-ghCZCNB7OoU7Kdw@mail.gmail.com>
Subject: Re: [PATCH v2 Outreachy] mru: use double-linked list from list.h
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> We hung back on it to leave it as low-hanging fruit for other Outreachy
> applicants. Perhaps Olga would like to pick it up now that the
> application period is over.

It's absolutely not a problem for me, I can do that as one more
warm-up exercise in the beginning of the internship.

Thanks!
