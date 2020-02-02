Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3234FC3524B
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 23:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1048020661
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 23:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgBBXZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 18:25:01 -0500
Received: from piie.net ([80.82.223.85]:52740 "EHLO piie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgBBXZB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 18:25:01 -0500
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Feb 2020 18:25:00 EST
Received: from [192.168.1.26] (b2b-37-24-240-63.unitymedia.biz [37.24.240.63])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by piie.net (Postfix) with ESMTPSA id 051D7260F;
        Mon,  3 Feb 2020 00:16:25 +0100 (CET)
Subject: Re: Re: [PATCH v2] Fix status of initialized but not cloned
 submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>,
        git@vger.kernel.org, christian.couder@gmail.com, pc44800@gmail.com
References: <23e3d410-5271-a919-aa03-9e776cf72f7c@nokia.com>
 <1579601532-10694-1-git-send-email-peter.kaestle@nokia.com>
 <xmqq4kwl512y.fsf@gitster-ct.c.googlers.com>
 <9192695a-0b3f-d166-7efa-84f57e091c2c@nokia.com>
 <xmqqblqs3hbv.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter@piie.net>
Message-ID: <0a541856-09c4-4549-713f-3d65b685129d@piie.net>
Date:   Mon, 3 Feb 2020 00:16:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xmqqblqs3hbv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-NA
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24.01.20 18:16, Junio C Hamano wrote:
> Peter Kästle <peter.kaestle@nokia.com> writes:
>> Besides that, I think testcases for man git-submodule's description of
>> status on merge conflicts are missing (...[prefix] U if the submodule
>> has merge conflicts).
> 
> Nice to know.  Thanks.

I was wrong.  Testcases for "submodule status" to add prefix U in case 
of submodules with merge conflicts do exist in: t7405-submodule-merge.sh
The two tests are called:
git submodule status should display the merge conflict properly with[..]

-- 
--peter;
