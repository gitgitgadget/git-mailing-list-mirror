Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA15C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF74164F04
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhCPAyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:54:39 -0400
Received: from out2.migadu.com ([188.165.223.204]:44389 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232118AbhCPAyI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:54:08 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1615856047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjox0GEF3cDmv9hUUIEKgbRVfFeEY7Nkce6zMBoY3ps=;
        b=lPleuAx5xXlNs+S0/e8aRa4i0+7YM6PGPJZH/qL9EYgHHNpoI35mRmS9ay4PAaPwQ1EG/a
        jfo9JAZ2GVzg6q6xFt2Eq5K44gv+ojqoTT0gehC0IHUijxh9OCkxE6eRktPZZSfSqTL5UW
        hDjxz11peTm1uM4LedRZBSb9KxZwLMJRYJVedOXTnIFlpcedwg3ziRAPfU9aLAej9MFuS/
        romxUrA+yTyyr2Zd1cRd5RmmdgSIfouFlwWUwGHcdsa5T5SaFqf8dTtH2l1hmDME29HN6I
        BzgQ+u3yAqLDCuwy5EUNkY8jSMPPDLluUTfuV+7gj9s3n8qrjjVudQMX5X19vA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 15 Mar 2021 20:54:06 -0400
Message-Id: <C9YD5W192LX4.3I9ZGX9EROFL8@taiga>
Cc:     "Jonathan Nieder" <jrnieder@gmail.com>, <git@vger.kernel.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
In-Reply-To: <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Mar 15, 2021 at 6:01 PM EDT, brian m. carlson wrote:
> All a URL can tell you is literally where a resource is located.

To further clarify: a URL tells you not only where to find a resource,
but how to access it. This is the purpose of the scheme field.
