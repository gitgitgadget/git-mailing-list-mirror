Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA431F462
	for <e@80x24.org>; Tue,  4 Jun 2019 21:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFDVNr (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 17:13:47 -0400
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:60650 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfFDVNr (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jun 2019 17:13:47 -0400
Received: from resomta-po-12v.sys.comcast.net ([96.114.154.236])
        by resqmta-po-05v.sys.comcast.net with ESMTP
        id YBFBhwsrPF9fpYGkdhJ7Hb; Tue, 04 Jun 2019 21:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559682827;
        bh=VkAfNHsvBq0/v+oGlJBsDDd7fLimhakvWreD6+FvDg8=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=HJ34MR+mUjK8qOyKCnRVBUpfy8xbhG/ZcFK+bbwOZmIEUnD613Sfz8ZB5iZyvRQmm
         nXiUEZU4xdBB1dzXlBVGNh1qcWzAkftAMu3l7JfphGcU+4mgPACj2mYg3/e5ByaJS3
         4BaJ2dCjnO6O0mK/80U/pOXEG+kcWrTxPrv9tJ76v1N6oHGJIZavQYZkO+N82PWFfY
         Hm7WBo+Kub/X/mDZY8EHCLdMly+gkdr8q3mosnKpQX+tvr6bMcs5CnLoGAI6W425pF
         lcOSWmJ+k4UhFu8We0QpKLi/wJHX1YPQg2ZYceq5zbJZIclC6zCZBsXvlxKV2XcoxV
         B7f+HI0xXrRvg==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:f95f:aa00:d2b2:a5dd])
        by resomta-po-12v.sys.comcast.net with ESMTPSA
        id YGkahakNfT55RYGkbhV8M1; Tue, 04 Jun 2019 21:13:46 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Tue, 4 Jun 2019 14:13:44 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jeffhost@microsoft.com, l.s.r@web.de, gitster@pobox.com,
        spearce@spearce.org, jrn@google.com
Subject: Re: [PATCH v2 0/2] Harden url.c URL-decoding logic
Message-ID: <20190604211344.GM4641@comcast.net>
References: <cover.1559670300.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559670300.git.matvore@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First message had incorrect recipient list. Re-sending with non-typo'd Jeff's
e-mail address.

Someone also politely reminded me off-band that I should make subsequent
versions of patchsets be respond-to on the cover-letter of v1 of that patchset.
I will do that from next time.
