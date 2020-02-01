Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BF1C33CB3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 18:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A341020661
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 18:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgBAS7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:59:40 -0500
Received: from sdaoden.eu ([217.144.132.164]:45486 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgBAS7k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 13:59:40 -0500
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 1778316054; Sat,  1 Feb 2020 19:59:39 +0100 (CET)
Date:   Sat, 01 Feb 2020 19:59:38 +0100
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     git@vger.kernel.org
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: 2.25.0: git rebase -i fails to --continue with staged data
Message-ID: <20200201185938.ACP7-%steffen@sdaoden.eu>
In-Reply-To: <20200201183619.tUTI7%steffen@sdaoden.eu>
References: <20200201183619.tUTI7%steffen@sdaoden.eu>
Mail-Followup-To: git@vger.kernel.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.16-104-gcdb7645a
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steffen Nurpmeso wrote in <20200201183619.tUTI7%steffen@sdaoden.eu>:

No.  Sorry for the noise, it was my fault, i reversed the todo
list, and therefore, after having committed something new that
_should_ have been placed in between two "e"dited changesets,
i was in fact after them, and git did correctly point out it had
no idea on what to do with staged data.
Sorry.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
