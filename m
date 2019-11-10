Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278E01F454
	for <e@80x24.org>; Sun, 10 Nov 2019 18:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKJSPt (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 13:15:49 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:40172 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfKJSPt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 13:15:49 -0500
Received: by mail-ed1-f44.google.com with SMTP id p59so10139691edp.7
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 10:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=o3VQd//YD2sttdHNGe3ELKcJy/DcD10uE2bpzvTLItU=;
        b=Rcgv4fEBKWRZNKDShTkRdJ6gKsNhPfLkS5kI3a288kfC2X4FcRfKkaPPdACTAp40VS
         56oUK59nj1OMhszS1rERs/kX6p7AAqTIAUgRwC7mc4iZ79BartdNcbIYafljHj/HZp8t
         6KN/0rWlPvV8GZMlDzaPfzShsX1i46egNBhTv/gURJ1Qrc93g2ho1GSmDlUSwEc/qf+t
         cXACtwRZTd31TmgkoBGqhlrn1k0hipUDASTxO4reMGYSRY1gxVjK5dWNnT5o20jiFXWl
         wRN/Z7M2yLdPDH2UnshmGiFW5gFyJTNQyUck2vFdg5j0x/YlGGAMkFXMrVM5CZ3wLOYP
         OdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=o3VQd//YD2sttdHNGe3ELKcJy/DcD10uE2bpzvTLItU=;
        b=PYdpzBXQnu5ctSwQJcrp+YeuZGKAiT1dYnOHDpD9gd3yoO4cqgbnMRKPMkOnc0o7gR
         iXCtZN00qFaHsMpm4YNNkxGFzXZk/lWotTFFu1iem68ZsEImzJ6xW58w7MEFDWDRzlQ7
         m6sGJIiAJIlJDgQO0B+NbF5diuFDaE0RfNwW8V1RPs37WPzcynsxlsMWjPsVNDFnv36w
         lLGLZbWhjRw5eJeZk1LWZfjwq62cZVUU8s3x+5NCLdY9ZC25BwAQyIaZAAOkEotkCaSX
         mHslw8etAlSyOBwYyt9x6ynZh8rD7pBQ8l3LBz8ws3fIdmt7BQNAYrlf6F3CxcMkY5ty
         7P7Q==
X-Gm-Message-State: APjAAAUGpGsxCBbqAuz6BN9RYScocexxlTPoLTw/aG7zzZ9aZR7fRMOa
        ItFACdSq5hvPw0YNTAxcgumf5TeOZvFwLdjKwjeL7bxU
X-Google-Smtp-Source: APXvYqyjY11ngv5xNeQlz9R+hdkiocMXzYT+AYnklqO2S1hjR44mCtILOJsCkRCNTml6kCz8VweCEpqVKiNcaUAIv98=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr22200915edw.280.1573409746652;
 Sun, 10 Nov 2019 10:15:46 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 10 Nov 2019 19:15:35 +0100
Message-ID: <CAP8UFD3sVR+Z3ktYUhSCtfCr9fY0btX2UEve+o0y=iuooVTVEQ@mail.gmail.com>
Subject: Git Developer Pages cleanup
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

For sometime I have been thinking about cleaning up the Git Developer
Pages web site (https://git.github.io/), and making some of the
documentation there more generic and possibly more useful for all kind
of newcomers.

So I pushed the following commits:

* 17b7b3e SoC: remove 2017 SoC material from the navbar
* 4e01d0a SoC: remove 2018 SoC material from the navbar
* 7c13096 Outreachy: fix titles

Old GSoC and Outreachy material can now only be accessed through the
Historical Summer of Code Materials
(https://git.github.io/SoC-Historical/) link.

* 9f46f72 Outreachy: rename Outreachy-2016-May to Outreachy-12

An old Outreachy related file now has a similar name as other
Outreachy related files.

* 717ec3c Add General-Microproject-Information.md

Extract information from https://git.github.io/SoC-2019-Microprojects/
to make it independent of GSoC or Outreachy. I think it's really
better to have a separate document and just link to it, instead of
copy pasting it each time.

* 5f6b197 General-Microproject-Information: newbie related improvements

As the document can be useful to newcomers, tell a bit about that in
the document.

Thoughts?

Thanks,
Christian.
