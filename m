Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9E920372
	for <e@80x24.org>; Mon,  9 Oct 2017 19:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754516AbdJITfU (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 15:35:20 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:57137 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754049AbdJITfT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 15:35:19 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9295246DC4
        for <git@vger.kernel.org>; Mon,  9 Oct 2017 21:35:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:mime-version:content-type:content-type
        :date:date:from:from:subject:subject:message-id:received; s=
        mail20150812; t=1507577715; bh=lQdFC5QMrpDaYnvTCmvAn0Y2oGC5yILug
        FMACVSn+Hs=; b=QEALhi555uhL6AkBk/hIlVwMOTvHBBZq4uCmw5IPmeGMkCGfH
        z5C7+TOHkxKLGBTose2Fnsc9JdmhQHRd8BPj36NISiqbopqiN2Gwec2MQ4MJCFSx
        f/rsHacKzcMxr09Gys6cF7wXEBVEcSlncojaKlCLdSuiQvBoCABJ3M6uPk/fYxkB
        6AXH4uC+zuwlz/HUJW0v5pzT5PFl5QYJDLihkz/i3T0YyDC0kuggOQxrtIkR53bX
        VGY8L73r0QTJdM3+G9IbjG9kHZx+wYFUFHMfpqPehF7baTm2smC+fgc1b0klqu6y
        DaRDYIDfH7Bje9kAQRHxZOUdRzNG6N7BGlH9w==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id O6FYPFwosLhu for <git@vger.kernel.org>;
        Mon,  9 Oct 2017 21:35:15 +0200 (CEST)
Message-ID: <1507577714.2359.27.camel@mailbox.org>
Subject: Auto adding changed files
From:   Sascha Manns <Sascha.Manns@mailbox.org>
To:     git@vger.kernel.org
Date:   Mon, 09 Oct 2017 21:35:14 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello list,

if i'm in a git repo and change a file, it is listed in git status. But
i have to add this file manually and commit them.

Is it possible to autoadd such files?

Greetings
Sascha
