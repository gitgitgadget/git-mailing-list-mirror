Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BD7C433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 23:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691E720780
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 23:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=whinis.com header.i=@whinis.com header.b="S9NzJ+a0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGBXGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:06:16 -0400
Received: from whinis.com ([198.205.115.165]:35684 "EHLO whinis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgGBXGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 19:06:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by whinis.com (Postfix) with ESMTP id C1BF97C51E8;
        Thu,  2 Jul 2020 19:06:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whinis.com; s=mail;
        t=1593731174; bh=ym17ZhhKAeBwW0R76Rk8qnNHON2RG760ADNJSPrITxY=;
        h=To:Cc:References:Subject:From:Date:In-Reply-To;
        b=S9NzJ+a01YoiRy28D5E5Ay96mb/PQXOVS6rq8Cw07ZrHAz1IWA1xoLN57ERVSHGop
         FvwKuuKwDi/AiYRKUE0nHxKfFVuKpYdypeWkYOXmm3Vz8KTlgSZJYD1NATViDpNZe0
         Y7Bo0mvz9YaTzxFOiBo8QaFM9I8rvNiPX/IU5m/Q=
X-Virus-Scanned: Debian amavisd-new at whinis.com
Received: from whinis.com ([127.0.0.1])
        by localhost (asgard.whinis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gCc06cekauqe; Thu,  2 Jul 2020 19:06:13 -0400 (EDT)
Received: from [10.129.128.188] (unknown [129.171.6.200])
        by whinis.com (Postfix) with ESMTPSA id AA8FD7C51C3;
        Thu,  2 Jul 2020 19:06:12 -0400 (EDT)
To:     philipoakley@iee.email
Cc:     Whinis@whinis.com, bturner@atlassian.com, git@vger.kernel.org,
        james@jramsay.com.au, me@ttaylorr.com, msuchanek@suse.de,
        peff@peff.net
References: <6998b083-fbdf-03e9-8633-d57123f1f0de@iee.email>
Subject: Re: Consensus on a new default branch name
From:   Whinis <Whinis@whinis.com>
Message-ID: <66d8c2fe-266c-f6b4-447c-bbe3eedc78ed@whinis.com>
Date:   Thu, 2 Jul 2020 19:08:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6998b083-fbdf-03e9-8633-d57123f1f0de@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The point there was that it was, at the time, a complaint that had a
> response which was passed into the community.
Right but as is the case here of a likely either malicious requests or 
an offhand comment leading to disproportionate response just as I 
believe this started due to a wallstreet journal article inflating a 
pair of terms used for over 100 years as racists simply due to being used.

> It's the *misuse* that's racist
Are you saying using the word master is racists? Are you aware of the 
origins of the term and how far back it goes? or that mister is also a 
mutation of the same word? Cause that a rather high bar to state 
considering its use not just in programing or engineering but also 
things such as master degree and master copy. Its also rather odd 
considering that suggestion that master alone is racists from what I can 
tell started only with this git issue.

> The original US case was with reference to the joint use of
> master-slave. That Jstor article may be behind a log-in wall, so I
> extracted from the essay, for immediate readers, some of the initial
> uses of that term pair in engineering.
That's fair, I have a university subscription and have seen that article 
a few times. Its ultimately a first pass article that someone could take 
further but should in no way be used as proof that this was the first 
use of this pair. Also the pair does not exists in this case so its a 
rather odd citation.

> It's that Git is *distributed*, rather than a single central source of
> truth that old version control systems used. I remember the smell of
> blueprints, and of kaolin & linen master drawings (unique works of art,
> protected and valued). That has all gone. It now a case of validating
> the copy you have same hash. The chain of evidence has reversed.
Sure, how does that impact the use of the word master? its the branch 
name as in the branch, as described by the person that picked the name, 
of the master copy. Git being distributed has nothing todo with the branch

> Gits choice is only 15 years old.  There have been other changes to Git,
> and the forthcoming hash change is much more of an 'impacts everyone'
> change. Any direction of travel always includes some changes, generally
> for the better.
Framing moving large sections of words out of use that have been in 
common use for at least 100 years in a technical sense and has no racial 
connection or common racial usage seems a rather odd thing to consider 
progress. I would view people developing non-existent connections 
between words just as the snopes articles showed is a step backwards and 
shows a lack of education on words. If you first  thought with seeing a 
word is how can it offend someone it might be difficult to work around. 
If anything you are inflating problems that don't actually exists.


-Whinis

