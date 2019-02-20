Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94BE1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 00:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfBTAnq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 19 Feb 2019 19:43:46 -0500
Received: from elephants.elehost.com ([216.66.27.132]:52081 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfBTAnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 19:43:46 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1K0hhau073003
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Feb 2019 19:43:43 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc2
Date:   Tue, 19 Feb 2019 19:43:37 -0500
Message-ID: <012601d4c8b5$54f1b730$fed52590$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQC1VVUPHT7/O/TkZraQz8YJYJGYJ6gmv2Mg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 19, 2019 18:29, Junio C Hamano wrote:
> A release candidate Git v2.21.0-rc2 is now available for testing at the usual
> places.  It is comprised of 474 non-merge commits since v2.20.0, contributed
> by 61 people, 16 of which are new faces.

Thanks. t5562 works properly on NonStop (3 tests under various loads). I am starting a full regression test now - see you in two days or so with a full report.

Regards,
Randall

