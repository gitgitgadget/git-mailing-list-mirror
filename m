Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC01C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 06:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJMG04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 02:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJMG0y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 02:26:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D098B357FD
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 23:26:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f37so983576lfv.8
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 23:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9p/OWVmjqtDIpFIikU21x5UBmbcHiDgeLe0VA6erPVQ=;
        b=Rf/j+uHanG+WnuXhZU/oGp/oQtRa31TiZoj3nIxG+eeIxtasluBVENESo314D2G91u
         19dsgMP0nVzE2QjLFaeGMFtZ+1ZWL2HiUYdMMhlYAqmdTCUd8MkqpGot9fgqMI5RihZj
         IyqYVbbl1JR71fbo/LnFZYpTvVn7tC4N0mWLH/zFR5V4j9BmTF3TP3PqbwCV4qAVAy/8
         YinSW0EmqLmlTnwgPq1VgHEj2OnoRVgFVShoWY7j3O8uQCs9I9Nes2tWDBdW8J5B8Why
         wX1Asjjgv2Q4fmFRViX6JWvIFc9nHBMbKfKSgRfZS6tvFp9VUM7yLxXO99S9KNCEkLaf
         5AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9p/OWVmjqtDIpFIikU21x5UBmbcHiDgeLe0VA6erPVQ=;
        b=X9le7nvtlImvaDAkX+Mmg0yVuuxUQZqb40rYbAD3lEG0SmNSGA59SGdvOOlYfpum5z
         AvgwmJ1g2nN15VXSpUe/LVX0Owb+RolFsGQoe0Yd/kw6dOaEpQY3jvKmYbNSoFitKekG
         bHuCrWOHKP1QgvfOhAREEc9gQlUrMb5yrMF9fX3uGMTrKg+JgZQcN5uXmhzlQDlaHQd5
         5L4narty09EBpr8xURccZ2hj2ZCjSFyV/UHpbR3v8BBEcnu9p6uUblNUbH0uubc3HGiC
         WJwGyhwMjbhMnHwRavD/EFv6LHN7vmuEDgkPv4l9XPF9a9RDCS7W21fNAZuWiKlAG5mn
         ibew==
X-Gm-Message-State: ACrzQf3GsgYr9mWR39bU18CTLugbeYQ9PIxRWpQynFYlQikOKY/X2Cri
        ve0ys9CAR2Tk1O3GLse3WFgPdz4Og2aptZNvw/LSaqg409RJ0ejyYwk=
X-Google-Smtp-Source: AMsMyM7ypRXo7xy0MLRbXSgpPUprw/9DlBRYsHD0PhRj6TBoEX/Y0nzd7r4eGAg6Nr154IaNxfyiz2PRtvfu3+h/aCU=
X-Received: by 2002:a05:6512:1399:b0:486:2ae5:be71 with SMTP id
 p25-20020a056512139900b004862ae5be71mr11160535lfa.246.1665642410665; Wed, 12
 Oct 2022 23:26:50 -0700 (PDT)
MIME-Version: 1.0
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Thu, 13 Oct 2022 09:26:38 +0300
Message-ID: <CA+PPyiGHwupxZ=XrmL-1Y=tZyO5JCshD+ss9t9b5pZihM7vFug@mail.gmail.com>
Subject: [Outreachy] Microproject selection
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Team,
I am reading through https://git.github.io/SoC-2022-Microprojects/ and
and I found an interesting task I could do which is to "Modernize a
test script".

When I looked through the code, I found I could clean up t1002 as
mentioned in https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/
.

Let me know if I should go ahead

Thanks,
Wilberforce
