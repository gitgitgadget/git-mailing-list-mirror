Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBEF320A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 20:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeLJUOo convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 10 Dec 2018 15:14:44 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:47782 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJUOo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 15:14:44 -0500
Received: from [73.114.19.156] (helo=[10.229.150.176])
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gWRww-0008AR-Ql
        for git@vger.kernel.org; Mon, 10 Dec 2018 15:14:43 -0500
Date:   Mon, 10 Dec 2018 15:14:27 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
References: <20181206173554.GH4633@hopa.kiewit.dartmouth.edu> <CAGZ79kY8uv8zDm3f8Jb6aC-nit7OZduixyOekGYWa_xnqFqw-w@mail.gmail.com> <20181206212459.GN4633@hopa.kiewit.dartmouth.edu> <CAGZ79kYoGqWW4tv4-caA18SHKe+y2mnDT84AEWVksDtDObLq0g@mail.gmail.com> <20181207012256.GR4633@hopa.kiewit.dartmouth.edu> <CAGZ79kbeAd1C-ySnJye-QU5FFf2jygksUsWtEmbvPZ_dQy_3uA@mail.gmail.com> <20181208021531.GB4633@hopa.kiewit.dartmouth.edu> <20181208042139.GA4827@hopa.kiewit.dartmouth.edu> <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
CC:     git <git@vger.kernel.org>
From:   Yaroslav Halchenko <yoh@onerussian.com>
Message-ID: <835918B7-3AD7-40C8-B438-D267E3879B51@onerussian.com>
X-SA-Exim-Connect-IP: 73.114.19.156
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [wishlist] git submodule update --reset-hard
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org




>
>> Took me some time to figure out
>> why I was getting
>>
>>         fatal: bad value for update parameter
>>
>> after all my changes to the git-submodule.sh script after looking at
>an
>> example commit 42b491786260eb17d97ea9fb1c4b70075bca9523 which
>introduced
>> --merge to the update ;-)
>
>Yeah I saw you also updated the submodule related C code, was that
>fatal message related to that?

Yes

-- 
Yaroslav O. Halchenko (mobile version)
Center for Open Neuroscience   http://centerforopenneuroscience.org
Dartmouth College, NH, USA
