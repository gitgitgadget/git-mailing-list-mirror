Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B20C433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD0E238E7
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhAIWyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:54:45 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39034 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAIWyp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 17:54:45 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kyN7U-00Eg4v-Eo; Sat, 09 Jan 2021 15:54:04 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kyN7T-003YZw-9l; Sat, 09 Jan 2021 15:54:04 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 1D8F9500C20;
        Sat,  9 Jan 2021 15:54:03 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vVYhjQlkgTXI; Sat,  9 Jan 2021 15:54:03 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 8E4FB500C06;
        Sat,  9 Jan 2021 15:54:02 -0700 (MST)
Date:   Sat, 9 Jan 2021 15:54:00 -0700
From:   Seth House <seth@eseth.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Message-ID: <20210109225400.GA156779@ellen>
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
 <20210109224236.50363-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210109224236.50363-1-davvid@gmail.com>
X-XM-SPF: eid=1kyN7T-003YZw-9l;;;mid=<20210109225400.GA156779@ellen>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [PATCH v2] fixup! mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 09, 2021 at 02:42:36PM -0800, David Aguilar wrote:
> Replace "\r" with a substituted variable that contains "\r".
> Replace "\?" with "\{0,1\}".

Nice. I was (very slowly) converging on that as the culprit. Thanks for
the elegant fix! I'm running the test suite on Windows and OSX (now that
they're set up locally) with this included and I'll send a v10 once
complete.

