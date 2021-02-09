Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E0C433E9
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A0964E3E
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhBJAKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:10:45 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:43256 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhBIX2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 18:28:22 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l9cPf-00ClsX-Ie; Tue, 09 Feb 2021 16:27:19 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l9cPd-001iMA-Es; Tue, 09 Feb 2021 16:27:19 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 446005016BB;
        Tue,  9 Feb 2021 16:27:17 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Dsnjvyu8vTsv; Tue,  9 Feb 2021 16:27:17 -0700 (MST)
Received: from ellen.lan (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 939BA5015B1;
        Tue,  9 Feb 2021 16:27:16 -0700 (MST)
Date:   Tue, 9 Feb 2021 16:27:14 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <20210209232714.GA172268@ellen.lan>
References: <20210130054655.48237-1-seth@eseth.com>
 <20210209200712.156540-1-seth@eseth.com>
 <xmqqeehozybq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeehozybq.fsf@gitster.c.googlers.com>
X-XM-SPF: eid=1l9cPd-001iMA-Es;;;mid=<20210209232714.GA172268@ellen.lan>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [PATCH v11 0/3]  mergetool: add hideResolved configuration (was
 automerge)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 02:11:05PM -0800, Junio C Hamano wrote:
> Thanks for all these iterations.  The resuling series looks good to
> me.

Woot! Thanks for all the great feedback and for walking me through the
process. I'm really happy with where this ended up.

