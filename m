Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06AB61F4F8
	for <e@80x24.org>; Sun,  9 Oct 2016 05:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbcJIFnw (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 01:43:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33308 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753239AbcJIFnw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Oct 2016 01:43:52 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2144C2045E;
        Sun,  9 Oct 2016 01:43:51 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 09 Oct 2016 01:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=01b90zTv9WhD/2A8NBoK09jGCNc=; b=a+gVM
        CzdKjtelUmnI3w6AkfIQpCFLdz20gME4n+luOdKnTFcY3XZSxVo6IyjkAv5HsZx5
        s9nN2qnD4llpGgEshJBpxq0vXWadsuburkYc7Zg/6KgtBQyldgM/RbfWKA48M/wm
        BmONDHAmrCAJWjPU3f7oBpz88Ry6xM6+FRvKOs=
X-Sasl-enc: lCO4tpxCoZIDwUzy1IE1krFrhlTbc4P2sGwFQENmzCkv 1475991830
Received: from [192.168.1.80] (unknown [183.89.33.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id EE8BCCC088;
        Sun,  9 Oct 2016 01:43:49 -0400 (EDT)
To:     git <git@vger.kernel.org>
From:   Tom Hale <tom@hale.ee>
Subject: %C(auto) not working as expected
Message-ID: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
Date:   Sun, 9 Oct 2016 12:43:49 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ ~/repo/git/git --version
git version 2.10.0.GIT

The `git-log` man page says:

`auto` alone (i.e.  %C(auto)) will turn on auto coloring on the next 
placeholders until the color is switched again.

In this example:

http://i.imgur.com/y3yLxk7.png

I turn on auto colouring for green, but it seems that this is not being 
respected when piped through `cat`.

Am I misunderstanding the manual?

-- 
Tom Hale
