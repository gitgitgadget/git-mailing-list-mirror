Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6D01F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 10:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbeCZKMH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 26 Mar 2018 06:12:07 -0400
Received: from smtpb1.bt.com ([62.7.242.135]:12489 "EHLO smtpb1.bt.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbeCZKMG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 06:12:06 -0400
Received: from rew09926dag15c.domain1.systemhost.net (10.55.212.31) by
 EVMED01-UKBR.bt.com (10.216.161.31) with Microsoft SMTP Server (TLS) id
 14.3.319.2; Mon, 26 Mar 2018 11:12:02 +0100
Received: from rew09926dag15b.domain1.systemhost.net (10.55.212.23) by
 rew09926dag15c.domain1.systemhost.net (10.55.212.31) with Microsoft SMTP
 Server (TLS) id 15.0.1293.2; Mon, 26 Mar 2018 11:12:04 +0100
Received: from rew09926dag15b.domain1.systemhost.net
 ([fe80::7c8c:54db:f04e:543d]) by rew09926dag15b.domain1.systemhost.net
 ([fe80::7c8c:54db:f04e:543d%12]) with mapi id 15.00.1293.002; Mon, 26 Mar
 2018 11:12:04 +0100
From:   <shirlin.joseph@bt.com>
To:     <git@vger.kernel.org>
Subject: FW: Merging in Git with Branches
Thread-Topic: Merging in Git with Branches
Thread-Index: AdPE1SC4QRXf3VDVTuep98sqcf+I1gAFPqpgAAAnGVA=
Date:   Mon, 26 Mar 2018 10:12:04 +0000
Message-ID: <84fd5584332c450abe8b634921e7b568@rew09926dag15b.domain1.systemhost.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.55.202.233]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Git team,

I have a query.

Scenario:
Currently there are two main branches that we are utilizing A(master) and B(branch of A). Branch is utilised for individual stories(as per delivery).

When branch is utilised since the team size is huge the number of changes/ branches created for different stories is huge and the common files changed are many.

Thus when the story for branch A is completed and merge request is raised, since the branch is not up-to-date with the A(master). It turns out to be mostly a manual merge.

1. Is there a better way to handle the scenario of the branch not being up-to-date with the master and the merge becoming a time consuming manual merge task?
2. Can we automate it?

Regards,
Shirlin.

