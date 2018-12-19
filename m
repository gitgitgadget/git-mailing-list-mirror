Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6221F405
	for <e@80x24.org>; Wed, 19 Dec 2018 16:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbeLSQls (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 11:41:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35665 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeLSQls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 11:41:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so17547125edx.2
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 08:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CH0+AiL2j72ampsB7adyzBop4Y9nf55o/fPBmQ7wrFE=;
        b=ibBJbMro5hW1Su9QAyyVJGdNLnnW9g+584qG0wIiNgFmTjchEJUyk9y53KlOxXDECC
         XdS/da4kSR6+0qpgIzNzdOIAj32snuH/wIpu/kamGacTCYsBeHoyaOCp6Cpuk1xa1suW
         4NP5ONg2CJ7FoW2HUvXsTsuBa8kHtSFASqxKvcL63UviErLtlVzlLOhfT1ytCmpwHNP+
         C8P9mS6G3psYiaqPT7umD+ohsVDu27nT9RIU7bwbuHtHP8rnI6v9XmZVBtYNoDdjYAQU
         5NtgJEnN3dofjbsEZXSP/T7lbb5s54U3HcaS7QDAgsL8vzHnyLuZhtaUtQWfpJmtSsVa
         YKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CH0+AiL2j72ampsB7adyzBop4Y9nf55o/fPBmQ7wrFE=;
        b=Ukdf/95iPPq03Vx5YZDTMr8LNKQUwsroUvijB/nWqIK2QxSFeuZ5lk3JPB4JXqeddi
         exbhWejyLm31XsnBlGathRpxDJRpmgq60yyWFK75MItrWRiTbPr3wcV1oWRpJlAyzJ2L
         B9om/g0lk34Vr9u3T4ZwQvEmtLq1o2p10/py6hQL4WC0CkeNgoc0GG2r3vifoxW4s1rT
         TwjVjJedw18iEMN5LRAUrkwiLj/D8tArpA6CGDqPv8B4ghMJlCowJ/qBWTWIsNGPRE+l
         TC4IcSYv4Am8toRojNkThzMSgMSMxblJiDoz+U8PsDfry5q5twywi7XnYtP8CyqBDE4T
         3lHA==
X-Gm-Message-State: AA+aEWacMZvfWe6C/+bZQI+3wJrzp0USMzYnhUcoBCBEk5VMyM3W70q9
        gKcZgKJciFhUB3ZBpnnLQ5scSbmMU22b3imvkxAyDdfW
X-Google-Smtp-Source: AFSGD/Xe7eQGprMfc6qXhXS1V/ZyHqGpq5ZhN4W/dSsSiOimPhbrlQKz7opFjQcrl/J7wvqBfrSSmQ9vHfZSRLt+sm4=
X-Received: by 2002:a50:e610:: with SMTP id y16mr4147311edm.163.1545237706075;
 Wed, 19 Dec 2018 08:41:46 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 19 Dec 2018 17:41:34 +0100
Message-ID: <CAP8UFD3fDwOm1RjqzkOk4Zve-fRqtVxOdEmGtd13NCjcXTdzVA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 46
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Stefan Xenos <sxenos@google.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dan Fabulich <dan@fabulich.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Drew DeVault <sir@cmpwn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 46th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/12/19/edition-46/

Thanks a lot to the contributors: Johannes Schindelin, Kaartic
Sivaraam and Matt Singletary!

Enjoy,
Christian, Jakub, Markus and Gabriel.
