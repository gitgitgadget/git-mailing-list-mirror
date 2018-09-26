Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8691F453
	for <e@80x24.org>; Wed, 26 Sep 2018 16:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeIZWk3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 18:40:29 -0400
Received: from mx.sdf.org ([205.166.94.20]:58308 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbeIZWk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 18:40:29 -0400
Received: from sdf.org (IDENT:aedifex@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id w8QGQccj012876
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO)
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 16:26:38 GMT
Received: (from aedifex@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id w8QGQcnc010901
        for git@vger.kernel.org; Wed, 26 Sep 2018 16:26:38 GMT
Date:   Wed, 26 Sep 2018 16:26:38 +0000
From:   Tacitus Aedifex <aedifex@sdf.org>
To:     git@vger.kernel.org
Subject: Fixing constant preference prompts during tests
Message-ID: <20180926162638.GA28077@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I keep getting prompted for my algorithm preferences while running all of the 
git test suite:

Set preference list to:
     Cipher: AES256, AES192, AES, 3DES
     Digest: SHA512, SHA384, SHA256, SHA224, SHA1
     Compression: Uncompressed
     Features: MDC, Keyserver no-modify

What is the best way to prevent this from happening? I want to run the entire 
test suite unattended and have it complete on its own.

//tæ
