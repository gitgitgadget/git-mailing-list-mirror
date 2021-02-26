Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC10C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 23:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20F664EFA
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 23:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBZXfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 18:35:55 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55568 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZXfy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 18:35:54 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lFmdd-001Fjn-63; Fri, 26 Feb 2021 16:35:13 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lFmdc-001r0d-AU; Fri, 26 Feb 2021 16:35:12 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 022F35018D6;
        Fri, 26 Feb 2021 16:35:12 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n2FhgqZJ9dH6; Fri, 26 Feb 2021 16:35:11 -0700 (MST)
Received: from ellen.lan (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 977AF500682;
        Fri, 26 Feb 2021 16:35:11 -0700 (MST)
Date:   Fri, 26 Feb 2021 16:35:09 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, pudinha <rogi@skylittlesystem.org>,
        David Aguilar <davvid@gmail.com>
Message-ID: <YDmFrd/zB4G93oHz@ellen.lan>
References: <20210214022840.849312-1-seth@eseth.com>
 <b3467a47-dffd-154f-76f9-e09b8145a5e5@gmail.com>
 <YDhBAPbU/T8BldrS@ellen.lan>
 <xmqqh7lzshx6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7lzshx6.fsf@gitster.g>
X-XM-SPF: eid=1lFmdc-001r0d-AU;;;mid=<YDmFrd/zB4G93oHz@ellen.lan>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [PATCH 0/1] mergetools/vimdiff: add vimdiff1 merge tool variant
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 06:04:53PM -0800, Junio C Hamano wrote:
> Seth House <seth@eseth.com> writes:
> > I'll roll those into this patch.
> 
> I'd rather see it as a completely separate patch.

Ok, will do.

Should I roll a v2 of this patch set to include David's tested-by tag
even though there's no code changes?

