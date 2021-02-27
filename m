Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFD1C433E6
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 02:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8902B64EF0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 02:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhB0CSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 21:18:23 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:46186 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhB0CSW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 21:18:22 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lFpAr-00FsgW-IZ; Fri, 26 Feb 2021 19:17:41 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1lFpAq-0000Nc-VD; Fri, 26 Feb 2021 19:17:41 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id A618E1281B7E;
        Fri, 26 Feb 2021 19:17:40 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8d67hjg6rUAN; Fri, 26 Feb 2021 19:17:40 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id D944D1281B86;
        Fri, 26 Feb 2021 19:17:39 -0700 (MST)
Date:   Fri, 26 Feb 2021 19:17:37 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, pudinha <rogi@skylittlesystem.org>,
        David Aguilar <davvid@gmail.com>
Message-ID: <YDmrwVQAwlzCVOO4@ellen>
References: <20210214022840.849312-1-seth@eseth.com>
 <b3467a47-dffd-154f-76f9-e09b8145a5e5@gmail.com>
 <YDhBAPbU/T8BldrS@ellen.lan>
 <xmqqh7lzshx6.fsf@gitster.g>
 <YDmFrd/zB4G93oHz@ellen.lan>
 <xmqqblc6qnu1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblc6qnu1.fsf@gitster.g>
X-XM-SPF: eid=1lFpAq-0000Nc-VD;;;mid=<YDmrwVQAwlzCVOO4@ellen>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [PATCH 0/1] mergetools/vimdiff: add vimdiff1 merge tool variant
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 26, 2021 at 05:52:22PM -0800, Junio C Hamano wrote:
> I think that is exactly what we have on sh/mergetools-vimdiff1 topic
> branch in 'next'.

Oh, whoops. Thanks! I'll get into the habit of watching 'next' more
closely.

