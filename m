Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB780C3F68F
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 16:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE112073D
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 16:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfLKQF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:05:56 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60623 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731228AbfLKQFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 11:05:53 -0500
X-Originating-IP: 157.36.83.209
Received: from localhost (unknown [157.36.83.209])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C75ACE0014;
        Wed, 11 Dec 2019 16:05:51 +0000 (UTC)
Date:   Wed, 11 Dec 2019 21:35:46 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     =?utf-8?B?5Yqg6Jek5LiA5Y2a?= <kato-k@ksysllc.co.jp>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git gui: fix branch name encoding error on git gui
Message-ID: <20191211160546.m2qlxg23on7itvgw@yadavpratyush.com>
References: <20191207002842.32208-1-kato-k@ksysllc.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191207002842.32208-1-kato-k@ksysllc.co.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/12/19 12:29AM, 加藤一博 wrote:
> After "git checkout -b '漢字'" to create a branch with UTF-8
> character in it, "git gui" shows the branch name incorrectly,
> as it forgets to turn the bytes
> read from the "git for-each-ref" and
> read from "HEAD" file
> into Unicode characters.
> 
> Signed-off-by: Kazuhiro Kato <kato-k@ksysllc.co.jp>

Merged. Thanks.

-- 
Regards,
Pratyush Yadav
