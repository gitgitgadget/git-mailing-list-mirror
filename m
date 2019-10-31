Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BF971F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 11:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfJaLRk (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 07:17:40 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:53676 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727074AbfJaLRk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 31 Oct 2019 07:17:40 -0400
Received: from app10-neu.ox.hosteurope.de ([92.51.170.144]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1iQ8SN-0002wV-4U; Thu, 31 Oct 2019 12:17:35 +0100
Date:   Thu, 31 Oct 2019 12:17:34 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Message-ID: <1223720779.572910.1572520655053@ox.hosteurope.de>
In-Reply-To: <nycvar.QRO.7.76.6.1910302317430.46@tvgsbejvaqbjf.bet>
References: <xmqqblty3dtx.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910302317430.46@tvgsbejvaqbjf.bet>
Subject: Re: Git for Windows v2.24.0-rc2, was Re: [ANNOUNCE] Git v2.24.0-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev54
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1572520659;bd504371;
X-HE-SMSGID: 1iQ8SN-0002wV-4U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Johannes Schindelin <Johannes.Schindelin@gmx.de> hat am 30. Oktober 2019 um 23:23 geschrieben:

> - The `sendpack.sideband` config setting was re-introduced (I had
>   dropped this by mistake, thinking that it was no longer necessary
>   because the commit message failed to mention that this config setting
>   is necessary to work around issues when pushing via `git://`).

I do realize that my understanding of git is now much better than it was 5 years ago when I submitted that patch. The commit message says "dump git protocol" but actually wanted to say "git://".

Thanks for reintroducing it.
