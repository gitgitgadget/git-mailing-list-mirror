Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2777C20248
	for <e@80x24.org>; Mon,  4 Mar 2019 21:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfCDVsj (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 16:48:39 -0500
Received: from mout01.posteo.de ([185.67.36.65]:48247 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfCDVsi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 16:48:38 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id BBB8416005F
        for <git@vger.kernel.org>; Mon,  4 Mar 2019 22:48:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1551736116; bh=IDvZfIwXzFu48m0QOtUto54TiEM094YY+mILpkbP7CM=;
        h=Date:From:To:Cc:Subject:From;
        b=TkOE53bfnA8znCK8g3uwsH0bdt89mVZxSqsgPiCKqRe9+Azp0a+Z5lUqPC7L7zokP
         PzvQrS4FNz60z0+gA5OCnhrDRSADo0f6CmApHFCxKsXa+pWW9nCVBShaZfA9AP48YK
         ifkGJju/k7LhrOPckwYJXGFT5A7tjiy34UnQ4IfuZRxW55RvQwkUPaKdIZYoGLn9Li
         NELmYt+8Xc5JpEkfBmAr5THv3SrGYtzPK83yXmrCVS2x/J31cVj3DvMei7PNkHtRem
         QlzVdzx9300z52Oj1jZMYgBl8kmDAo4ZRHgTqZS9Meg98nS3/pTKpvszt/mOKAwsxw
         6IE+0uOduw2Aw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 44Ctv64hdDz6tm6;
        Mon,  4 Mar 2019 22:48:34 +0100 (CET)
Date:   Tue, 5 Mar 2019 08:48:30 +1100
From:   asymptosis <asymptosis@posteo.net>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     git@vger.kernel.org
Subject: Re: Can't build first git commit
Message-ID: <20190304214829.GA573@sleipnir>
References: <1551729517.4092.1.camel@libero.it>
 <20190304201011.j7dopqp6ug66ccum@LykOS.localdomain>
 <1551730792.4573.1.camel@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551730792.4573.1.camel@libero.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 09:19:52PM +0100, Fabio Aiuto wrote:
> What a pity, It would have been very useful for me, to debug around
> that simple version, to understand how everithing works.

To understand how Git works, it is a good idea to work through the "Git
Internals" chapter in the Git Book:

https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain

To help me understand that chapter, I started re-implementing Git as simple
bash scripts, which have been placed at https://notabug.org/cryptarch/sgit
