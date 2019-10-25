Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 992F71F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 21:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfJYVdW (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 17:33:22 -0400
Received: from forward500j.mail.yandex.net ([5.45.198.250]:45835 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbfJYVdW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Oct 2019 17:33:22 -0400
Received: from mxback11g.mail.yandex.net (mxback11g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:90])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id EF94111C2A83;
        Sat, 26 Oct 2019 00:33:19 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback11g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Nrme3PWVdh-XJKW1EMF;
        Sat, 26 Oct 2019 00:33:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1572039199;
        bh=KFiftoNjBOP8Ee/g5ahGgYkExkJfoDWslTGqlEuqWSI=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=lK4pmmLCSXwizZhvGq12m1g5OT88DMKL05TQOYxqU3GRWyM5vZ8JDU7xO2+6XADz5
         Hjpek2tFVrHzzk4l5X+zrawhQ7KA+pXYXb21a8ykfGj9fgms46Iq4N13w60jPfkDuz
         0660S5LLdzZHBtQ82oGi25Y4Cjp0COJkM1Vrmq2U=
Authentication-Results: mxback11g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva5-58d151f416d2.qloud-c.yandex.net with HTTP;
        Sat, 26 Oct 2019 00:33:19 +0300
From:   =?utf-8?B?0LHQtdC3INC40LzQtdC90Lg=?= <mykaralw@yandex.ru>
To:     Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <5f558e34-bdb2-6656-d2ca-42a2d7cb8874@iee.email>
References: <22757761571993594@vla1-d97dbca235a9.qloud-c.yandex.net>
         <b9e29a2f-494b-eebc-a3ee-2a2ed4967d7e@iee.email>
         <24796381572021130@iva7-56e9317134d0.qloud-c.yandex.net> <5f558e34-bdb2-6656-d2ca-42a2d7cb8874@iee.email>
Subject: Re: .git/binary
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 26 Oct 2019 00:33:19 +0300
Message-Id: <25196441572039199@iva5-58d151f416d2.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The main advantage of Git is that it distributes control from some central 'manager' to the individual and does that by taking snapshots and exchanging verification stamps, so the idea of deleting history feels somehow 'wrong', hence the need to understand

I perfectly understand that by removing information about the file and its changes from the history, I will “delete” it completely. Git needs changes to work. That means you will need an additional utility file, for example, `.gitshadow`, containing the sum of the files in the list. And this service file will already be reflected in the history. Moreover, it must be to process in a special way.
What is this "all" for?
Too much that is in `git` is completely useless to anyone. This mechanism (if it is implemented) will not be needed by everyone, but those who need it will be very gracious for freeing useless the mountains of  trash.

-- 
zvezdochiot

