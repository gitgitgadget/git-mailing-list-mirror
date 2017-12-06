Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD9120C11
	for <e@80x24.org>; Wed,  6 Dec 2017 16:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbdLFQsx (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 11:48:53 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:57002 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752162AbdLFQsw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2017 11:48:52 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1eMcsK-0004jH-My; Wed, 06 Dec 2017 17:48:48 +0100
Subject: Re: [RFC] 'unsigned long' to 'size_t' conversion
To:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <a660460d-b294-5113-bfaf-d98bcf99bad5@gmail.com>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <0e22c1cf-57df-fe6c-c63f-d8a219e80aa1@virtuell-zuhause.de>
Date:   Wed, 6 Dec 2017 17:48:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <a660460d-b294-5113-bfaf-d98bcf99bad5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1512578932;80cbb6b2;
X-HE-SMSGID: 1eMcsK-0004jH-My
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.12.2017 um 16:08 schrieb Derrick Stolee:

Hi Derrick,

> If there are small, isolated chunks that can be done safely, then this
> may be a good target for a first patch.

Here are some pointers to past discussions:
-
https://public-inbox.org/git/trinity-9f703269-6f73-4f6d-b90b-45e09e1c094c-1489582854278@3capp-gmx-bs66/
-
https://public-inbox.org/git/1502527643-21944-1-git-send-email-martin@mail.zuhause/

I'm posting this mainly so that we can avoid, if possible, duplicated work.

Hope that helps,
Thomas
