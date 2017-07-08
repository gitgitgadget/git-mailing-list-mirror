Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7DF202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 22:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbdGHWdz (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 18:33:55 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35595 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdGHWdy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 18:33:54 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so8241437pgc.2
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 15:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=63lcctCr4w96qafwJe5dbXTQGV4W+wMLa4kl52aecDw=;
        b=QNa2i99TWHk3wCIX5wW3ksmQI+m3E4ratxdcoqNlBwaI/+gOj9y6HL5RS1qF70t12u
         jUQ5TLrRkDmvzex1KovvbsB15Go9P4F+CFG91pB7PhQv2tyiVVGaIxPP+ZSK+qeAhkms
         L3YNJ7PaQJY9NB0Xi28SLKW+OFAoKk/2pRDcf+BZ0llJhwbWYDtHX41rfKUFP961gCBi
         VICjr6AqIAaUL3EHTtzXPFN9nLDPGM2ylxgQdZPgQGGS8PXelrH32rK9TzCrIvoeD3OC
         D+wTbE+/M2nBpyYq41+QlZkEryRoViol92IVvA1K9MNeDZMLxBiEf6gYDON4wGrWKaBz
         2Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=63lcctCr4w96qafwJe5dbXTQGV4W+wMLa4kl52aecDw=;
        b=Kz+d+IFOlfR8k1UZX174015v45GGDN51uEaDGvBI1Dcwq6+1by1KX03srmKJkG2Dno
         Qxji/aPd8oRFtwzHg5u6p1f5dNQhD4YK3KhDP2N0jSAS939ZkvIEfKwdLhH0RS3AqyGJ
         WT6QirGFGgx+Yh2rHs3E4LlUS3LtU6GW39AymEsOJ2J99QQnYX6QcTQcgqGTyKXSIith
         Sn2ZaTcvgFvoMEZsztDxV0FpMgRN58XWiJYviGXdmJN9qY25w6jtitoz8M5CbucVqMHn
         DqtvJLmBlGqWj5BhlpI9fv+POEkcAQZ5+Y9IFV+j5srzh6zLOEl+pqyDe3KRaG1lSmzj
         pw6Q==
X-Gm-Message-State: AIVw111/GYUBoYwP8dT6WOVTeaxlvycGFUDx6bBquCne+ozy5/h8It65
        M3K+lZR/wuRUXw==
X-Received: by 10.84.134.162 with SMTP id 31mr10051804plh.170.1499553233715;
        Sat, 08 Jul 2017 15:33:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49f8:bc86:d515:b7dd])
        by smtp.gmail.com with ESMTPSA id q67sm16629977pfi.81.2017.07.08.15.33.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 08 Jul 2017 15:33:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #02; Fri, 7)
References: <xmqqa84gaw0l.fsf@gitster.mtv.corp.google.com>
        <1499518240.1914.1.camel@gmail.com>
Date:   Sat, 08 Jul 2017 15:33:52 -0700
In-Reply-To: <1499518240.1914.1.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sat, 08 Jul 2017 18:20:40 +0530")
Message-ID: <xmqqk23ia78v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Just wanted to know something out of curiosity. How am I actually
> receiving these "What's cooking" emails though I'm not a subscriber to
> the mailing list to which this is being addressed?

By having a contribution listed in the particular issue of the report,
you get BCC'ed to let you know the status of your topic.

> Further, my email address isn't list in the To, Cc or Bcc fields.

That is how a message that is BCC'ed to you is supposed to look
like, isn't it?  The point of blind carbon copy is so that the
recipients do not know to whom the message was BCC'ed, so there are
other people who are getting the message just like you do, but you
do not see who they are (and they do not know you are getting a
copy, either).
