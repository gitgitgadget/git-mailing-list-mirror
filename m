Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA99AC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36DF20829
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgETU6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 16:58:15 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:27148 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETU6P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 16:58:15 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jbVn3-0004Pa-5D
        for git@vger.kernel.org; Wed, 20 May 2020 21:58:13 +0100
To:     Git List <git@vger.kernel.org>
From:   Philip Oakley <philipoakley@iee.email>
Subject: How do Git on Linux users launch/read the user-manual?
Message-ID: <8142f64b-9b5e-3637-21a2-3671dd65a42e@iee.email>
Date:   Wed, 20 May 2020 21:58:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a Windows user, when I want to look at the Git user-manual, I tend to
`git help git`, which on Git for Windows opens the users  default
browser. For me, it's at C:/Program
Files/Git/mingw64/share/doc/git-doc/git.html.

I can then browse that directory to find user-manual.html and open it
from there (because I know it is there!).

How do Git on Linux users launch/read the user-manual?

Essentially the user manual isn't accessible from Git, and really it
should be.

However it's not a formatted as a man page so some other access
mechanism is needed, compatible with Linux, and Windows users. It would
be nice if it was part of the `git help -g` list.

Excuse my ignorance for not knowing how linux users should access this
usefully curated doc.

Question promoted by Philippe's recent inclusion of the FAQ to the doc
list [1]

Philip

[1] https://lore.kernel.org/git/xmqqimgqwqif.fsf@gitster.c.googlers.com/T/#t
