Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B341F461
	for <e@80x24.org>; Mon, 19 Aug 2019 10:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfHSKzg convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Aug 2019 06:55:36 -0400
Received: from elephants.elehost.com ([216.66.27.132]:50720 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHSKzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 06:55:36 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7JAtU86084846
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Aug 2019 06:55:30 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqy2zszuz7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2zszuz7.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.23.0
Date:   Mon, 19 Aug 2019 06:55:23 -0400
Message-ID: <00ff01d5567c$9daf9140$d90eb3c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGF4GloXTnWxo+rP4GqLqXjTdR/BaehN6SA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 16, 2019 5:00 PM, Junio C Hamano wrote:
> The latest feature release Git v2.23.0 is now available at the usual places.  It
> is comprised of 505 non-merge commits since v2.22.0, contributed by 77
> people, 26 of which are new faces.

We are having a transient failure in t0021. It runs fine in isolation but is failing when running inside our Jenkins CI build. This is subtest 15 only. I'm not really going to whine about it this time, but it is strange that it keeps showing up occasionally. We are still passing the test and releasing the binaries.

