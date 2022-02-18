Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA7DC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbiBRSep (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:34:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiBRSen (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:34:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8AC17DBB5
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:34:25 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gb39so17010292ejc.1
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FPYabNNdOaWCh1V7bmxhDjTXKQrzQ1fmu1epxXwMhms=;
        b=JHiLaiBMpkB35xZFK4dwubOvPzlzHL/zkNqztSsJWU+M1xTMRAPifDvOXHVfCEI9qX
         OajjVxg4BDIRVi0HcicSWOiWd61rzFEMbGKVgyai9uhtTfp5UqIB8rlxNV3nCcjeJf3v
         up0sCnWvO62WcOwnTfEMpkd3aqX7XVzXcPeIjZBusvr7oep6yHRyFvEHEEVsEFYnkDoQ
         nzNi9S1LDG7MOqHX6gzqb0wbpYrvxP3HVZ1Qmj0APYlQFGFilK4MB5b0LrFFWjVBtQ9T
         iZSKIsaitDeOKDZwmzMY1umSELMCGNjb3gWtPppEhvutdHU3MJNi0Ldcip3c7djJto21
         7IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FPYabNNdOaWCh1V7bmxhDjTXKQrzQ1fmu1epxXwMhms=;
        b=fgS+v9yoyzTxaFr/TffzD9MYxEDvHrz+oP3HKi8ggnQyh+aRmgwe3xQqtR2agSntW5
         /PlvqOqsdmdAbmExoP6Kbj7n8pF5Y0A5zaHYPIWIrEYdcl++nWSFKOpSH1s4ni3saz9E
         Lc9fMz3fgcrzIa1/PYymEn1R6Yo3W2ii6jHpm7gR0wPEqAxeMB2I4DNIZW4ffgwPhDrH
         3YvVTzlNSXySfOYIfym0TBdsREVqJYgBzupJkCN6Syj+7U/3rOIgANfB4p4hHFtQnGGY
         a6F9GShw0MM4KUw3IocghDQ1+OzEZHE6jvJ4Nik5KoF312qpHxislgsKUxEhkAu3vUm0
         Plzg==
X-Gm-Message-State: AOAM531FXFPWQXkXb3XnwahybbWc3JYoSDm2zaPB6Gxdxkx86SzU+jhF
        m1vtnhYF8Q7BxjmMGiQnxjvpN8LA5cNS+0G64Qtq/wQMpCE=
X-Google-Smtp-Source: ABdhPJzgYZIkDWMsBZk5HqmLKahCBn26uk8cU3ibz5QTCQE9s7qPAWZWuzEy6QxIZMiZcO8MucsLo5QTuoR5Ag9A58Q=
X-Received: by 2002:a17:906:3941:b0:6d0:ee09:6b67 with SMTP id
 g1-20020a170906394100b006d0ee096b67mr228249eje.45.1645209263156; Fri, 18 Feb
 2022 10:34:23 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 18 Feb 2022 19:34:12 +0100
Message-ID: <CAP8UFD2XxP9r3PJ4GQjxUbV=E1ASDq1NDgB-h+S=v-bZQ7DYwQ@mail.gmail.com>
Subject: [ANNOUNCE] New Git PLC Member
To:     git <git@vger.kernel.org>
Cc:     Git at SFC <git@sfconservancy.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff announced toward the end of December last year in [1] that he was
taking a 5 month break from Git and leaving the PLC, the committee
representing the Git project as part of Software Freedom Conservancy.
He mentioned that Taylor Blau could replace him in the PLC and Taylor
agreed to that. We haven't heard about other nominations or
self-nominations since.

We are happy to announce that Taylor Blau is now on the committee.
Welcome to him!

As before, if you have project governance questions, the best point of
contact is git@sfconservancy.org, which goes to the four committee
members (Junio, =C3=86var, Christian and Taylor) along with a few
Conservancy folks. Though unless it specifically needs to be private,
we'd generally encourage people to raise issues first on the list so
the whole community can discuss.

Christian for the Git PLC

[1] https://lore.kernel.org/git/YboaAe4LWySOoAe7@coredump.intra.peff.net/
