Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B1831F404
	for <e@80x24.org>; Mon, 15 Jan 2018 07:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753615AbeAOHbf (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 02:31:35 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:41097 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbeAOHbe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 02:31:34 -0500
Received: by mail-io0-f181.google.com with SMTP id f6so12110504ioh.8
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 23:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xfaGzO7S0GW7jXC0BeGpv+JJ6Cja5aCin/jad7Zeq8I=;
        b=jb1WFZSIuR9W/1KJn7JddN6MEiA5Zs7/Iuv7N/tvdcPCrDpSoNwWrMwP/cbERxw238
         FgBeOyDBDI4F7iZA4CRRELg+LE7slPfpZWezptf6GYvYm5WzBhINgpv6b0jJi54ae5ss
         ykouTsYAFspkWqRKFF3XFHIEnqFVOSeq5q0wedK32k4JSNvHCh558F+vD66uAziEwdyw
         40a144dwbTwHSebIhanjJ0hE1nB867yC1qROi/YVcGZQ2roeJvF+O+TbYrupjkmK+369
         cwDd4CcS1o9ZvimmYPAD1SAN/v7ojfoJEc0pN5Z6X5CABLupNjwR5UgO5qc9LfWQ9uF2
         Sy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xfaGzO7S0GW7jXC0BeGpv+JJ6Cja5aCin/jad7Zeq8I=;
        b=lfgV4NGHz/VfsTAVly2CtMK1/WuZ3Q4jMyfeBEKu4S879Q1BCCvO5QTF0za85htArF
         s3ctG/vkc1Z/B07lu3PmS+e6mJ8b5EOWpI/W7C18qFsPsKFmaBHRs39WaILBNGoBOU2s
         HM/kvtK0y4g5CnfQApu1jSmJhkf6XITh+7wFU03/rfGDZ1xmpbvcVRV8gpndoaC1avbe
         Xq5HPQKhcdMDDxGSh3URoD0eJqsqGg8Kky8WPisyLw7G12iaIjBkBJIm8h3MYQGKDkjd
         38gMichOTzw1x807AYEf8vZPMonnGypsk6LwkWiSYEm2eZHpT3vjuvvd1ITe37+Vvaaa
         V5GQ==
X-Gm-Message-State: AKwxytcDdi/0Ij5J2lesxEjZB9bF7Q/zILKkQSUjTOH035ghTu0uA3Re
        vSapt6XeudgLZdgMlAKqDwD68uYioWRuEnZ3P52j+n/c
X-Google-Smtp-Source: ACJfBossGPWJ9DC3aFfpq6Jdzwtg6yvBX/EeOCM6OPFmWH35zljsSLvfjFbfpoEGVS6CihCnJbp1VGMR55i+J41BWrk=
X-Received: by 10.107.3.209 with SMTP id e78mr14979075ioi.96.1516001493449;
 Sun, 14 Jan 2018 23:31:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Sun, 14 Jan 2018 23:31:32 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Jan 2018 08:31:32 +0100
Message-ID: <CAP8UFD2gdwaqNO+CSfqgEamvHood_OOXgkScU=OoT5ssei3HPQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 35
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josef Wolf <jw@raven.inka.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-35.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/271

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday January 17th.

Thanks,
Christian.
