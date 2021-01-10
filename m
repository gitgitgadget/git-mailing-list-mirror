Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8A4C433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 13:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DCD235FF
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 13:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAJNAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 08:00:00 -0500
Received: from mout01.posteo.de ([185.67.36.65]:44950 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbhAJNAA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 08:00:00 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 746FB160065
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 13:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1610283542; bh=sM8qzj3HMhEEZWGpKqR/EZTcCC4wDo44dVPQmtXTEzs=;
        h=Subject:To:Cc:From:Date:From;
        b=LRqqq8r2PgM4ysJLuD+Li8cOCGMbq1T5wSWPcTfOlLW+ZWI3nqQK55EHIlHIYsHqN
         nVg8q7MzK5wZTyeZfNOPonXuz5a9XIjIrGL+pBVtT28dUR/2Odsi2aE1EvBg7/0qCq
         aC0GJlLyQNlEKlvFDgIiBP54kLUzzQtTym/EFRkjEk7IEDxtf+So8GKt2YaXKOTjZr
         o3BVDjcuviN2HDxA10O+FcvkZTBxry4IVzTJ7ww6ZiaKjlTfA4CPvneHkfoYl+Jtck
         iHmaCrwPTclYIEybAsfWs+W7KEH8F7KzndAUQ4pzyQAwNlgUI5abqqxWHCTexXvvRf
         XLte5xn/yMgPA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DDH393ktjz9rxH;
        Sun, 10 Jan 2021 13:59:01 +0100 (CET)
Subject: Re: [RFC PATCH] gitk: Activate --find-copies-harder
To:     Laszlo Ersek <lersek@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
References: <b12574f0-3ebc-95c0-9def-555150257e46@posteo.net>
 <46693c60-98ee-b6c9-df8e-12216622ddf9@redhat.com>
From:   Robert Pollak <robert.pollak@posteo.net>
Message-ID: <b0c0a630-25a9-8ef8-2270-fa40404c2897@posteo.net>
Date:   Sun, 10 Jan 2021 13:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <46693c60-98ee-b6c9-df8e-12216622ddf9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-01-06 16:58, Laszlo Ersek wrote:
> On 01/04/21 20:54, Robert Pollak wrote:
[...]
>> I see the following problems with my patch:
>>
>> 1) It is totally untested with all the other args that are collected in
>> diffargs, like e.g. "-O<orderfile>", since I didn't need them yet.
> 
> It would be really great if gitk supported both "-O<orderfile>" and
> --find-copies-harder!

Can you please test these options with my patch and report back?

-- Robert
