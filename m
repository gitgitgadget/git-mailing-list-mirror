Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2668C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 20:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB91D24671
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 20:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfLEUvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:51:01 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:50837 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfLEUvA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 15:51:00 -0500
Received: from localhost (unknown [157.36.201.94])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 71499100003;
        Thu,  5 Dec 2019 20:50:56 +0000 (UTC)
Date:   Fri, 6 Dec 2019 02:20:52 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     =?utf-8?B?5Yqg6Jek5LiA5Y2a?= <kato-k@ksysllc.co.jp>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk branch name encoding utf-8 probrem
Message-ID: <20191205205052.aaw4q57y2hlzghgd@yadavpratyush.com>
References: <TY2PR01MB24271C32E2FD9FD8C27CA8C2CA5D0@TY2PR01MB2427.jpnprd01.prod.outlook.com>
 <20191204222921.GB195537@google.com>
 <TY2PR01MB2427631CC07116A662AF3D38CA5C0@TY2PR01MB2427.jpnprd01.prod.outlook.com>
 <xmqqimmuzfe1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqimmuzfe1.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi 加藤一博,

On 05/12/19 12:28PM, Junio C Hamano wrote:
> 加藤一博 <kato-k@ksysllc.co.jp> writes:
> 
> > fix branch name encoding error on gitk.
> >
> > git checkout -b '漢字'
> > gitk show branch name broken like this '貍｢蟄'
> > fix this problem.
> 
> Paul (the gitk maintainer), the patch text itself does look
> reasonable.
> 
>     After "git checkout -b '漢字'" to create a branch with UTF-8
>     character in it, "gitk" shows the branch name incorrectly, as it
>     forgets to turns the bytes read from the "git show-ref" command
>     into Unicode characters.

This commit message would work for the git-gui patch as well (change 
"gitk" to "git-gui").
 
> is how I would phrase the log message.
> 
> Thanks.

-- 
Regards,
Pratyush Yadav
