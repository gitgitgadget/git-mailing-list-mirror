Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA41020248
	for <e@80x24.org>; Mon, 25 Feb 2019 16:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfBYQFm (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 11:05:42 -0500
Received: from elephants.elehost.com ([216.66.27.132]:51683 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfBYQFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 11:05:42 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1PG5cNh037927
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Feb 2019 11:05:38 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.21.0
Date:   Mon, 25 Feb 2019 11:05:31 -0500
Message-ID: <000801d4cd23$f24e8a90$d6eb9fb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_0020_01D4CCEC.04FFFB20";
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHPzoQfbsePaA70x5Dm/jFx3eZEKA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just some good news. We have two platform variants in NonStop to worry about
(soon to be three). Our testing is being conducted on the oldest and slowest
(J-series) so that we catch whatever we can. 2.21.0 one is still testing
2.21.0 in our Jenkins instance on J-series but is looking consistent with
rc2 (although we're just entering the scary tests area 5300-5599). The newer
L-series machines had no trouble at all and passed (other than the usual
t9001 and t9020 which won't work on platform anyway). Test time was about 9
hours on our L-series machine compared with 50-ish on the J-series.

Thanks for the hard work everyone!

