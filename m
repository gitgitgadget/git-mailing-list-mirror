Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF79C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 13:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A016B2074B
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 13:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgFLNVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:21:39 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:25643 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgFLNVj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 09:21:39 -0400
Received: from host-89-243-191-101.as13285.net ([89.243.191.101] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jjjcm-00053x-4L; Fri, 12 Jun 2020 14:21:36 +0100
Subject: Re: Rename offensive terminology (master)
To:     Derrick Stolee <stolee@gmail.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
 <20200611115215.GQ21462@kitsune.suse.cz>
 <CAGA3LAfpoXDQryOPGg3g-4brpUcSAhL_2VOw8oy6D2ffp64hag@mail.gmail.com>
 <f27450d8-59a1-dc0b-f741-c8c883b95fe0@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <bef39243-806f-7c4a-c3d1-f3500ec377be@iee.email>
Date:   Fri, 12 Jun 2020 14:21:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f27450d8-59a1-dc0b-f741-c8c883b95fe0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/06/2020 13:52, Derrick Stolee wrote:
> On 6/11/2020 7:59 AM, Don Goodman-Wilson wrote:
>> On Thu, Jun 11, 2020 at 1:52 PM Michal Suchánek <msuchanek@suse.de> wrote:
>>> Indeed, the flexibility to choose the name of the default branch can be
>>> helpful for projects with specific naming, especially non-english
>>> speaking projects.
>>>
>>> To that end I would suggest adding -b argument to git init to be able to
>>> choose the default branch name per project. This should select the
>>> initial branch name and also write the it as the default branch name in
>>> the repo configuration (if git continues to treat the default branch
>>> specially).
>>>
>>> This can be used in documentation to use the new name immediately
>>> without breaking existing workflows that rely on the 'master' branch.
>> I _really_ like this idea (and your reasoning). Seconded.
> Yes, adding a -b|--branch option would be an excellent addition to
> the config option.
>
>
Is their also an option to also add an option to `git clone` to (re)set
the default branch name offered by the upstream to that provided?

Alternatively provide a `--no-checkout` option for the clone so that
either no actual checkout is performed, or maybe that a detached head
checkout is performed so that users can name their default branch
appropriately.

In some cases a true --no-checkout may be the 'best' thing to do to
avoid the user mental model confusion about needing to have a local
branch matching an upstream branch before they can start their work on
top of it (hopefully with a fresh branch name).

Philip
