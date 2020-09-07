Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1184CC433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAFB21473
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 15:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgIGPzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:55:40 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39203 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729974AbgIGPyH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 11:54:07 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 79A2C206462B7
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 17:53:59 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: List one hash in "Some good revs are not ancestors of the bad rev."
To:     git@vger.kernel.org
Message-ID: <8a798495-c95e-1690-d5e6-89d1657fdaa4@molgen.mpg.de>
Date:   Mon, 7 Sep 2020 17:53:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git folks,


With

     $ git version
     git version 2.26.2

during `git bisect` I got:

> Some good revs are not ancestors of the bad rev.
> git bisect cannot work properly in this case.
> Maybe you mistook good and bad revs?

It would be great, if the (“closest”) conflicting rev could be printed 
too, so the user can easily check it.


Kind regards,

Paul
