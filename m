Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D17211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 14:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeLEO2L (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 09:28:11 -0500
Received: from forward101j.mail.yandex.net ([5.45.198.241]:50539 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727142AbeLEO2L (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Dec 2018 09:28:11 -0500
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2018 09:28:10 EST
Received: from mxback23g.mail.yandex.net (mxback23g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:323])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 118972E812C6
        for <git@vger.kernel.org>; Wed,  5 Dec 2018 17:22:19 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback23g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Tag71esnBH-MJaWgGNR;
        Wed, 05 Dec 2018 17:22:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1544019739;
        bh=fw8N4N+QJkxtJU6JxpAriHEWBocrkooqH4UpXMUTK44=;
        h=To:From:Subject:Message-ID:Date;
        b=TVIJGKW7lWcHV4VMj2MRd2BgeRIRUR54GQsJXd6N9wEshDsMSwO04RGB5EUxUv7+k
         QYc5u4944Vh5+9Vsr4Lnm0IST1Dbt4Sz+kXwl0PciLClVQmOvVVigG34izWmqd7W+4
         abubataLoN+vmKnPDgZad2JCNLJkyMfqOjEta7y4=
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ZdiUQ9lqBm-MI3CSdDl;
        Wed, 05 Dec 2018 17:22:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1544019738;
        bh=fw8N4N+QJkxtJU6JxpAriHEWBocrkooqH4UpXMUTK44=;
        h=To:From:Subject:Message-ID:Date;
        b=Buxk19SZ2BautnuxTxCHbDB170B4cweUfx2jOiLhIPQSD7c/BQlRmODf+JqqZ7eyu
         MafhIF1WbtL6J7FUpccn76nTI27abxxlI55VcKHkc+Hvp7c1+sVi6bzkrGjmgePlIi
         25dFKRPc2ue+9+Ya3HIL6h/zKqpPAap+3eugm2QA=
Authentication-Results: smtp1p.mail.yandex.net; dkim=pass header.i=@yandex.ru
To:     git@vger.kernel.org
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: Any way to make git-log to enumerate commits?
Message-ID: <5e5c6d1c-6b3e-c94a-17be-a2af518c1607@yandex.ru>
Date:   Wed, 5 Dec 2018 17:22:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It would be great if git-log has a formatting option to insert an index of the current commit since HEAD.

It would allow after quitting the git-log to immediately fire up "git rebase -i HEAD~index" instead of "git rebase -i go-copy-paste-this-long-number-id".
