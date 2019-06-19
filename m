Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB0AE1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 17:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfFSRk5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 19 Jun 2019 13:40:57 -0400
Received: from mail.inforeach.biz ([38.106.198.11]:35457 "EHLO
        mailf.inforeachinc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730029AbfFSRk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 13:40:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailf.inforeachinc.com (Postfix) with ESMTP id 116A519C196
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 12:40:59 -0500 (CDT)
Received: from mail2.inforeachinc.com (unknown [192.168.27.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailf.inforeachinc.com (Postfix) with ESMTPS id D05ED19C198
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 12:40:56 -0500 (CDT)
Authentication-Results: mailf.inforeachinc.com; none
Received: from EXCH2010A.inforeachinc.com ([::1]) by
 Exch2010a.inforeachinc.com ([::1]) with mapi id 14.03.0439.000; Wed, 19 Jun
 2019 12:40:53 -0500
From:   Konstantin Matokhin <konstantin.matokhin@inforeachinc.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ruslan Petrenko <Ruslan.Petrenko@inforeachinc.com>
Subject: git@vger.kernel.org
Thread-Topic: git@vger.kernel.org
Thread-Index: AdUmxiOQVikrlWMQTyWp5ptlmPMiQQ==
Date:   Wed, 19 Jun 2019 17:40:53 +0000
Message-ID: <869169A1206D344E9ADF64BB83A734F3011434C3B1@Exch2010a.inforeachinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.21.171]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have a question about sparse checkout. Git version 2.17.1
For some reason it checks out files from not specified folders. 
My .git/info/sparse-checkout has two lines:

frontend/
common/

However backend/ is also created with some files in it (not all)

Is it a known bug? 
Any workaround to have only desired frontend/ and common/ checked out?

Thanks,
Konstantin.
