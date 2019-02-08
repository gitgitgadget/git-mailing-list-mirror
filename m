Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA831F453
	for <e@80x24.org>; Fri,  8 Feb 2019 12:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBHMX0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 07:23:26 -0500
Received: from elephants.elehost.com ([216.66.27.132]:17194 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBHMX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 07:23:26 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18CNOTf063711
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 8 Feb 2019 07:23:24 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Hang] t5562 subtest 8 on NonStop
Date:   Fri, 8 Feb 2019 07:23:17 -0500
Message-ID: <002301d4bfa9$158716e0$409544a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_0012_01D4BF7A.EBC2BB30";
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ0O8qAfP94YPcwq/am/NdqSl5t4A==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

We have suddenly encountered a hung git-http-backend in t5562 in the NonStop
port. This is a new problem not seen before on the platform, surprisingly. I
am wondering whether this is a result of not actually having an apache2
server on-board. Is that a possibility and can that sub-test be bypassed if
no apache2 is detected?

We also had subtest 15 and I am investigating, but it may depend on 8's data
(I had to kill the git-http-backend process, so maybe that's why).

Thanks,
Randall

