Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0408C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 20:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794C52065C
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 20:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFNUle (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:41:34 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:16066 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgFNUle (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 16:41:34 -0400
Received: from host-89-243-191-101.as13285.net ([89.243.191.101] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jkZRc-0003Ko-AQ; Sun, 14 Jun 2020 21:41:32 +0100
Subject: Re: Rename offensive terminology (master)
To:     =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>,
        konstantin@linuxfoundation.org
Cc:     Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        sandals@crustytoothpaste.net, simon@bocoup.com, stolee@gmail.com
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <13780dc3-3cca-4072-a659-316d2824b65b@iee.email>
Date:   Sun, 14 Jun 2020 21:41:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/06/2020 19:23, Sérgio Augusto Vianna wrote:
> Ok, can you show me a single instance where "master" was confusing or
> not descriptive enough?
Currently Git, and Git for Windows, both have an equal but different
"master" branch with the same project root. Hopefully we won't have the
same issue when the new default emerges [1].

Moving away for a centralised name in a distributed versioning system
will offer the benefits of making the distinction between different
forks of the same project.

At the same time the concept of a "master copy" is itself an oxymoron.
Computer storage provides perfect reproduction at the bits and byte
level, with strong verification through the hash values. My copy of hash
X is identical to any other, and checkable via fsck. So we ought to be
avoiding confusing terminology.

Philip

[1] Maybe the default can be called be anonymised to "ref0"
<nycvar.QRO.7.76.6.2006131645380.56@tvgsbejvaqbjf.bet>
