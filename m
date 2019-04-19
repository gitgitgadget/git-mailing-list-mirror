Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F107320248
	for <e@80x24.org>; Fri, 19 Apr 2019 19:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfDST2d (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 15:28:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:47737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfDST2d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 15:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555702112;
        bh=2TunPAqdSMYFlf64CFHGb3z/KGx1Wt0Gm7efSXrTogs=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=coQ/fwaCeYCfpbsmKBZxYQGIYDhSypNiNRyzKceX+8LWXbLK3/2LFypgLGswgU4DK
         SF00BBxkkDVhRwFHlHJi0quGXolgqbu4G+5Vg3x6atUa0KI4+LfteO7PTTNZPpaRUZ
         1HHYvRUSldcLU/pHhhKmkcCQkq5vI3X/MulOYR3o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.134.142.3] ([80.134.142.3]) by web-mail.gmx.net
 (3c-app-gmx-bs44.server.lan [172.19.170.96]) (via HTTP); Fri, 19 Apr 2019
 21:28:32 +0200
MIME-Version: 1.0
Message-ID: <trinity-3f1323ca-ca26-46c1-8757-b30bb495bd3a-1555702112240@3c-app-gmx-bs44>
From:   "Ax Da" <discussion@gmx.net>
To:     git@vger.kernel.org
Subject: Git config "ignorecase = true" has issues
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 19 Apr 2019 21:28:32 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:E6avHO8uQXC7eT6X/jVro5XbsKMYFmpVrZt9x0R2RTQsHRBn1oBuzY6zDhcpbBqyhDsRA
 Ntx/LSrG4AoxUSXfFgkNiqA8fvHH76dpr6vMnHF93H7xn/Lm8RFW2ce9KuQsy9xnNCl3h93eHa4m
 grUSehHH4HvXhUCTsYtaSvCUu4ZnpJ6Tq13MoIW7PIwM2BgZZzJIbfKTBiZqpfzxU8tKOKA/7w1B
 hWtA6tyS2anoJU7Df7IcbXCYi8dXbbmoCSTVmFY8XZeu8kP46R+13jYJf7+y5fs29a5mfULD62id
 yo=
X-UI-Out-Filterresults: notjunk:1;V03:K0:c/e3AZHxkGQ=:Eg1TfT71FOqeNjMMiMIrLM
 luMTWIK1fnK/JUBBP2+cRl1SFV/Og8r380aOetG4uvJkcNODSqSOY+hzEQZ1rIE85yPbuGnb6
 v0kH0pOr+or02r7/y81HpA/ZqfaWIV8hqLdGIoLd0czrH0e1BoHxgdwLo8JOm2o4oT7k/f/ok
 QLySqUQP8mN5LthU1G11uDRWBEK//XmUra9Xng+6YbZfSaejxeuSqZ1yz5pld9lsb2hLzQ2ZO
 cAHeSsvylpEhDMO29DyCp5fegbkCZtVRPUq1z9+Of4Wvfr+yLpQ9tk7FCbAtEpyfqWDY1hLMz
 4KJrOr6G7VAQkSgLoy2ioouTuLG1u4WEFoLPYSFx2jbeJhKRTbqk3vDAVZUj3CcPFF3aBvbTy
 l04NlnQtNgmesn9ggJ6q9IVEta0ZBQT49J3XMt6ETWNc7HSWJ3eVSgkQzhvLSFm/eLwyVV9pn
 nlk/+ofLCVHLXGID4SEJloo4R8ITTN2ZEC7nIR3RD1oRJrJCa5vTq8LdVS7YQujpUtsWYUSGJ
 Pd0cJSRvJqeA+YPKHbHsRF/+l2hQ60lSwury77Ke8DqZhAlA1ygEfLsqow855wE3sDr3E+u8y
 XZnqR1NMPQoO4wsziX7b7bPs56Y9LbanAoDx5Itz3Q2HBtO5SD73msdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


We're working on Windows machines and have been experiencing issues with the current implementation of Git with config setting "core.ignorecase = true" (which is the default on Windows machines and repositories created on Windows machines):

Renaming files in a repository by only changing their case (changing a capital letter to its small equivalent and vice versa) is ignored by Git. Git retains the original case in the repository and all contributors will continue to see the ole file name which leads to confusion and issues with Open Source tools programmed to not ignore file name case.

Currently there is no way to convey the new file name (only differing in case) to Git when "core.ignorecase = true".

Hence, I propose to alter the behaviour of Git when "core.ignorecase = true": A repository's file name changes should be recognized as a RENAME operation and be propagated to the repository even when the new file name only differs from the old file name in case.

Thanks,
Axel Dahmen
