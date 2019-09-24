Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6A71F463
	for <e@80x24.org>; Tue, 24 Sep 2019 10:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504445AbfIXKEA (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 06:04:00 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:41710 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504442AbfIXKEA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 06:04:00 -0400
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iChfn-0005RP-Ri; Tue, 24 Sep 2019 12:03:55 +0200
Subject: Re: [PATCH v2 2/2] t0028: add more tests
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.347.git.gitgitgadget@gmail.com>
 <pull.347.v2.git.gitgitgadget@gmail.com>
 <40e54cf5ce74d1404187e31c94644df29134b4ff.1569233057.git.gitgitgadget@gmail.com>
 <20190924040637.2hybnk54ehf3uhoa@tb-raspi4>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <5250c693-2d6b-69a1-3ed0-8a3fb3396e30@syntevo.com>
Date:   Tue, 24 Sep 2019 12:03:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190924040637.2hybnk54ehf3uhoa@tb-raspi4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24.09.2019 6:06, Torsten Bögershausen wrote:
> Would this make more sense:
> After I discovered that UTF-16-LE-BOM test was bugged,
> I decided that better tests are required

OK

 > Looking at the other test cases, should utf-8 be written as UTF-8
 > for consistency ?

OK

 > General remark:
 > Do we need the {} here?
 > ${encoding} could be simpler written as $encoding

 > More a style-nit: could we simply write like this:
 > printf $expect_bytes > $test_file.raw &&
 > test_cmp_bin $test_file.raw $test_file

This is pretty much my first experience with test framework
(and maybe third with shell scripts...). I will change as suggested.
