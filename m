Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79CEE1F461
	for <e@80x24.org>; Wed, 15 May 2019 17:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfEORt0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 13:49:26 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41465 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfEORt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 13:49:26 -0400
Received: by mail-oi1-f171.google.com with SMTP id y10so417742oia.8
        for <git@vger.kernel.org>; Wed, 15 May 2019 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iVvwTNHweJiB+qBcGsASfYRUyDbbKac7t0DF3uVYnsA=;
        b=OSaBgruQs7ic02JFOHqEoK/nPSCaXomg4gavMAdOIEugibKMzmQgbYg56/kdMPo0zl
         8sIta/BVGZLfBKogb2Vu/8howv6hNfDOfdywgD9CC4VyWM4DVjy7sfTtB+XvwpuhjwX8
         yjLjsYzE5oaWs9SlUo3yDK7cmOJs4cD2I+ZChvuHHm65w4wdcZGqBbZWg0TCyyMgNjF1
         EyI+clsdnuH4OjUjDyux671fdfSCOWmQnMuDvoSO/5OHUMs0489peegg+UAuVQtLhHg6
         AoqxmBIgT7NuWxr65jkfyR0GbtTcquk4zHHLiaL+h6H4xL0cvsjtYTGCozTuRO9fvkNk
         tFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iVvwTNHweJiB+qBcGsASfYRUyDbbKac7t0DF3uVYnsA=;
        b=ARBC5Mk63lbN0Pam2l7Y5maz0Hl+vhgrkgLBcj1pOAJ2DySZgy0FGAfOoEneKHyfM+
         vjBd6zNDGENV9xpDqjT7/VRF/HUxU7rMUMjPvwzWEdaD/qla/m5Fh+JdrrTvT+/ezULo
         vU1UyrsQzeBhobCUyHW88tcb4U6U/GSaHvFS3FyEj/E3bthuZSeaurktS9JV9/94wwxO
         sjI/mjxgyKLDUkQ+2s0JYhPQ7PTDnGqQ+kXayvy/3ABXbyD9U7cCvDOoTWKkCj27nyTf
         9dxxsDFRL8diO4WZ6eTQMgWpohI/R2p1liEsTc4L/tj6kVVoazsrDY9TAAHjm3apaapA
         9HvQ==
X-Gm-Message-State: APjAAAVQqLi/hjRCizvedoS4sih/uVzv0IVyvTaWYlX6nEsNEUriSJ8A
        wpsCdAqhR2x6DWtLQXE5Lbhwnel1UIFKDlimdqhM7FA171g=
X-Google-Smtp-Source: APXvYqxsXv1yLqVkm9ELuQYUC2/L4BEgHv/wWwwU0QFXc0BLjbgWLVGcBVEPDbNbcKmaCLffLvIA8GHCZ4NPeLPxwQw=
X-Received: by 2002:aca:6c83:: with SMTP id h125mr7473886oic.109.1557942565308;
 Wed, 15 May 2019 10:49:25 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 15 May 2019 13:49:11 -0400
Message-ID: <CACPiFCJdXsrywra8qPU3ebiiGQP3YPC6g-_Eohbfwu_bQgfyVg@mail.gmail.com>
Subject: Git ransom campaign incident report - May 2019
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Spotted this on the internet...

https://github.blog/2019-05-14-git-ransom-campaign-incident-report/

Haven't hacked on git for a while, and I am not affiliated with any of
the stakeholders. However, reading it, I wanted to slam my head on the
desk.

IIRC, git will sanely store a password elsewhere if it gets to prompt
for it. Should we be trying to unpack usernames/passwords from HTTP
urls, and DTRT with them?

Are there other ways this could be made better?

cheers,


martin
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
