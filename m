Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C0BC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF36E611CE
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhEMNDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 09:03:47 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:39091 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232807AbhEMNDq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 09:03:46 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4FgsJS6L60z5tl9;
        Thu, 13 May 2021 15:02:32 +0200 (CEST)
Subject: Re: Git pathspecs difference in behavior between linux (wsl) and
 windows
To:     Alexandre Remy <alexandre.remy.contact@gmail.com>
Cc:     git@vger.kernel.org
References: <CAKToE5BnzXd_2pjhJY13E=e6b1ZgOV=NmXr_WfpCQd+LxXsO3A@mail.gmail.com>
 <81d06db6-fd91-7ec5-6aa5-84f69a227204@kdbg.org>
 <CAKToE5DgtW1Kuw4AE5+Am_=9gATN-S=xk1kYXMZUWvtdtNy_PQ@mail.gmail.com>
 <CAKToE5DEL1ZFwUbvcC-M3y-3mSVsVgMXDig4G=jcKbc-nJ_GnQ@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <68a4ebd3-3c80-8983-9a26-f205debc4b5b@kdbg.org>
Date:   Thu, 13 May 2021 15:02:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAKToE5DEL1ZFwUbvcC-M3y-3mSVsVgMXDig4G=jcKbc-nJ_GnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.05.21 um 11:31 schrieb Alexandre Remy:
> I have an additional question, does double-quotes be safely used in
> both windows (that's ok) and linux shell  for pathspecs (git status --
> "src/test.js") in case of spaces in the path?

They can be used in both POSIX shell and Windows CMD and, I would
assume, also in the PowerShell. Note though, that there are subtle
differences when other special characters occur between double-quotes,
notably the backslash. Please use your favorite search engine to learn more.

-- Hannes
