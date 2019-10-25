Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C7C71F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 16:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439159AbfJYQic (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 12:38:32 -0400
Received: from forward501j.mail.yandex.net ([5.45.198.251]:46677 "EHLO
        forward501j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390697AbfJYQib (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Oct 2019 12:38:31 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2019 12:38:30 EDT
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1d])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id C0DDA3380553;
        Fri, 25 Oct 2019 19:32:11 +0300 (MSK)
Received: from unknown (unknown [::1])
        by mxback3o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id xlEqvZL4eb-WABeC892;
        Fri, 25 Oct 2019 19:32:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1572021131;
        bh=rDMJlKXlXYmZqUSBA2NlJKtGpk/OhXhuSYOHQE3LB7c=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=assCynk0eXljwTYT4wCylXYPL8CzKF8Z9y2KBuXGPFaDZLIw25AyBSBg8K57U58Hs
         6NjexKIY/LQyHzlxTex1eMzPJ7o3sQizydOtW6MgIkLbuUoOJLUPzA1l4GutUUcLSp
         oWXeVDRa6CNpI5dwE+CRqCdF9ILSv1zytbOdV4+Y=
Authentication-Results: mxback3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva7-56e9317134d0.qloud-c.yandex.net with HTTP;
        Fri, 25 Oct 2019 19:32:10 +0300
From:   =?utf-8?B?0LHQtdC3INC40LzQtdC90Lg=?= <mykaralw@yandex.ru>
To:     Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <b9e29a2f-494b-eebc-a3ee-2a2ed4967d7e@iee.email>
References: <22757761571993594@vla1-d97dbca235a9.qloud-c.yandex.net> <b9e29a2f-494b-eebc-a3ee-2a2ed4967d7e@iee.email>
Subject: Re: .git/binary
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 25 Oct 2019 19:32:10 +0300
Message-Id: <24796381572021130@iva7-56e9317134d0.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Or were you thinking of some other meaning for "files stored in a single (current) state"?

It means that new versions of files located in `.git / binary` will completely replace old versions in history, and therefore will be in a single (current) state in history. What used to be another version of this file should be ignored (very useful for PNG, JPEG, PDF).

-- 
Территория без имени

