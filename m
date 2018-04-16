Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FA541F404
	for <e@80x24.org>; Mon, 16 Apr 2018 20:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeDPUAj (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 16:00:39 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:39373 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753409AbeDPUAi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 16:00:38 -0400
Received: by mail-lf0-f50.google.com with SMTP id p142-v6so23923725lfd.6
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Kk3nooVZniZVVEPMuQwNQ9CfVsj0hrrbAAttt5CbhFk=;
        b=uESznVO8BKb2kEEyMQuRN3ioi2ke5WJuK8y2zMsFcfpynPMVb8VMJ5h1YFttpvFLEv
         ox/bgwk/9TtzbRY95QRXbw0s5OCB9lvnQsDnWLfMFA9S3vPi98Oy9s5jgVa6sbCBc8T9
         SkAEO3qpDwR+kr5rNVPcC0Xqnw9uyJLWQRpa1ArRw5KEkrwHSRsp10NUDWtxjdk2JbKQ
         1n4c1PO2+FJdjRTQ7/d9xVw6Riq1OKpiZPMH0L7bxy669FKJe/Ir2bCiuNNdnE+ZUBFd
         DMNrK2ZP9w6FODf2kpb7OT4Xx4cUPtcc/6/elAbj0pp7q1/D9iuQB4hDXv1et33LS0MD
         uMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Kk3nooVZniZVVEPMuQwNQ9CfVsj0hrrbAAttt5CbhFk=;
        b=G7Bs5F//swRaOKNJp6GQdaaFOweOF/9FSQJDz8vHJr1BGLVOah+IpHgOMIro6szoQf
         FdtbQ31/NEEiwfi62xr6dRElgciDyjxc61UF2Rv+BsAs62eQBGRSPgWdqWlNCRiKRTpe
         pF4y9qG9UrKwUN/TtBYZDVU6gXmQDLg+8+VXrPPK+B1YKDaUHK0ocj1loQmSN6U0H8pJ
         +yPZj9RWrOiS4zAym1RwKmARHGRz8ZzUrPspHgn7/fS5J912H0xu1lWw+paZwU5IhMB0
         Nd/4oKpgYpORv5SJ5Q0oHXHYveMB7n6Vnvl1A3TjwiMMPkHFUnlNZ6dOaZt6F/CcQV4f
         /DCQ==
X-Gm-Message-State: ALQs6tAJAQ3Bm7uQc2p1+uCtO3bnWPNNzriSyj3/Uzd76yjVJU/ySJsK
        wOGPZ+5fMBiAyFX+1q+FV8Q4DB2hUeG/SjcJnBbEfQ==
X-Google-Smtp-Source: AIpwx48xlMJLQxHaDIb52zHKxMvWmubDNs2Nzp+5XqPlk3JqaqIekWnMqsGGQrxarhGnPBy4HHzaSl7JQWDMffdYugg=
X-Received: by 10.46.145.4 with SMTP id m4mr9940669ljg.73.1523908836905; Mon,
 16 Apr 2018 13:00:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.64.203 with HTTP; Mon, 16 Apr 2018 13:00:36 -0700 (PDT)
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Mon, 16 Apr 2018 13:00:36 -0700
Message-ID: <CA+KyZp6K2rYwpcyRvuAYHxMg_pfxCMyaHRBu9LPawMqArJOqMw@mail.gmail.com>
Subject: shortstat / stat / numstat for git log
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@git

I have this question:

https://stackoverflow.com/questions/49863038/get-numstat-or-stat-for-pretty-format

I am looking to generage JSON with the pretty format, but apparent

* stat
* shortstat
* numstat

etc

cannot be interpolated.

can this be updated / improved?

-alex


-- 
Alexander D. Mills
! New cell phone number: (415)766-8243
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
