Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298A31F461
	for <e@80x24.org>; Sat, 22 Jun 2019 09:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfFVJyn (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 05:54:43 -0400
Received: from forward501p.mail.yandex.net ([77.88.28.111]:57633 "EHLO
        forward501p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbfFVJyn (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Jun 2019 05:54:43 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jun 2019 05:54:42 EDT
Received: from mxback1o.mail.yandex.net (mxback1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1b])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id CF6673500401;
        Sat, 22 Jun 2019 12:46:51 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id WEQljzWRsg-kohiIacA;
        Sat, 22 Jun 2019 12:46:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1561196811;
        bh=llBMLxE33lhSLeeNuryf8fcXaQwYZw4OjSCXLHEQKtU=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=WAS6VA++Dw8uqyjdKLDYfV86FzkNtdVG2Ot6LOGTqWRQLMZlQZM6635E28bNPEUmp
         E7ngATbC9BUXQQ5gHPJOPq2uLb2hmmGBs/F4KSePfQloWm/Z1vcqks6fyLBtOgRls0
         3/H9DzJDJB7sMwmWWhozZ/isXL8Kd8dxmKC0weHM=
Authentication-Results: mxback1o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-7b909973f402.qloud-c.yandex.net with HTTP;
        Sat, 22 Jun 2019 12:46:50 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     luke@diamand.org
In-Reply-To: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
References: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
Subject: Re: What's cooking in git.git (Jun 2019, #05; Wed, 19)
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 22 Jun 2019 05:46:50 -0400
Message-Id: <1748011561196810@sas2-7b909973f402.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

20.06.2019, 00:35, "Junio C Hamano" <gitster@pobox.com>:
> * am/p4-branches-excludes (2019-04-02) 8 commits
>  - git-p4: respect excluded paths when detecting branches
>  - git-p4: add failing test for "git-p4: respect excluded paths when detecting branches"
>  - git-p4: don't exclude other files with same prefix
>  - git-p4: add failing test for "don't exclude other files with same prefix"
>  - git-p4: don't groom exclude path list on every commit
>  - git-p4: match branches case insensitively if configured
>  - git-p4: add failing test for "git-p4: match branches case insensitively if configured"
>  - git-p4: detect/prevent infinite loop in gitCommitByP4Change()
>
>  "git p4" update.
>
>  Is this ready for 'next'?

Junio,

I haven't got any new feedback on the patch series in the past 2.5 months.
From my point of view, these are ready for next.

Thank you,
Andrey.

