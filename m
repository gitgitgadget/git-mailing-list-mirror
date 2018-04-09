Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39D11F404
	for <e@80x24.org>; Mon,  9 Apr 2018 13:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeDINv5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 09:51:57 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36123 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeDINv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 09:51:56 -0400
Received: by mail-oi0-f53.google.com with SMTP id t16-v6so7646319oih.3
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GzNKAsLkQM8Av/9hp+SVbjlaYH1SS8Nkio7SuntsY2I=;
        b=UDUhQaIAHCRa7uoatI+WGd1si3YEe7lhZObUC744uHY5TIdfuAol+H9TsiIHZU5vum
         TAc03A8QvY0GJjJI+yplTuoECXrN6szOAQAjgwGzqfBN3PRGvP9p0PrQnM13CuxKVMST
         2fmH8fJmrLVH8QvgaoJpMxnCw7cWJ6YND6BSSAuv92hpbinUGWKTmjHVQn9HpPQohBMf
         Pg+Fy3gpEAgY4rOB31xtDjx8iCOC0lAs1rWHAtTfZLpGCjIuuYOi4DAXES/BqMlMemiC
         ZwHJVerYIQvilyJEfp0Ybf1qE3284N4SKuXSVGDj8D9XxANpqNN9Ydfpau82P6n/r2ZN
         bf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GzNKAsLkQM8Av/9hp+SVbjlaYH1SS8Nkio7SuntsY2I=;
        b=km2eHpJyEJzXLEau8e1LxZulppbqcumc6gNvwAlHOvSNiY088TSXiWnF+E0SKZ6+px
         gjA6J33n9pYUYksaMK85VXCWRwbbzmN278baRu2nye5X5B+MMl/LPssAsHv/XAqY8sAb
         cL/lafXAfogHtwzn/d/89wi8PHk6kuffQS7QRo5fjgOdgy+J56PlmGsbONJfHcpNurmZ
         jYUotD0h8axv/x4toWoaMAUN/aZzww5D14NAkRmT+s7rcVeTsqyfCdc9XTSrwbFgjXry
         GDc6sTrdVPbLzecdXLBWeueZdwo6wJne2I2tWLOkbJb9bKdvW0pD1q0dSejd/jQvBh2v
         Ztzw==
X-Gm-Message-State: ALQs6tCc5PDMB6WU+ksymEuK65CmYCgVS4jJB9nVRWMLyrlrbHsk/pS5
        rEJCPRY97Hz45y05tA6xabA4wDOUlDPvns+71tjBfyfX
X-Google-Smtp-Source: AIpwx499zP/sIH3NUUo7L8ebetpmJ7CNxNTbjcWKmOsTCE5xnX+/4TV3rZEili/wLiqVCYhxWE9V5+i8Xs/ZkzH9HmY=
X-Received: by 2002:aca:4b88:: with SMTP id y130-v6mr22647094oia.328.1523281915058;
 Mon, 09 Apr 2018 06:51:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.47.194 with HTTP; Mon, 9 Apr 2018 06:51:53 -0700 (PDT)
From:   Raman Gupta <rocketraman@gmail.com>
Date:   Mon, 9 Apr 2018 09:51:53 -0400
Message-ID: <CADF5XCwXYaWMYJFJSHgTJmdDBaPwpUidtsLAntbD1ryJ0MEaJw@mail.gmail.com>
Subject: Created an open source repo for gitworkflow
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As one step towards raising awareness in the developer community and
making "gitworkflow" [1] more accessible, I am creating a home for
gitworkflow on GitHub:

https://github.com/rocketraman/gitworkflow

My intention with this repository is to have a central place in which
to write and collect readable documentation for gitworkflow, such as
concept summaries, useful commands, and task-oriented primers, keep a
curated "Awesome List" of links to related articles and docs, and a
place for developers to ask questions and collaborate on related
tooling and techniques.

This is a work in progress, but let=E2=80=99s see where it goes! I'd love t=
o
see some participation from people on this list.

[1] https://git-scm.com/docs/gitworkflows#_managing_branches
