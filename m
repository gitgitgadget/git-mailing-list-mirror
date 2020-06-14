Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EDC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 11:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11AC3204EC
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 11:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgFNLF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 07:05:26 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:46840 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgFNLFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 07:05:17 -0400
Received: from host-89-243-191-101.as13285.net ([89.243.191.101] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jkQRv-000346-B1; Sun, 14 Jun 2020 12:05:15 +0100
Subject: Re: Collaborative conflict resolution feature request
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     "Curtin, Eric" <Eric.Curtin@dell.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com>
 <xmqq366yzrn1.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1dd94931-83ac-4036-2317-0f3aa166d61c@iee.email>
Date:   Sun, 14 Jun 2020 12:05:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq366yzrn1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/06/2020 20:34, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> ...  Luckily, most end users would get their Git from
>> packagers and they are good at doing the bundling (i.e. the
>> "git-core" package may "suggest" the "git-imerge" package).
>>
>> So...
> So my answer to your idea/opinion is that we shouldn't waste
> engineering effort to "have something like imerge integrated into
> git itself", but we should help distro packages to do the bundling
> of "git" itself and all the good things around it.  One way of doing
> it may be by keeping an official curated list of "third-party things
> we find good" somewhere (it can be in-tree in my release tarballs,
> but it does not have to be---some page on git-scm.com could just be
> fine; as long as the quality of the list is maintained to our
> standards, where the packagers and end users see it does not really
> matter).
>
> And such a list would also help those who prefer to build and
> install things by hand.

For the imerge tool, it may be worth having an extra sub-heading (Merge
Tools?) within the "HOW TO RESOLVE CONFLICTS" section of the git-merge
man page.

The merge.guitool configuration does list a lot of pre-configured tools
(the list could be moved to the mergetool man page?)

Curating the list of tools maybe could be done in the same way the
config entries are now being done, i.e. by area, so they can be included
in the relevant man pages, with just a single source of 'nice tools'.

Philip
