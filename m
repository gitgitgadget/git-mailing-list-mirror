Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4932820A40
	for <e@80x24.org>; Tue,  5 Dec 2017 12:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbdLEMNz (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 07:13:55 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:27809 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbdLEMNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 07:13:54 -0500
Received: from [192.168.2.201] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id MC6ieuqjNmITaMC6iecjj7; Tue, 05 Dec 2017 12:13:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1512476033;
        bh=86b4UvVhzuKY2GsmIyC4i40VPPy4yQGaq5WPOeZWXUc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IsTvGGUBF03a1tg6cyRmeTMB+zGbA59Rze895+11HjSykZkvrEgy5/lvIx8xXtRwJ
         9+XsMtuNkdICDTROPJe7LgNrWVxKMfsw/Ld3DYj0K1iEpDQt5nFxpnYeLiR1/DvwzU
         wbQgShLaqPs40DEpB5MkxjcBGaCp3/e3DV1P/Jg4=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=dx0h5xWqsLAQqm0PWF8A:9 a=hldk4wxsXOldEnRG:21
 a=Ij6VUFOfSY8puil7:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 9/9] t3512/t3513: remove
 KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171124110758.9406-1-phillip.wood@talktalk.net>
 <20171124110758.9406-10-phillip.wood@talktalk.net>
 <CAGZ79kY0YC+3kpYWDFi=bW0m-KFUpqexc3gxe-a5gS3YTn89bg@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <9c184a5a-b45b-efd1-449f-a18e2dee0ef3@talktalk.net>
Date:   Tue, 5 Dec 2017 12:13:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY0YC+3kpYWDFi=bW0m-KFUpqexc3gxe-a5gS3YTn89bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNHI4YH9Sg3SU+E7iEhxTwjfm8bDgFYiA8c1/xs51ExmGpMGAjYsopXDjGa2DKQf8NKZ5kU6plZVQw1ANk/PVd03hrauePKhqkdg3zseKdT26EgrmYWD
 U9dj1djcymoG0TU6WP3bQv9as8OfjVps9sbfJ/5PHSLnadC0BlHJk4auw8bKbzRcgF5WttJ1ix9FZIcE2Q56OfwIddjbP7wj1qP0nRroLtSn+lVuF5LWpu7M
 Hko2hngZ2q26U1LE8Zmb30vqKT5v3mDpftrbH6B7CmLpGtwnhLyGByrLHVzivpYMHZrAVvp62fdNVZcwpWItlFYj++Gwvef+lwneqBQjMHLiST2ezUfiDxFU
 sOlG+gj4VUhr7I9JrjvacKeA5Ejbew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/12/17 19:24, Stefan Beller wrote:
> On Fri, Nov 24, 2017 at 3:07 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Now that the sequencer creates commits without forking 'git commit' it
>> does not see an empty commit in these tests which fixes the known
>> breakage. Note that logic for handling
>> KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1 is not removed from
>> lib-submodule-update.sh as it is still used by other tests.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>
>> Notes:
>>     The output of the tests with after the previous patch looks like the
>>     output of the merge tests (see below), so I'm hopeful that this is a
>>     genuine fix, but someone who knows about submodules should check that
>>     things are in fact working properly now.
> 
> Looking at the patch only (in combination with the history of the
> submodule tests,
> 283f56a40b (cherry-pick: add t3512 for submodule updates, 2014-06-15))
> this patch
> looks good to me. I wonder though if this needs to be squashed in another commit
> to keep the test suite working for each patch and have no intermittent
> failure in the
> series.

Hi Stefan

Thanks for looking at this, it's good to know you think it's OK. I'll
leave it to Junio's discretion whether to squash this into the previous
patch

Thanks again

Phillip

> Thanks,
> Stefan
> 

