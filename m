Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED761F453
	for <e@80x24.org>; Tue, 19 Feb 2019 20:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfBSUgU (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 15:36:20 -0500
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:48965
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbfBSUgU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Feb 2019 15:36:20 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id wC7jgM8APPBgKwC7mgol2K; Tue, 19 Feb 2019 13:36:19 -0700
Date:   Tue, 19 Feb 2019 22:36:15 +0200
From:   Max Kirillov <max@max630.net>
To:     Max Kirillov <max@max630.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'SZEDER =?utf-8?Q?G=C3=A1bor'?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
Message-ID: <20190219203615.GB2354@jessie.local>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com>
 <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com>
 <000001d4c624$da8e05d0$8faa1170$@nexbridge.com>
 <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1902182008270.45@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1902182249140.45@tvgsbejvaqbjf.bet>
 <20190219201536.GA2354@jessie.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219201536.GA2354@jessie.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfOeMQycB0sTu13voxBqf3dbWrA74v3+xPihpZ62QoVsOyZKPLwizrVUxWMYAyo3uNgWU3s4ygohKm+CcQplXIIrZ6rRRs4K90FF4j64KyOHkbaU/8Cig
 gDylPGVSXxQ9c+hjxa221XPY1JEUJDmozqV8CruJB1/yI3d6UG8WQ4MycU6jmQivHymLjxLybf22UPxAFzW3dAWc9dskZcorLQvae76sQbLODhoSmv43J72s
 oNiXjQySF5Er5KOvBycLrXJGRtTVlH2E9rQN5IY4QREyu/Agp9uho8lOOkhXe46tuR02/EO9I6LzaaiU3FPQZrC93/+JKl5Z3GZOeQSVOwM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 10:15:36PM +0200, Max Kirillov wrote:
> expecially at
> Windows where you cannot just unlink busy file and reuse its
> place in directory

It was at Linux actually. Well, whatever the rename feels more
sure thing to me.
