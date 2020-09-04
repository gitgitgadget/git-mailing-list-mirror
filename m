Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A066EC43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A627206B8
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgIDOPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:15:08 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40042 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730348AbgIDOPB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 10:15:01 -0400
Received: from host-92-30-127-66.as13285.net ([92.30.127.66] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kECUT-0002La-3R; Fri, 04 Sep 2020 15:14:57 +0100
Subject: Re: Git in Outreachy?
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com>
 <20200903060041.GH4035286@google.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <a3613b9d-730a-7a4b-c84b-c833490fcea6@iee.email>
Date:   Fri, 4 Sep 2020 15:14:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903060041.GH4035286@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/2020 07:00, Jonathan Nieder wrote:
> Hi,
>
> Christian Couder wrote:
>
>> I would appreciate help to find project ideas though. Are there still
>> scripts that are worth converting to C (excluding git-bisect.sh and
>> git-submodule.sh that are still worked on)? Are there worthy
>> refactorings or improvements that we could propose as projects?
> I think setting up something like snowpatch[*] to run CI on patches
> that have hit the mailing list but not yet hit "seen" might be a good
> project for an interested applicant (and I'd be interested in
> co-mentoring if we find a taker).
>
> Some other topics that could be interesting:
> - better support for handling people's name changing
> - making signing features such as signed push easier to use (for
>   example by allowing signing with SSH keys to simplify PKI) and more
>   useful (for example by standardizing a way to publish signed push
>   logs in Git)
> - protocol: sharing notes and branch descriptions
> - formats: on-disk reverse idx
> - obliterate
> - cache server to take advantage of multiple promisors+packfile URIs
>
> Jonathan
>
> [*] https://github.com/ruscur/snowpatch
A suggestion with high value for the Windows community
- mechanism to map file names between the index and the local FS, should
a repos file/path name already be taken, or invalid. [1]

Philip

[1]
https://github.com/git-for-windows/git/issues/2803#issuecomment-687161483
