Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FC9C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889C920663
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgFOLbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:31:52 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:32291 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgFOLbw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 07:31:52 -0400
Received: from host-89-243-191-101.as13285.net ([89.243.191.101] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jknLC-0007SP-Dt; Mon, 15 Jun 2020 12:31:50 +0100
Subject: Re: Collaborative conflict resolution feature request
To:     "Curtin, Eric" <Eric.Curtin@dell.com>,
        Konstantin Tokarev <annulen@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney, Stephen" <Stephen.Coveney@Dell.com>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com> <30661592138737@mail.yandex.ru>
 <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c4ebf430-a69d-3d46-bfb9-37c9ece9f519@iee.email>
Date:   Mon, 15 Jun 2020 12:31:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/06/2020 10:28, Curtin, Eric wrote:
> I think in order to create collaborative distributed conflict resolution,
> you'd probably need a new type of commit a "partial-merge" commit,
> that is like a pseudo-commit that you can push and doesn't break
> builds. It would be a neat feature, at least for my team!
One thing I did note, from your prompting, is that merge doesn't take
any `-- <files>` options which could allow a quick way of selecting just
the few files that you, or the specific dev, is able to merge, so as to
create a partial merge on your side branch, and leave behind the
remaining difficult conflicts to be resolved later by the appropriate
dev in a sequence of rolling partial merges.

It could be effectively a special strategy. IIUC the '--' separator is
already supported by the underlying parser code, so may not be that
hard? (perhaps a local contribution to the codebase;-). Just a thought.

Philip
