Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBC91F453
	for <e@80x24.org>; Mon, 18 Feb 2019 20:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfBRUbw (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 15:31:52 -0500
Received: from elephants.elehost.com ([216.66.27.132]:10851 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfBRUbw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 15:31:52 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1IKVkAi080379
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 15:31:46 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Max Kirillov'" <max@max630.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "=?iso-8859-1?Q?'SZEDER_G=E1bor'?=" <szeder.dev@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com> <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com> <000001d4c624$da8e05d0$8faa1170$@nexbridge.com> <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com> <20190218202440.GA3373@jessie.local>
In-Reply-To: <20190218202440.GA3373@jessie.local>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
Date:   Mon, 18 Feb 2019 15:31:39 -0500
Message-ID: <004901d4c7c8$f6e5d0f0$e4b172d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFycQzmW9pNbu02MZcMspejNiBnQQDz28D8AaU7wHUB79R99QLcP2jtpm+FfkA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 18, 2019 15:25, Max Kirillov wrote:
> On Sat, Feb 16, 2019 at 10:57:52AM -0800, Junio C Hamano wrote:
> > I'm inclined to
> >
> >  - keep b46221ff in 'master', not reverted.
> 
> from the branch, cc95bc2025 "t5562: replace /dev/zero with a pipe from
> generate_zero_bytes" could be replaced with [1]
> "t5562: do not depend on /dev/zero", for simplicity. I cannot however test
> the issue as I have no access to the platform in question. As far as I
> understand, both should work.
> 
> [1] https://public-inbox.org/git/20190215164237.12250-1-
> max@max630.net/

AFAIK, b46221ff and [1] should be included. I have no preference on the
title. As soon as (dT based $DAYJOB and $SLEEP) the merge is available (or
-rc2) comes out, I will test t5562 then run a full regression on NonStop and
report back. t5562 takes under a minute. The full suite is 50 hours. How's
that?

Cheers,
Randall

