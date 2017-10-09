Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3057920372
	for <e@80x24.org>; Mon,  9 Oct 2017 23:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755757AbdJIX7J (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 19:59:09 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:47369 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755754AbdJIX7I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 19:59:08 -0400
Received: by mail-qt0-f193.google.com with SMTP id z50so41542923qtj.4
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OfwtFSfXVDvInTh5CHyaXwyn6NnXGlJFkqqJuF2RQGY=;
        b=gUZE2kRfCPvyTUJpR31yXB/pc6nkovJqRF2qTEQV1TEmQ6KAePEhw9hqgV1IVVqo67
         ZvoSW7KJCHVKiJIeYROKqFynlnqbqw3DhidQDc60JObqAs/ek1pNW6ji8saot0UAIHI3
         lLGRL0n8pyXWSEp/sBYOWyq/hOdCCDFkynINe77HnI0CKDhsjRclYvH6xsyK65XYwkAU
         Z8AyOqDPBFhyslIRETeHcoUFitWGLumygjCqRg8Kzd+YsMo8EWo4F47V3J2XHFFRvtTl
         NIIH2FiaRQ5tU/0XQ3YLjPjgL/3aPIx6vO5CTx0+Yid5iJ4aPSROc7E3SPxqmqQkrdeN
         JaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OfwtFSfXVDvInTh5CHyaXwyn6NnXGlJFkqqJuF2RQGY=;
        b=D+rb6YJa+Gh/vfmw0dZ/SYboSFNZaKjW5Kc0Oo+XcaiFNXvUFjBBmiCPOTTiI4kavg
         L2la8BGIQKNOL/4X/0GpzDNZKSnWpLW7z4uEBV9pTHcGIYQfa2yBjsmRJQYte6YaLZ0V
         nD8rvcFmpI9EXs/Bs4snF51Btc5xkIQdR/e/fgaWdcorcsOtMZ/0x3J2Jwh0IZ1TKZMX
         HK9PEkhdqONgkh55roDGyxyTJYGKhed8An/2q/zP0/cX6nD6w4zQi9bYiusy3fKelTz1
         kYJbDnf4UzThRelZbiSf4crNJkKHaMcSlFJpselmWzIj+mnY0THuJJ1FV2vPno4fzhdu
         xJjw==
X-Gm-Message-State: AMCzsaXpMUb4jrgpm38A2cHtExdgWI0/3L86O4Ep/gT8FNmH7Js+GH+t
        cHf8jzbjUn+ExPjAkOynWsCT2yWL5YOZ2vxLrzRD99Y=
X-Google-Smtp-Source: ABhQp+R+uBGcz+1WYQyO7BxCoPbZ84CBwxiDTSyYZbZY+My110s7NipT0x2oHGrg6qAYeevP9bgYttX7TkCC2GJBcQI=
X-Received: by 10.200.6.130 with SMTP id f2mr278305qth.38.1507593547296; Mon,
 09 Oct 2017 16:59:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.19.8 with HTTP; Mon, 9 Oct 2017 16:58:46 -0700 (PDT)
From:   Nazri Ramliy <ayiehere@gmail.com>
Date:   Tue, 10 Oct 2017 07:58:46 +0800
Message-ID: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
Subject: What happened to "git status --color=(always|auto|never)"?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I used to work before, but now:

$ git version
git version 2.15.0.rc0.39.g2f0e14e649

$ git status --color=always
error: unknown option `color=always'
usage: git status [<options>] [--] <pathspec>...

Is it no longer supported?

nazri
