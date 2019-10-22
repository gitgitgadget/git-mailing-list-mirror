Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4695B1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 09:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbfJVJ2S (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 05:28:18 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:36270 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730312AbfJVJ2S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 05:28:18 -0400
Received: by mail-ed1-f45.google.com with SMTP id h2so12334300edn.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 02:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YjBl5nXM2YvtSxdSfuNxR0jjZWnYCCb25eBFh+PlWis=;
        b=S2M3MS3ONBJZyhS4r1OvtofA28n+kc55TSzaLG8Dd90vBELoqbT0Tj3jGdjmahzwE/
         SgvGD9zdGxeJSYX3LctXNeXxEpIJuJDWXMP9DvIrHYqlOex0oWqPLCG++SwrdeOsMNxs
         bVpzOyALkZGR1zouoZqO67K51ykBALJPH2MpG19K7p2WirR9kkTWJyY7c4mRnn96RinT
         2VdQcWoWcEWO0e19Pz63LEeSbxGy5TMW+Y7CVahdxPDV/twhxOulvjyN551xsUeP7MDO
         7YgwVkHtnU6NH9RGeaDJ9DNCJF/eYyL4GC8IBXRXBlmYDSbdgarmkD6HDb9VkKptPvb+
         SZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YjBl5nXM2YvtSxdSfuNxR0jjZWnYCCb25eBFh+PlWis=;
        b=InMuiLy+YcJ7kgDuTtWq6BtvYOgMnVmT3mAkgjbs2a7PLDMy1+XMKReGRzBBZdwLwj
         xN2R6/J4YTg8rZ0GW+9AdbPwunkJmnDK/oUdR5z3LggDxAlxa8EH9Gx5jU05iKaxs+82
         uRdoAPX3C9pC77lbq51EyHHcgY+0JV/qJhitWYq3r0Rb0Wsa+uiyyh039HZR68lrmmEd
         ap5gsCpCa0dQ/n5T/xag6ClHA3jsIwXJD29ptVDvHrbm/zlHUGcHU5NYJaZU0id2M/MV
         EYpvyNYBCF7D4DvzO90oJyE1Sv+SZSqOkqUEs6kYMw+MD0fecvl6YMvvBfxqKxZj+vRz
         uCHg==
X-Gm-Message-State: APjAAAUZDj9x1Q4n6qx3gwrmzyanEJCKbGY5rb/wHlkl6f/zxEyCf5rZ
        oPGtJj7wjYxgJZY2fQDYGQ5jMIT0lHlIruaw+2c=
X-Google-Smtp-Source: APXvYqxndfPI6I8w/tvAQmV9Dtk5i0gBHwsSRJm1EqmauEHeTc4TDaN7u3Fo+4dCf62AxDcb57QL88TcdZ424/tcYQg=
X-Received: by 2002:a17:906:1ec6:: with SMTP id m6mr25976034ejj.6.1571736496360;
 Tue, 22 Oct 2019 02:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJxDvStLi2usG_X7e8FeOSjKCXN4Yb+b_JCpUc8Y0HZ-GuTUgw@mail.gmail.com>
In-Reply-To: <CAJxDvStLi2usG_X7e8FeOSjKCXN4Yb+b_JCpUc8Y0HZ-GuTUgw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 22 Oct 2019 11:28:04 +0200
Message-ID: <CAP8UFD0PGPVwq0vWq19knuQ_23ToOG-nqbgkJuCUXswtpQe48A@mail.gmail.com>
Subject: Re: Outreachy Winter 2019
To:     Karina Saucedo <karina.saucedogza@gmail.com>
Cc:     git <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Karina,

Please see my answer below.

On Mon, Oct 21, 2019 at 6:59 PM Karina Saucedo
<karina.saucedogza@gmail.com> wrote:
>
> Hello, my name is Karina and I'm and Outreachy applicant.
> I=C2=B4m interested in applying to the project 'Add did you mean hints=C2=
=B4 and
> I was wondering how can I start contributing since there seem to be no
> issues on the github page. Thank you!

Thank you for your introduction email and for your interest in Git!

Emily posted some interesting information on the Git mailing list that
you can see in the archives there:

https://public-inbox.org/git/20191007203654.GA20450@google.com/

We require Outreachy (and GSoC) applicants to work on a microproject
before they can be selected. There are microproject suggestions in
Emily's email and the following discussions.

Unfortunately we only have a web page that we prepared for the last
Google Summer of Code:

https://git.github.io/SoC-2019-Microprojects/

So it might not be up to date but you can still find interesting
information on top of what Emily posted.

Don't hesitate to ask if you have any further questions.

Best,
Christian.
