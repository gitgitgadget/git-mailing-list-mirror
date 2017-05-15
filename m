Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723F31FAA8
	for <e@80x24.org>; Mon, 15 May 2017 09:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760340AbdEOJem (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 05:34:42 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35796 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757106AbdEOJek (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 05:34:40 -0400
Received: by mail-qt0-f176.google.com with SMTP id v27so67589007qtg.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GjhtBk+0dmX8JutC36KhMKKFT+GWLV0z4WSrxDJn6p8=;
        b=Qw7yDo2nRCg5Xv8OMa1GTZt63nI/3U43fOXB929aXnRbhYYkof2b8nW/0hFG8Fulxp
         gJhDPh0CiOOb6n1G3Z4Cy6cwv45pJkqsC0zsbsbvH7kopLWe9TDEuFXlqBw7zqhAZFWH
         OlupPYiGWKKAWqZPgrjThqFMQEj9ixQXOrJldzxRO7eewJGm9spDD/uBs5HM9WlGONP7
         RyUEPVo9EQd1N/MOYa98v1Ucfnn3qB58UV4KPwxq5RDb6ZswwxhOkI07C94WtHgebz7g
         yOattOEXOwgnpHXTjntQzNH5M2kaksceTzt+1MBkbIvY/OMw/CVU0+I5q/bobNtiF9/M
         o1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GjhtBk+0dmX8JutC36KhMKKFT+GWLV0z4WSrxDJn6p8=;
        b=GdxaqpGzSKF/UMVer3Zpc8BNe3B0AgWvYMLSlFZPeLz67CjJJnjSFBq+G6kf8ft0Sq
         BA7NcVrenYuc1c2u+ZT+0vXf8/KwLopRSxNvV+OLPvmCFR/KF6uRwJN5AYRrtprmMdW7
         AjV79G79pTutJKYQAaKi9dnlwys0esuHg3TqAvOADjc676Y41qW8JEyARnqxVIiez9xw
         wYUgJJPVq7pCc4xRgr/hMc6YxLYv8ywj+Q2IdCpdLFhThynuikAWVC8E1Dddcqw9JqTj
         A0XeI9xFxkpF+OFKXuEW82snM0KTru89+k+lE/rS5xs3ki+eSqOpNmvQT/cjrL/SV10g
         Kiaw==
X-Gm-Message-State: AODbwcDPFMqsZe+R4lbLXu3mvyX/PYIqPO5IuxmK0W7/YkGvpHVh7+J1
        V1FtuKEaC4HhioIek5UyM5rVKJhKeg==
X-Received: by 10.200.48.196 with SMTP id w4mr4285364qta.226.1494840880076;
 Mon, 15 May 2017 02:34:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Mon, 15 May 2017 02:34:39 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 May 2017 11:34:39 +0200
Message-ID: <CAP8UFD1T77NkP014uebWO2_3ozbEk0Oivwfb_5hoP+AVff1LzQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 27
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Carlos Pita <carlosjosepita@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-27.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/240

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus and myself plan to publish this edition on
Wednesday April 19th.

Thanks,
Christian.
