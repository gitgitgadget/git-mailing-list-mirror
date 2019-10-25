Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422AD1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 18:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfJYSqz (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 14:46:55 -0400
Received: from forward501o.mail.yandex.net ([37.140.190.203]:46237 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfJYSqz (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Oct 2019 14:46:55 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2019 14:46:54 EDT
Received: from mxback18j.mail.yandex.net (mxback18j.mail.yandex.net [IPv6:2a02:6b8:0:1619::94])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 1AB6B1E804B6;
        Fri, 25 Oct 2019 21:40:13 +0300 (MSK)
Received: from unknown (unknown [::1])
        by mxback18j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id uOcZdEHFES-eCwiuTNB;
        Fri, 25 Oct 2019 21:40:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1572028812;
        bh=beDOUePBmP0dAtfqIujwe/IUcCO3OqsCHTVvIcnXaJk=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=IV4toUU8a/c79XsN2ygUUjD6EH4z7FD5XZtEPSnxPNM2uTG/jWMkQ/aNMgq7TDfMs
         UzejPSoQCuCmb4/TDq770X0ipvQdRfe08q/IOYveG2Oe85mjKQKQx0bh7Yxq3ppuyE
         3NdT9F9jFnwwKof5pP6XPniRIefkk3NE8fjhaIrQ=
Authentication-Results: mxback18j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-1c82b59a1818.qloud-c.yandex.net with HTTP;
        Fri, 25 Oct 2019 21:40:12 +0300
From:   =?utf-8?B?0LHQtdC3INC40LzQtdC90Lg=?= <mykaralw@yandex.ru>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <20191025180533.ed6du6weja2wfx6c@yadavpratyush.com>
References: <22757761571993594@vla1-d97dbca235a9.qloud-c.yandex.net>
         <b9e29a2f-494b-eebc-a3ee-2a2ed4967d7e@iee.email>
         <24796381572021130@iva7-56e9317134d0.qloud-c.yandex.net> <20191025180533.ed6du6weja2wfx6c@yadavpratyush.com>
Subject: Re: .git/binary
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 25 Oct 2019 21:40:12 +0300
Message-Id: <24145781572028812@sas2-1c82b59a1818.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Something like this might have trouble working with checkouts of past
> commits, which is a major reason (at least for me) for using a version
> control system.

Good. If such a mechanism seems too problematic for you, then suggest another mechanism for resetting the history of a specific file. Alternatives are even more problematic. If the file placed in the list I proposed will go into the git history only as a link without checking and calculating the amounts, then isolating the file included in the history will change all the amounts.

-- 
zvezdochiot

