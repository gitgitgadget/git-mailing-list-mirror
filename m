Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37CFC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 16:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F70E64ED3
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 16:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhBYQPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 11:15:02 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:37352 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhBYQNN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 11:13:13 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lFJFN-00FrIk-2Q; Thu, 25 Feb 2021 09:12:13 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1lFJFM-0001lA-1w; Thu, 25 Feb 2021 09:12:12 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id B6BD25016F7;
        Thu, 25 Feb 2021 09:02:06 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uctEPMCS1Qbm; Thu, 25 Feb 2021 09:02:06 -0700 (MST)
Received: from ellen.lan (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 43EAF50177C;
        Thu, 25 Feb 2021 09:02:06 -0700 (MST)
Date:   Thu, 25 Feb 2021 09:02:03 -0700
From:   Seth House <seth@eseth.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <YDfJ+1owbwtNToTE@ellen.lan>
References: <20210214022840.849312-1-seth@eseth.com>
 <20210214022840.849312-2-seth@eseth.com>
 <xmqqk0r7rh7l.fsf@gitster.c.googlers.com>
 <CAJDDKr7ibQH9fJEF2TuZ+S7cRFydX27d7sVvXt5bdfENqba_JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJDDKr7ibQH9fJEF2TuZ+S7cRFydX27d7sVvXt5bdfENqba_JA@mail.gmail.com>
X-XM-SPF: eid=1lFJFM-0001lA-1w;;;mid=<YDfJ+1owbwtNToTE@ellen.lan>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [PATCH 1/1] mergetools/vimdiff: add vimdiff1 merge tool variant
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 10:55:00AM -0800, David Aguilar wrote:
> Looks good to me.  FWIW,
> Tested-by: David Aguilar <davvid@gmail.com>

Thank you for testing that, David.

