Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FB7C433E6
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A288F20674
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbhAZWAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:00:31 -0500
Received: from forward100j.mail.yandex.net ([5.45.198.240]:34801 "EHLO
        forward100j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbhAZR1D (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 26 Jan 2021 12:27:03 -0500
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 7BD3950E2AEB;
        Tue, 26 Jan 2021 20:26:02 +0300 (MSK)
Received: from vla5-37f61b527e71.qloud-c.yandex.net (vla5-37f61b527e71.qloud-c.yandex.net [IPv6:2a02:6b8:c18:341d:0:640:37f6:1b52])
        by forward100q.mail.yandex.net (Yandex) with ESMTP id 75BD77080002;
        Tue, 26 Jan 2021 20:26:02 +0300 (MSK)
Received: from vla5-47b3f4751bc4.qloud-c.yandex.net (vla5-47b3f4751bc4.qloud-c.yandex.net [2a02:6b8:c18:3508:0:640:47b3:f475])
        by vla5-37f61b527e71.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 5lXib2ETWX-Q1G4Z3Wj;
        Tue, 26 Jan 2021 20:26:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1611681961;
        bh=gbIr7GEB2Fr5NpKrkUibDOLnah1rJjb6sMNs98pLKmg=;
        h=In-Reply-To:Subject:CC:To:From:References:Date:Message-ID;
        b=LdXq93kfhuRPs3cn4WfJ1JIrXUmOFKeBqly+9R31KBKkyDcw7a/yCfa1fMyCkb14e
         GN8y1F9L99eV5Tk5deE41cQ6i1agQOEGknp514KhT2jKJTe4GaVkRy09KvHWLYqKoq
         p8KPR32nd2TpXIzKWkQpaXeSSYV9xzl1+IImwf1o=
Authentication-Results: vla5-37f61b527e71.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-47b3f4751bc4.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id m1UIaxY6Z8-Q0nenf7Y;
        Tue, 26 Jan 2021 20:26:00 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Tue, 26 Jan 2021 19:26:00 +0200
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <789931525.20210126192600@yandex.ru>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
CC:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Can not rebase to first commit
In-Reply-To: <CAHd-oW6=CFNGyW30pDhjwgwMcDFeqFoad=J6DkHruaeA75SzCw@mail.gmail.com>
References: <1327609829.20210125123816@yandex.ru>  
  <CAHd-oW6=CFNGyW30pDhjwgwMcDFeqFoad=J6DkHruaeA75SzCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for all.

I always thought that 1e99034^ means: including this commit

Thanks for help

