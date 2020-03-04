Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE764C3F2D7
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542D321739
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LMzcXLio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbgCDLwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:52:12 -0500
Received: from forward501j.mail.yandex.net ([5.45.198.251]:54973 "EHLO
        forward501j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbgCDLwM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Mar 2020 06:52:12 -0500
Received: from mxback7q.mail.yandex.net (mxback7q.mail.yandex.net [IPv6:2a02:6b8:c0e:41:0:640:cbbf:d618])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id 2B0BC3380B7D
        for <git@vger.kernel.org>; Wed,  4 Mar 2020 14:52:10 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback7q.mail.yandex.net (mxback/Yandex) with ESMTP id RXDLFTwpNa-q98KwnvL;
        Wed, 04 Mar 2020 14:52:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1583322729;
        bh=b+bPNBu/Zk0yLzgj8SX3MNz2cR7W1tsvDfLWwhbnofw=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=LMzcXLioIPwg3RcCRdJRea9U1gaSt9kyxHEi3KNRLi9EHD5KVqIL5LeV+DK96xJdb
         KqAlqU/8qR6HRwCXFVUWv/PzjWvKPHFjSn0ZmYnmTCNB4+sS1FahR/CNGJ3uWvyOI4
         uoimKJO6vt54KQxdcL5NjUsInilH3rk0OeVofnNE=
Authentication-Results: mxback7q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-b1f71bfb4f06.qloud-c.yandex.net with HTTP;
        Wed, 04 Mar 2020 14:52:09 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <1223101582917647@iva6-161d47f95e63.qloud-c.yandex.net>
References: <1223101582917647@iva6-161d47f95e63.qloud-c.yandex.net>
Subject: Re: `git log --full-diff --follow`: conflicting command line arguments
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 04 Mar 2020 14:52:09 +0300
Message-Id: <22014821583322729@vla1-b1f71bfb4f06.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



28.02.2020, 22:20, "Konstantin Tokarev" <annulen@yandex.ru>:
> Hello,
>
> Combination of "--full-diff" and "--follow" in git log arguments causes following error with git 2.25.1:
>
> fatal: --follow requires exactly one pathspec
>
> This message is certainly misleading when git log is applied to a single pathspec. Bit it would be
> useful to make this combination valid and show full diffs for followed history of particular file
> (when -p option is also provided).

Any thoughts? Can it be considered a bug?

-- 
Regards,
Konstantin

