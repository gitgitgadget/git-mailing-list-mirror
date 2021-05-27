Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F2DC4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 15:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4F461358
	for <git@archiver.kernel.org>; Thu, 27 May 2021 15:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhE0POX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 11:14:23 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:24520 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236929AbhE0POQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 11:14:16 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lmHgf-0003iG-5M; Thu, 27 May 2021 16:12:42 +0100
Subject: Re: fast forward merge overwriting my code
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
 <60adb824bac10_2c7f620844@natae.notmuch>
 <da77d0a0-7fdb-e4c8-6510-87ea0294dac4@iee.email>
 <60ae947797deb_25ba2089c@natae.notmuch>
 <6dcc8557-9df4-9ea2-c348-f4ebf76ff446@iee.email>
 <60aedb22c075e_4bd420896@natae.notmuch>
 <02bbe080-cd8a-cc7d-5dbc-9231b51c4baf@iee.email>
 <60afa5e07bcd9_2056d2084d@natae.notmuch>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <90579aaf-2fa6-4641-29e2-43711ccafb86@iee.email>
Date:   Thu, 27 May 2021 16:12:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60afa5e07bcd9_2056d2084d@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/05/2021 15:00, Felipe Contreras wrote:
> Philip Oakley wrote:
>> On 27/05/2021 00:34, Felipe Contreras wrote:
>>> Yes, but that is a separate issue.
>>>
>>> Right now they are able to resolve conflicts with a jupyter mergetool.
>> I don't believe that ("resolve") is true in the sense they would like. I
>> don't think they are really 'merging' in an all-in-one `git merge`
>> sense, rather they are [trying to] splitting and patching and commenting
>> the changes.
> He explicitly mentioned a merge, but ultimately it doesn't matter, the
> mergetool can be used in other scenarios, like `git am`.

True, though I see the server side aspects as also an important part of
the process pain.
>
> I did try to setup those tools, nbdime does setup a merge tool [1].
>
> Cheers.
>
> [1] https://nbdime.readthedocs.io/en/latest/
>
Thanks for that reference. I did like that the picture of the 'problem'
example was the same as the nbdime diff's solution ;-) [1]

The article does give a good start for thinking about the wider diffing
& merging problems for tools with more complex conceptual 'abstract
syntax trees'  and file representations.

Philip
[1] https://nbdime.readthedocs.io/en/latest/_images/nbdiff-web.png
