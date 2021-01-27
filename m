Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CDFC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7EF206B9
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhA0D7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:59:36 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:46986 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbhA0DiG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 22:38:06 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l4bdw-006X9C-4G; Tue, 26 Jan 2021 20:37:20 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1l4bdv-0000Qt-J1; Tue, 26 Jan 2021 20:37:20 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 60FC45009A3;
        Tue, 26 Jan 2021 20:37:19 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LQZw42CXN5b6; Tue, 26 Jan 2021 20:37:19 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 4F229500896;
        Tue, 26 Jan 2021 20:37:17 -0700 (MST)
Date:   Tue, 26 Jan 2021 20:37:14 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <20210127033714.GA16914@ellen>
References: <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
 <20210110072902.GA247325@ellen>
 <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
 <20210116042454.GA4913@ellen>
 <YAo9aTkZBCSGLYTT@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2101221728410.52@tvgsbejvaqbjf.bet>
 <YAte7ixZYdz1AOMX@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2101261522200.57@tvgsbejvaqbjf.bet>
 <20210126180635.GA28241@ellen>
 <xmqqr1m71mty.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1m71mty.fsf@gitster.c.googlers.com>
X-XM-SPF: eid=1l4bdv-0000Qt-J1;;;mid=<20210127033714.GA16914@ellen>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 12:10:17PM -0800, Junio C Hamano wrote:
> I am OK with that "two merge-file invocations, one with --ours and
> then another with --theirs" approach, as I already said in
> https://lore.kernel.org/git/xmqqh7n9aer5.fsf@gitster.c.googlers.com/

Sorry if it seemed like I left that thread hanging (busy week). Thanks
for your reply(s). I'm finishing a v10 patchset with that change which
I'll submit to the list for review this week.

