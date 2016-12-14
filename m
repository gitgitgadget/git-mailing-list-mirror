Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B751D20451
	for <e@80x24.org>; Wed, 14 Dec 2016 06:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbcLNGAq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 01:00:46 -0500
Received: from mail-wj0-f179.google.com ([209.85.210.179]:34740 "EHLO
        mail-wj0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbcLNGAp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 01:00:45 -0500
Received: by mail-wj0-f179.google.com with SMTP id tg4so14649275wjb.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 22:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=9Zlx6CZWNgbv5OD41g5W5KQwwwYSmd1WYrIVfKHkgV8=;
        b=wK0MWBe2Yh3qBalreoCIagft2zoeLZ/xKT7zDbhKiwGapDriZa4JMsH0MSI2n/fHAP
         tZwqeCgTQGddkPSLIbc5sH0qw8DjxB3iXko9zBFSRzbJPA4bb9sVVOZNUH34tcvmlH6V
         L4RC6yEzt9twDCQxlxph1jDte1RbpdZbuxJoULA9chwFnKj3qLMyLOXAH52pUnlp4bJb
         GOPTF60ZZUj9Dn3TiEdYfwUjjV9b4kJfAS52FxGMJ53lg4w2ff6FwKJKDAdLMN9j4GSO
         GEPkfrM7gtigvdljXD6VqahntUFEtPaOv6WXIJO6whLvSUGrz0NHR6xF8h9XQ44+SP/i
         8KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9Zlx6CZWNgbv5OD41g5W5KQwwwYSmd1WYrIVfKHkgV8=;
        b=EoyAx6Vdz1ecQYa9c750noSMVI3N61IqLiCdWrLGP+JN4YA5JbjVfAfcu6IiM3Y7sk
         lRxJtIDISnm/xg0GGky2dhF6iiG6jdJzqUFoCSU0mJjigzJv8Q4HQgcZ99cESO+0ti5N
         UNRhyC3XNTZN7+pUrFUMRavdYDONR9xHcqMq9Ij7vkqjHY/hcZ8ynr1hWyD/bjmS1/Qx
         e4vKkbMc5sG8t1eLpuSvXRlqpxs54ku2M9U0lIgrWCg0LbU3kjNKj9i9Y3qnZqlMK/S5
         NLkRn7B3LeJHyAGUkMO/hVj8IaDnTlmHThgx7/wBj30c6bAmlLRDf9CTg72rkiog50S9
         qlMQ==
X-Gm-Message-State: AKaTC00HS8F2h4Q5GXhOsVyKAuyBEVPQ5u3dK+6u2MhynQpIKk1sj0KXpMQgY9vF9ft+HrtqQB2lJ8QqX1fg+g==
X-Received: by 10.28.26.80 with SMTP id a77mr5292135wma.31.1481695243115; Tue,
 13 Dec 2016 22:00:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.26.232 with HTTP; Tue, 13 Dec 2016 22:00:42 -0800 (PST)
From:   essam Ganadily <doctoresam@gmail.com>
Date:   Wed, 14 Dec 2016 09:00:42 +0300
Message-ID: <CADo08-pBPVShFDSbOuk-12KUQL7t7ajG17-A6=UCrUVk+hcNtA@mail.gmail.com>
Subject: Creating remote git repository?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

given that git is an old and mature product i wounder why there is no
command line (git.exe in windows) way of creating a remote git
repository?

"git remote create repo myreponame"

frankly speaking i know that our friends in the linux kernel project
never felt the need to create remote repository because they probably
rarely need that but i guess their merciful hearts could have some
feeling for the rest of us?
