Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B57C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92402072E
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0fxx7zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgC3S3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:29:13 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:33945 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgC3S3N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 14:29:13 -0400
Received: by mail-ed1-f44.google.com with SMTP id o1so3744451edv.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=C9yud0kHliyn1IfsQSbujJGfae58bvqJ6XX1nqfzifE=;
        b=d0fxx7zgq+5ayc4z5C5MiaeVBudJbqr+LOduK/iLvknn1BGqj2F/U+8KKU9iKfeWj+
         iWLnDitaHy2JUMZVmgb+uGCm+krO5ZDSudnwgamYyuw1sQlS3zIZ23mg6VctWbxoPguC
         94nNRce3nr0kOGUUEbW0IOFmvAWQbL27yModDCRm19sJXDBsRQfYVyEGk7MBpfPemNBY
         hT7uH5ryTFFh7CDFFRhuU5DRgyTZ/vfNWEvazvSZNLOXbv2cXQDC5WVMMWcJglRf3q1+
         CHugnJk4iI6d/6eRwgNN0cjNKPTPnbcgpczcf02/oa4wV2Hiuk9kaBRskYSF5OpC1nTB
         ft6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=C9yud0kHliyn1IfsQSbujJGfae58bvqJ6XX1nqfzifE=;
        b=MYAWgff6yN0rfHbHfgXc9/IYT3DQ1FDBLR+sxOWl+ka17FtLnJj/Y9HvfcQ6UDVjus
         faODvjhuvReri/rW8TtaYvs6RXMpFdQu3Om0bl6CQxkt1ekTJe/HQBFHU7enlltkR25n
         /R7qCtzAMFZmcSYH6i9712roejzX73dMuisKTzHQpp+QiveSEj4n4QEfAkgmjaTrwUo6
         Tdip7mwtT6ZclAlERc8uX8fXnQwB3zQyKV7Wbt30I0o3YSLpTBij1NAORgVG+Se8Ga3z
         VpmRpH/XyqrDxBOb9gqeYFKjswZ28HOtajqQhTmO95Rx0C+x9teLCYAR8BjwsKfn9CJa
         qb2A==
X-Gm-Message-State: ANhLgQ12BvbpaltVePAhiAp0F5rZNgrHtk7av2lai4CqwzseVWt7qMHp
        Z+2iMIpJxflRT9EaJo2NgWgIKlUKbJKsobQYLZeicSEVvrzqLQ==
X-Google-Smtp-Source: ADFU+vtsib6YADbrvFCAp435GPIgyy8588IOf2jshNWSpfe3b68nS0kMYhTw0UpI+YhZp3SsdG7ApFRYp5armSZg49w=
X-Received: by 2002:a05:6402:1d81:: with SMTP id dk1mr12320811edb.97.1585592951305;
 Mon, 30 Mar 2020 11:29:11 -0700 (PDT)
MIME-Version: 1.0
From:   Abijith Warrier <abijithwarrier@gmail.com>
Date:   Mon, 30 Mar 2020 23:58:35 +0530
Message-ID: <CAEqxzjCeJ-9vuF9rb9HKvfaOc58GT0r7XXp4rAzetOrxjPmYvw@mail.gmail.com>
Subject: Re: [GSoC] Extension of Microproject deadline.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I am Abijith.
I am interested in participating in GSoC with git this year. Due to
ISP issues I couldn't come online for several weeks, hence I couldn't
finish microproject. I am fully aware that a student is required to
complete microprojet before being considered into GSoC program. I am
here to kindly request to all the mentors a extension on the
microproject issue which will be done in coming days. Meanwhile, I
will prepare for my proposal & its draft in few hours.

P.S: I am really sorry about making this last minute request.

Thanks in advance.
