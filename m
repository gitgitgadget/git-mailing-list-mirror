Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEE3E20248
	for <e@80x24.org>; Mon, 11 Mar 2019 09:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfCKJYz (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 05:24:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54112 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCKJYz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 05:24:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id e74so3581459wmg.3
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1tLkX8dE6XXw8LSppeBaOu6aOTxAebATg7KOcvZ2Nlw=;
        b=onEaAufshrQr06Y/+9LXWsxcur5v3x5kS6sx8UkwGmVhLyNweSAT1x9FgXNRpoHhbX
         SeN4FkqvEcJ8FrPqzOchsQugDIl1ozkVIo7osAPBS4TtyYN/IqLQAvwGuT9kvWqIBZy+
         1jbYhjwxUBAJboHpmOADLbqFwXt2bGJLVR9kZYJvW7t/5ewmAdeTgzb17ybCOOUPMndL
         G0KLz/I8wNAQSsFooR7lTktGglbVrn06pG0DuoNo0XtWRpxJj0mKe5fLJ20YeUmoCW1U
         FcaV60PqwuLQ1ZKmNWCaATkCmZ25Bg3fClEtvfUgvkJ9lB7sh72AojOcoi/dV/wQTs0c
         dKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1tLkX8dE6XXw8LSppeBaOu6aOTxAebATg7KOcvZ2Nlw=;
        b=EKXUZVkWyoAqmZpT/B7NdNnHwOSKKpCIXsGKH/YJQi96EfOu74fGd6+Q1adk/ecSBo
         JH1eGcLpPv6hjc24VSU2qJzUI/d+waVhD+mjoo2nRdYaZ0FKLtt8KqAa8Lb0VkAFEW0x
         1Xrdf/G3GtGcx8pRrz8lH8C4Rox6bVMn/+GuzWTCCoLbAA0z8vLSTzQnVrd7V6bTiOtY
         QLJ/4JPGUYkmJaKV/6ogedTCvtQali1e76IeNPExz6pxWWP2jzgiINy3wwpMO9qih8V9
         m8O4UJwCQxM7HlubbYeqSacZJuCPdOmMALgsryGTfbaaJqVgKjt5T5QiQJsnfJaVFuuI
         Dg7g==
X-Gm-Message-State: APjAAAVPkr1k993xrOF3Adv/oRvfhDcAbSaOpQnHdVB8fpdebFIVL3k5
        vAuwgsC7fD09GuYsUQaTR2s=
X-Google-Smtp-Source: APXvYqzmt2bbN2M4NpBQPP6gWGGl+6679FBv+kKCDmr65mUkQ1IBd3EbkBFLsdi8TogNScobTTD3aA==
X-Received: by 2002:a1c:df07:: with SMTP id w7mr16773337wmg.23.1552296293444;
        Mon, 11 Mar 2019 02:24:53 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id u17sm19370790wrg.71.2019.03.11.02.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 02:24:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/2] fix spurious space after linkgit, now in *.html
References: <xmqqmumc3g1h.fsf@gitster-ct.c.googlers.com>
        <cover.1552230490.git.martin.agren@gmail.com>
        <xmqqk1h6kt9z.fsf@gitster-ct.c.googlers.com>
        <CAN0heSo=qPvzqWA7Z4D2EXHw+DPOu70CS_wzR09Ot+aYYRufjA@mail.gmail.com>
Date:   Mon, 11 Mar 2019 18:24:52 +0900
In-Reply-To: <CAN0heSo=qPvzqWA7Z4D2EXHw+DPOu70CS_wzR09Ot+aYYRufjA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 11 Mar 2019 06:40:04
 +0100")
Message-ID: <xmqq4l89kbkr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> Ok, then I'll take that offer. I'll squash these two patches into the
> original series. Thanks.

Our mails might cross, but just in case you haven't started, here
are the locally squashed results with updated log messages.
