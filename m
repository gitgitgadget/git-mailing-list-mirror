Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7E71F461
	for <e@80x24.org>; Thu, 27 Jun 2019 17:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfF0RKk (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 13:10:40 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:50068 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbfF0RKk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Jun 2019 13:10:40 -0400
Received: from [2001:16b8:5c9f:4300:b800:7b22:1f7c:dc45]; authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hgXuw-0005Rd-Da; Thu, 27 Jun 2019 19:10:38 +0200
Subject: Re: [PATCH] make slash-rules more readable
To:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
References: <20190604173446.2664-1-admin@in-ici.net>
 <bd722415-1547-8db5-f88a-c35c8b48d8be@in-ici.net>
 <13f99ce6-f856-6554-5c14-1b1838d697d0@iee.org>
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
Message-ID: <d1d2ebec-a94a-0092-4a6d-8ae32db1573b@in-ici.net>
Date:   Thu, 27 Jun 2019 19:10:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <13f99ce6-f856-6554-5c14-1b1838d697d0@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1561655440;a146eb43;
X-HE-SMSGID: 1hgXuw-0005Rd-Da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 25.06.19 13:31, Philip Oakley wrote:
> only one minor point...

 >>> + - For example, a pattern `doc/frotz/` matches `doc/frotz` directory,
 >>> +   but not `a/doc/frotz` directory; however `frotz/` matches `frotz`
 >
 > her I misread this as:  "but not a `doc/frotz` directory;"
 > i.e. the leading 'a' is too easy to skim over as is part of the
 > sentence's prose, so maybe change to a 'baz' lead directory (bar already
 > having been used below).

Yes we could change that.

> Have you tried it out on any StackOverflow replies to see if those that 
> inhabit that zone find it helpful?
> Philip
I answered one person who had a hard time reading the docs at SO, but he 
didn't respond and the last time he was online was 2018, so I didn't 
made the effort to edit my answer with the current version.

-

What are the next steps? If there are no more responses, does it imply 
that everyone agrees with this patch? Can we publish it online?

