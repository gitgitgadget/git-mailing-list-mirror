Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B3C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 20:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJNUUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiJNUT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 16:19:59 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A307F21E05
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 13:19:57 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ojR9v-0007km-3c;
        Fri, 14 Oct 2022 21:19:55 +0100
Message-ID: <692dbb0d-a3f9-7e12-c868-fffc8df4678b@iee.email>
Date:   Fri, 14 Oct 2022 21:19:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] [OUTREACHY] t1002: modernize outdated conditional
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
References: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
 <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
 <xmqqv8om9yaz.fsf@gitster.g>
 <f064ce46-8ed0-a9c1-8df5-5c258677d95f@github.com>
 <CAPig+cT=bJ7BP9CDh5-oYYF376vVxsh7E0UAE_QN0wfAgR3AAg@mail.gmail.com>
 <xmqqh7068bta.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqh7068bta.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/10/2022 20:06, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Fri, Oct 14, 2022 at 12:35 PM Derrick Stolee
>> <derrickstolee@github.com> wrote:
>>> On 10/14/2022 12:15 PM, Junio C Hamano wrote:
>>>> "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>>> Cc: Christian Couder  <christian.couder@gmail.com>
>>>>> Cc: Hariom Verma <hariom18599@gmail.com>
>>>> What are these C: lines for?  I do not think the message I am
>>>> responding to is Cc'ed to them.  There may be a special incantation
>>>> to tell GitGitGadget to Cc to certain folks, but adding Cc: to the
>>>> log message trailer like this does not seem to be it---at least it
>>>> appears that it did not work that way.
>>> GitGitGadget will read the "cc:" lines from the end of the pull request
>>> description, not the commit messages. I'm pretty sure they will be
>>> ignored if there are other lines after them.
>> For Wilberforce's edification for future submissions, presumably the
>> reason that the CC: in the pull-request's description didn't work is
>> because the CC: line wasn't the last line in the description? Does
>> there need to be a blank line before the CC: line? Is it okay to list
>> multiple people on the same CC: line as done in this case, or is that
>> also a problem?
> Ah, now I can see why the round v4 is CC'ed to you and Derrick on
> the list.  The pull-request text (visible in GitHub UI in the top
> most box of https://github.com/git/git/pull/1362) ends with two
> lines of cc: that list you two.  The one named Christian and Hariom
> were not at the end and was ignored by GGG, it seems.
>
I just want to throw in that because GitHub takes the PR & comitts
verbatim, but Git itself works via email, you can add description
portions to commits, and I believe the PR part, by add a line containing
just three dashes `---` followed by the additional descriptive note text
which won't be used when `am` (apply mailbox) is used.

I've certainly used that technique when sending patches. See the "Bonus
Chapter: One-Patch Changes" in MyFirstContribution.txt
--
Philip
