Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9524C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 10:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD035206D7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 10:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgFNKyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 06:54:21 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:8490 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbgFNKyV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 06:54:21 -0400
Received: from host-89-243-191-101.as13285.net ([89.243.191.101] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jkQHL-0001rL-7S; Sun, 14 Jun 2020 11:54:19 +0100
Subject: Re: Rename offensive terminology (master)
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
 <20200611115215.GQ21462@kitsune.suse.cz>
 <CAGA3LAfpoXDQryOPGg3g-4brpUcSAhL_2VOw8oy6D2ffp64hag@mail.gmail.com>
 <f27450d8-59a1-dc0b-f741-c8c883b95fe0@gmail.com>
 <bef39243-806f-7c4a-c3d1-f3500ec377be@iee.email>
 <CABPp-BHF7KDLw7_VtSokpOuOr_tX2DTNu31B58P83R3HK=YVvA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
Date:   Sun, 14 Jun 2020 11:54:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHF7KDLw7_VtSokpOuOr_tX2DTNu31B58P83R3HK=YVvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/06/2020 01:41, Elijah Newren wrote:
> On Fri, Jun 12, 2020 at 6:23 AM Philip Oakley <philipoakley@iee.email> wrote:
>> On 11/06/2020 13:52, Derrick Stolee wrote:
>>> On 6/11/2020 7:59 AM, Don Goodman-Wilson wrote:
>>>> On Thu, Jun 11, 2020 at 1:52 PM Michal Suchánek <msuchanek@suse.de> wrote:
>>>>> Indeed, the flexibility to choose the name of the default branch can be
>>>>> helpful for projects with specific naming, especially non-english
>>>>> speaking projects.
>>>>>
>>>>> To that end I would suggest adding -b argument to git init to be able to
>>>>> choose the default branch name per project. This should select the
>>>>> initial branch name and also write the it as the default branch name in
>>>>> the repo configuration (if git continues to treat the default branch
>>>>> specially).
>>>>>
>>>>> This can be used in documentation to use the new name immediately
>>>>> without breaking existing workflows that rely on the 'master' branch.
>>>> I _really_ like this idea (and your reasoning). Seconded.
>>> Yes, adding a -b|--branch option would be an excellent addition to
>>> the config option.
>>>
>>>
>> Is their also an option to also add an option to `git clone` to (re)set
>> the default branch name offered by the upstream to that provided?
>>
>> Alternatively provide a `--no-checkout` option for the clone so that
>> either no actual checkout is performed, or maybe that a detached head
>> checkout is performed so that users can name their default branch
>> appropriately.
> Good news: git clone already has a `--no-checkout` option (with `-n`
> being the short option form for it).
Thanks. The man description "and creates and checks out an initial
branch that is forked from the cloned repository’s currently active
branch" had me initially fooled.

I did see the option after posting, but IIUC there is still the default
branch name linkage that could be resolved.

Philip
