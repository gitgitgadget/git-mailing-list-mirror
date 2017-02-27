Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F114F1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 14:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbdB0O2h (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 09:28:37 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53528 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751356AbdB0O2g (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Feb 2017 09:28:36 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 27A0820AB6;
        Mon, 27 Feb 2017 09:28:35 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 27 Feb 2017 09:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=vaLShqgCY7P21fk
        RPGlNWBRsfQU=; b=N+10/JsMDg8AqTGUbeMkXBspqJ9nm9PuSanbsYciL3shxi5
        DcPM1u6Ls6+/zMf+hzZaxoZ+QPOKZLJKt3/2/ciVjjdPYT3L6Z5ZECqufoID0Us4
        S0fFMyOLQknv2h9hx0nCfEiI7X4agOAds5IGHgQoI83bgJsMCkIRAehKUb7o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=vaLShqgCY7P21fkRPGlNWBRsfQU=; b=goFFnfVrYsE8AU6faFTf
        do4XZ0iWtHmTiy8mkV6gQFCM+2FxioOtPiwXZ/MCvuFpIJPj0aFL178P43xp8tzR
        foC7fLhC9gvSJWduVDZkOo1otgO5rnkfD9JNqfheB1GHXuPDD6gFK7FOIxrx/Z2N
        PPmwP0grV2RTs0NlNGnQGeM=
X-ME-Sender: <xms:kze0WAQdPorsecidajcjNC8gsTtumF4fpubole-IRec33qfCMBGCJw>
X-Sasl-enc: H6EV276f/2ub/x39bW+Hi7KCn4oSAJc/fA8+xN+P+TA3 1488205714
Received: from UltraSam.fritz.box (dslb-188-096-114-130.188.096.pools.vodafone-ip.de [188.96.114.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5474241EA;
        Mon, 27 Feb 2017 09:28:33 -0500 (EST)
Subject: Re: show all merge conflicts
To:     "G. Sylvie Davies" <sylvie@bit-booster.com>,
        Jeff King <peff@peff.net>
References: <CANwu5-o=3p8QfWo9wQvok=UZESRVtF3Uxb3nEMZVv8AvkKYYGw@mail.gmail.com>
 <20170127175151.srhhczliqgvbzcre@sigill.intra.peff.net>
 <CAAj3zPzO4+9t9_L2OXFmkihw-HwFvzybb7GXs4tTeFRyZHOaNQ@mail.gmail.com>
 <20170128142808.hefnv7r3h6zidobw@sigill.intra.peff.net>
 <CAAj3zPx5fKHUTLLEuuZjmq+H5somp980j0hqWjmLyvLuk709GQ@mail.gmail.com>
Cc:     Michael Spiegel <michael.m.spiegel@gmail.com>, git@vger.kernel.org
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <6ff25254-720e-5b85-ba6d-22b16e91b354@drmicha.warpmail.net>
Date:   Mon, 27 Feb 2017 15:28:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAAj3zPx5fKHUTLLEuuZjmq+H5somp980j0hqWjmLyvLuk709GQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

G. Sylvie Davies venit, vidit, dixit 29.01.2017 07:45:
> On Sat, Jan 28, 2017 at 6:28 AM, Jeff King <peff@peff.net> wrote:
>> On Fri, Jan 27, 2017 at 09:42:41PM -0800, G. Sylvie Davies wrote:
>>
>>> Aside from the usual "git log -cc", I think this should work (replace
>>> HEAD with whichever commit you are analyzing):
>>>
>>> git diff --name-only HEAD^2...HEAD^1 > m1
>>> git diff --name-only HEAD^1...HEAD^2 > b1
>>> git diff --name-only HEAD^1..HEAD    > m2
>>> git diff --name-only HEAD^2..HEAD    > b2
>>>
>>> If files listed between m1 and b2 differ, then the merge is dirty.
>>> Similarly for m2 and b1.
>>>
>>> More information here:
>>>
>>> http://stackoverflow.com/questions/27683077/how-do-you-detect-an-evil-merge-in-git/41356308#41356308
>>
>> I don't think that can reliably find evil merges, since it looks at the
>> file level. If you had one hunk resolved for "theirs" and one hunk for
>> "ours" in a given file, then the file will be listed in each diff,
>> whether it has evil hunks or not.
>>
> 
> Well, you have to do both.  Do "git show -c" to catch that one
> ("theirs" for one hunk, "ours" for the other, same file).
> 
> And then do that sequence of the 4 "git diff" commands to identify
> dirty merges where "theirs" or "ours" was applied to entire files, and
> thus not showing up in the "git show -c".
> 
>> I don't think this is just about evil merges, though. For instance,
>> try:
>>
>>   seq 1 10 >file
>>   git add file
>>   git commit -m base
>>
>>   sed s/4/master/ <file >tmp && mv tmp file
>>   git commit -am master
>>
>>   git checkout -b other HEAD^
>>   sed s/4/other/ <file >tmp && mv tmp file
>>   git commit -am other
>>
>>   git merge master
>>   git checkout --ours file
>>   git commit -am merged
>>
>>   merge=$(git rev-parse HEAD)
>>
>> The question is: were there conflicts in $merge, and how were they
>> resolved?
>>
>> That isn't an evil merge, but there's still something interesting to
>> show that "git log --cc" won't display.
>>
>> Replaying the merge like:
>>
>>   git checkout $merge^1
>>   git merge $merge^2
>>   git diff -R $merge
>>
>> shows you the patch to go from the conflict state to the final one.
>>
> 
> I know the stackoverflow question asks "how to detect evil merges",
> and I go along with that in my answer.  But honestly I prefer to call
> them dirty rather than evil, and by "dirty" I just mean merges that
> did not resolve cleanly via "git merge", and had some form of user
> intervention, be it conflict resolution, or other strange things.
> 
> The trick I propose with the sequence of 4 "git diff" commands
> identifies that merge from your example as dirty:
> 
> $ cat b1 m2
> file
> 
> $ cat b2 m1
> file
> file
> 
> The trick doesn't really tell you much except that the merge is dirty.
> If you notice that the "m2" file is empty, I think that's one way to
> realize that master's edit was dropped, and therefore "other" won.
> 
> Maybe it even merged cleanly but someone did a "git commit --amend" to
> make it the merge dirty after the fact.
> 
> I do like your approach, it's very simple and reliable.  But in my
> situation I'm writing pre-receive hooks for bare repos, so I don't
> think I can actually do "git merge"!
> 
> I think my suggestion would work for OP, as long as they also run "git
> show -c" alongside it.   (And your suggestion would work, too, of
> course).

If you're curious, I kept rebasing Thomas' remerge-diff (on top of our
next) so far. You can find it at

https://github.com/mjg/git/tree/remerge-diff

if you're interested. I don't know what problems were found back then,
or what it would take to get this in-tree now.

Michael

