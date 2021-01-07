Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8523AC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A8F2312E
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbhAGJ2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:28:04 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:41000 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhAGJ2C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:28:02 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kxRZf-008jXw-He; Thu, 07 Jan 2021 02:27:19 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1kxRZf-0006SM-3I; Thu, 07 Jan 2021 02:27:19 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id BE400500C7E;
        Thu,  7 Jan 2021 02:27:18 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u4c36Fp0-z03; Thu,  7 Jan 2021 02:27:18 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 878D8500A2D;
        Thu,  7 Jan 2021 02:27:18 -0700 (MST)
Date:   Thu, 7 Jan 2021 02:27:16 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <20210107092716.GA548935@ellen>
References: <20201228045427.1166911-1-seth@eseth.com>
 <20201228192919.1195211-1-seth@eseth.com>
 <20201228192919.1195211-6-seth@eseth.com>
 <xmqqpn2ivcc1.fsf@gitster.c.googlers.com>
 <20210107035806.GA530261@ellen>
 <xmqqy2h5meum.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2h5meum.fsf@gitster.c.googlers.com>
X-XM-SPF: eid=1kxRZf-0006SM-3I;;;mid=<20210107092716.GA548935@ellen>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [PATCH v9 5/5] mergetool: add automerge_enabled tool-specific
 override function
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 06, 2021 at 10:38:09PM -0800, Junio C Hamano wrote:
> By the way, do you have any idea why we see test breakages only on
> macos when this topic is merged to 'seen'?

Thanks for those links. I have an OSX machine nearby and will
investigate tomorrow.

Related: are the Windows tests affected by this patch? I wanted to check
for myself but I've been struggling with getting Git-for-Windows
installed in a VM.

