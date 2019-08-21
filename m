Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9321F461
	for <e@80x24.org>; Wed, 21 Aug 2019 14:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfHUOCJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 10:02:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37843 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfHUOCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 10:02:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id f22so3088989edt.4
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 07:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=m18rRLEjNc4X6x8Ap0F7UBR6sGvD75/5cM6KBxPd798=;
        b=Kq86u9/akaif6Qq1i3zwjuwJurYKNlsNOUWxL7O4zY/8hQidx+EXnc1GrHFE8PUcve
         0EFAbjqrpx2ncOUhggeFX5XdSdHh0RelFTDyipBkfpS69ePwWeV7zbSYeiUqemBixbsP
         CLEJ6VkUNu5Eo9eH2qFq/Ve84iJzuAfV/kuBOh/rrBeTRAAH5EbUXvk5XksxFeW/tmJB
         MGzL2PPbG5aC7Y+wZGzgaHav5C8QC+/LUTUcg9M91Aa9G8GN8oAK6xVAiKvLks4Neta5
         RsKnFhqUtpF+rtEhb+44upqseruUqpm9uyFSl2IkKd2lUUUon+H6L36BUj0MGeJ8JW6C
         XY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=m18rRLEjNc4X6x8Ap0F7UBR6sGvD75/5cM6KBxPd798=;
        b=KWhZpj5D7+2XPvhu2QMXQ+COgux7Q68T3GhDr6uyiuJMPbg0vVF/cdkWMrgFT3ZYHI
         0H5lBhrcZFN5eM2VGWnXBRbD4HQhpVWEHmhvbGYLvCwIl6BvVHWKXwYf86YAD9VyuKkH
         vrOCT2lTANuCrQZ6l4Pbf5d/g5nMd9xgJKXuE6IULNAUyVFsVEdqtKCG4dKxOfcSU11X
         6JK4iX0K/kTDCREmck3X80scPb30il0BaprlMdBUSRTFl+tSSyJOCbFJ0GuswtUYzrfn
         Wv5skVBVc2Dr98wKkzjHuRHEwB3T+ltMY8BSzrq7gBB+3JgFNajvDJ0acLk80TdbTpWe
         uGxg==
X-Gm-Message-State: APjAAAWp+jPuzV5xnz9V95rHkd6zIjSECCMFMc4adUKM4HN3zhbiQLD1
        W61FO5liTVi37ysL/+PUUEzUB1VCJe4JmB69m8nxnyRY
X-Google-Smtp-Source: APXvYqxw+o5wa0RLpnj7bQwIeDMridJ92y28h9rS8C+EQ1e3cdd8POGjbDHjOVUlxmEB7WEhjtkCJBT5g2y/7PVVJyw=
X-Received: by 2002:a05:6402:759:: with SMTP id p25mr36610725edy.119.1566396126815;
 Wed, 21 Aug 2019 07:02:06 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Aug 2019 16:01:54 +0200
Message-ID: <CAP8UFD3h=GNEFbVUWKBMpYFUNqOaDCkxyeq5Vu2kGst_uBE0eA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 54
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Andrew Ardill <andrew.ardill@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 54th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/08/21/edition-54/

Thanks a lot to Elijah Newren, Jeff Hostetler, Andrew Ardill and
Jean-No=C3=ABl Avila who contributed this month!

Enjoy,
Christian, Jakub, Markus and Gabriel.
