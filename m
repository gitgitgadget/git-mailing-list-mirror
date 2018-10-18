Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410401F453
	for <e@80x24.org>; Thu, 18 Oct 2018 16:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeJSAHs (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 20:07:48 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:60776 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbeJSAHr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 20:07:47 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2018 20:07:47 EDT
Received: from g550jk.localnet (80-110-115-173.cgn.dynamic.surfer.at [80.110.115.173])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 70B9BC046E
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1539878466; bh=IJc0ACaJjbMG5qsTejwMtBUU4kehSA7tmDKs+90ePss=;
        h=From:To:Subject:Date;
        b=R7o28HCV2+Yh/aAcstDaDrCWJYtWeuS1tWqPlPkGuvLnf+UvpRy/61eYEd9PdxLtP
         JBA8YTOHdmH0q1HhSnCbyz2ZOUGDC6jIfAd4AcaD++oL6uuLDPF2hwa/d8ymqkix1R
         U5qQlvjIpK+djzJ5x3uFON3iBg6iWsGw16s3Eji8=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     git@vger.kernel.org
Subject: No --no-gpg-sign option with "git rebase"
Date:   Thu, 18 Oct 2018 18:01:05 +0200
Message-ID: <22001585.W2CEcL5IrY@g550jk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See subject, would be quite useful to have this. ("Countermand commit.gpgSign 
configuration variable that is set to force each and every commit to be 
signed.")

Thanks, Luca


