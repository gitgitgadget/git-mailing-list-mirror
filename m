Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324931F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 01:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441920AbfJRBDZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 21:03:25 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40604 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438932AbfJRBDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 21:03:25 -0400
Received: by mail-ed1-f48.google.com with SMTP id v38so3250763edm.7
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 18:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ZE5BBoYQO0HQMSOpUcPPjK95wvlFyE43kZjtoOnmEZ8=;
        b=WVmdzQe1iJv5SWtRsgBZxIstePSHfeVxNuqy7rcWYGVvQb3qnJmFmTBhb25cbaSoVq
         JwFYSFCwm//CNSOytzjrQgXFJ1aM25alnQH4BdAJOQRigJQLAXp/OKV1/2UdFWtGWaME
         kd4qAqyesheVZU9heyKcOJzUpfv1wnoskih8rEQmx+a1qcKGkTE5XhOYRDB81c+65yZs
         FkQk7kQKfdpfHx1sj0Hh6gVCXc83OhTuhhD4UmKgprygc89ruj9SvwlX7Lyb7plfKHB6
         QmcskmPgN9DEHXTQHDr0VPp/g85WVlQvpQO7KJIx9ZwNkiuWIqH9bSqx/cEaRsplJEbe
         /5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ZE5BBoYQO0HQMSOpUcPPjK95wvlFyE43kZjtoOnmEZ8=;
        b=nVRaClODsNGjRcFNLRUZ8U7d6pOC6HF5X1XOHXQH53+JS19rYcF5L4lULBIXAsW6bV
         gBONAI/K2qMHuMmkyRIp+VWH28dkO6ZeGzVrgsNcxor/m+f81u8OtI8BMiM+hWiMsvKB
         O9Y6goD6VeyOrQBV4pRngcXHrs4efvvi1aZwoTEMGV8jARFy06WQmE0wuELeGsiI9l3S
         vSLAa9HbudHcrgrAGQ4eM6YgdS2cpJNomorrUHXA2Xw5hmxsonMEqyqqKDZEe/XQmlbV
         syox+Bz7BGjZM07TtNBmLc7ie017nVEHI+3OYpVV5tbxBxZ8Z18OSCiMoN2q9d0jWATq
         m5bA==
X-Gm-Message-State: APjAAAWWdif1z4NP303cQVczyHh18XqgKUUbtbuuyu23OKJm+wvOoMJb
        vQYVgVXW6/lHVUlnB+8rgQ64Gmvj+bECBFYBP4FhUHTME4A=
X-Google-Smtp-Source: APXvYqzJZyQVrRv6+4h27AzeP4gaX0+NmV59wVqeAJj6R51tkgXjsBECwfl2Zh0CMOGuBxC7QQc3nFMGwPl1eTO7x84=
X-Received: by 2002:a17:906:7c57:: with SMTP id g23mr6384651ejp.116.1571360603159;
 Thu, 17 Oct 2019 18:03:23 -0700 (PDT)
MIME-Version: 1.0
From:   Heba Waly <heba.waly@gmail.com>
Date:   Fri, 18 Oct 2019 14:03:12 +1300
Message-ID: <CACg5j25riLDN2H8U_ZLE2xJLYwK7LDYXs0X3nirejpn8P6i31w@mail.gmail.com>
Subject: [Outreachy] Intro
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

My name is Heba and I=E2=80=99m one of the Outreachy applicants. I=E2=80=99=
ve selected
the =E2=80=98moving the doc to comments=E2=80=99 microproject, and I=E2=80=
=99ll be submitting
several patches addressing this area during the next week or two. The
first one is already out there waiting for feedback (yey)
https://public-inbox.org/git/pull.405.git.1571357219.gitgitgadget@gmail.com=
.

I=E2=80=99m looking forward to working with you all.

Heba Waly
