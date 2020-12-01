Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA1CC71156
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 10:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5443320809
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 10:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgLAKrW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 1 Dec 2020 05:47:22 -0500
Received: from mx009.vodafonemail.xion.oxcs.net ([153.92.174.39]:31756 "EHLO
        mx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgLAKrW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Dec 2020 05:47:22 -0500
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 773DB60451A;
        Tue,  1 Dec 2020 10:46:40 +0000 (UTC)
Received: from [192.168.2.101] (unknown [188.110.48.24])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 259CC603EDF;
        Tue,  1 Dec 2020 10:46:36 +0000 (UTC)
To:     git@vger.kernel.org
From:   Ernst Reissner <rei3ner@arcor.de>
Subject: bug report/feature request: git describe: what is 'clean'
Message-ID: <ed404c7e-d098-348d-d8fe-dae8aa5a5fda@arcor.de>
Date:   Tue, 1 Dec 2020 11:46:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-VADE-STATUS: LEGIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello All,

find below a bug report/feature request.

Regards,

Ernst


Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
i have a workspace with untracked files, else clean.
then i did `git describe`.
What did you expect to happen? (Expected behavior)
I expected to see a label 'dirty'
What happened instead? (Actual behavior)
no label `dirty`
What's different between what you expected and what actually happened?
obvious
Anything else you want to add:
I know that this is not precisely a bug,
Instead it is a feature request.
Practically, `git describe` is used to determine a version.
For me the sense of 'dirty' is to indicate that this deliverable is not 
reproducible from the repo.
Thus it may not be delivered to a customer.
So in this sense, untracked files make a workspace dirty also.

Without the need of backward compatibility, i would say, dirty is all,
which is tracked and modified staged or not,
or which is untracked but not ignored.

To keep backward compatibility,
maybe it is a good idea to add a second suffix, maybe 'untracked' to 
display in addition.
That way it is clear: only if no suffix is present, software from repo 
can be delivered
and one is sure that this is reproducible.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.29.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.9.1-2-default #1 SMP Mon Oct 26 07:02:23 UTC 2020 
(435e92d) x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.32
$SHELL (typically, interactive shell): /bin/bash



