Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEE8C433E6
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6DE6024A
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhBKH76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:59:58 -0500
Received: from mail-ej1-f41.google.com ([209.85.218.41]:45307 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhBKH7V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:59:21 -0500
Received: by mail-ej1-f41.google.com with SMTP id b9so8553825ejy.12
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBZZrfKB+aR8M+7OS8QNeNSV/ywbZSpxQCmJNgDxqH4=;
        b=lMceeyAWUlL/7BrdY/jI5Cq8LxBV3YSfxfldtUDQC7uK5Q3rmK+SpBQXpKDW7uAB92
         l8KVEneVvN/pS6rXA9JSWSY7NzdPZdqaFYLNEw1nx6JAAGlNvY0o9FXjmVUu4JA4hFI4
         Z2ZdGd02IlGAoaUjtjXDXTB7UCDQD8ArmP5fzXdvJSGKokL5dC5e4BYuJqoV166HPg0O
         zCdanVbo4x7feCgPO9MjIveWsnSdX5gYeygUTJQbBRn5D6/JZSIncZ8WM9agPPSapJtu
         eRUS0vSxvPIstbDHG6OYSDMJFRy2IUT+3D0KiktSHJT0b8Y6k7XHbpU4lhTaSpT/tEa2
         jvuw==
X-Gm-Message-State: AOAM530B/6Xj1Xsddh3mADLjYON1NSoUywDuykcXonf0jWbU/mTcWE98
        roBcOaMp08XudWigyaJ/p0HiFvTcJvZJJNzkvT8=
X-Google-Smtp-Source: ABdhPJzh6E6lehZFZsImtab00+kqBgyOER86OhZFWYcMChwDRf3pO/idvTIEwrGM972xuU6o1MPnuRkVgneY3aYK5jU=
X-Received: by 2002:a17:906:6d94:: with SMTP id h20mr7247474ejt.231.1613030361756;
 Wed, 10 Feb 2021 23:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20210209173254.17712-1-shubhunic@gmail.com> <xmqqy2fwyhjy.fsf@gitster.c.googlers.com>
 <CAPig+cSXi7Ct48gqkBVvBtOm6bMqDhPcxXeiK3ZytAitZXNT5Q@mail.gmail.com>
 <xmqq35y3ys0w.fsf@gitster.c.googlers.com> <CAD=kLpvfAz7wkvBfakbc6woNWdyOxrYn0XKgSPkmTNz2RCNkKw@mail.gmail.com>
In-Reply-To: <CAD=kLpvfAz7wkvBfakbc6woNWdyOxrYn0XKgSPkmTNz2RCNkKw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 Feb 2021 02:59:10 -0500
Message-ID: <CAPig+cSczM3i585_epR4HQ0AfB1qz_9uBbAk7E8TdO=htk-=4Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Modernizing the t7001 test script
To:     Shubham Verma <shubhunic@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 11, 2021 at 2:56 AM Shubham Verma <shubhunic@gmail.com> wrote:
> Sorry I forget about spelling.
> Okay I will correct it and send a new patch series today.

Please remember that the spelling of the author (From:) and
Signed-off-by: should be the same.
